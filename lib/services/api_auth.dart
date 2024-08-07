import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

import 'package:dio/dio.dart';
import '../generated/l10n.dart';
import '../models/response_file_upload.dart';
import '../models/response.dart';
import '../services/api_service.dart';
import '../constants/regex_text.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

import '../utils/error_handler.dart';
import 'api_ho_service.dart';

class APIAuth {
  static Future<oauth2.Client?> signIn({
    required BuildContext context,
    required String username,
    required String password,
    ErrorHandleFunc? onError,
    bool remember = false,
  }) async {
    var user = username;
    if (RegexText.isEmail(username)) {
      await findUserNameByEmail(email: username).then((v) {
        user = v;
      }).catchError((e) {
        onError!.call(e);
      });
      // if (data != null) {
      //   user = data['userName'];
      // }
    } else {
      // await getUserInformationByUsername(user).then((v) {}).catchError((e) {
      //   throw (e);
      // });
    }

    return await ApiService.shared.getClient(
      username: user,
      password: password,
      onError: onError,
      context: context,
      remember: remember,
    );
  }

  static getAccountInfo() async {
    var query = '''
    mutation {
        response: account_get_account_info  {
            code
            message
            data
        }
    }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future resetPassword(String userName, String newPassword) async {
    var query = '''
    mutation (\$userName:String,\$newPassword:String){
    response: authorization_reset_password (userName: \$userName,newPassword: \$newPassword ) {
        code
        message
        data
    }
}
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'userName': userName,
        'newPassword': newPassword,
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future sendOTPviaPhone(String phone) async {}

  static Future getUserInformationByUsername(String phone) async {
    var findAccountQuery = '''
    mutation (\$phone:String){
        response: account_mobile_find_user_info_by_phone (phone: \$phone ) {
            code
            message
            data
        }
    }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(findAccountQuery),
      variables: {
        'phone': phone,
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future verifyOtp(String otp, String sendTo) async {
    var query = '''
    mutation (\$otp:String,\$sendTo:String){
        response: authorization_veryfyOTP (otp: \$otp,sendTo: \$sendTo ) {
            code
            message
            data
        }
    }
            
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'otp': otp,
        'sendTo': sendTo,
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future sendOtpViaEmail(String email) async {
    var sendOtp = '''
  mutation (\$mailTo: String) {
  response :authorization_generate_otp(mailTo: \$mailTo){
    code
    message
    data
    }
  }
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(sendOtp),
      variables: {
        'mailTo': email,
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future<void> signOut({
    ErrorHandleFunc? onError,
    required BuildContext context,
  }) async {
    return await ApiService.shared.deleteCre();
  }

  static Future<List<ResponseFileUpload>> uploadSingleFile({
    required List<File> files,
    OnSendProgress? onSendProgress,
    BuildContext? context,
  }) async {
    List<ResponseFileUpload> results = [];
    if (files.isNotEmpty) {
      for (var i = 0; i < files.length; i++) {
        if (files[i].lengthSync() >= 15728640) {
          throw (S.current.not_upload_15mb);
        }
        final mpf = await MultipartFile.fromFile(files[i].path);
        final map = {
          'file': [mpf],
          'name': files[i].path.split('/').last,
        };
        final body = FormData.fromMap(map);
        final data = await ApiService.shared.postApi(
          path: ApiService.shared.uploadURL, // ApiConstants.uploadURL,
          data: body,
          onSendProgress: onSendProgress,
          name: files[i].path.split('/').last,
          accessToken: ApiService.shared.access_token,
        );

        var file = ResponseFileUpload.fromJson(data);
        if (file.data == null) {
          throw (S.current.err_upload);
        }
        results.add(file);
      }
    }
    return results;
  }

  static Future<ResponseFileUpload> uploadImage({
    required List<File> files,
    OnSendProgress? onSendProgress,
    required BuildContext context,
  }) async {
    final multipartFiles = <MultipartFile>[];
    for (var i = 0; i < files.length; i++) {
      final mpf = await MultipartFile.fromFile(files[i].path);
      multipartFiles.add(mpf);
    }

    final map = {'files': multipartFiles};
    final body = FormData.fromMap(map);
    final data = await ApiService.shared.postApi(
      path: ApiService.shared.uploadURL, // ApiConstants.uploadURL,
      data: body,
      onSendProgress: onSendProgress,
      accessToken: ApiHOService.shared.access_token,
    );
    // print(data);
    return ResponseFileUpload.fromJson(data);
  }

  static Future findUserNameByEmail({required String email}) async {
    var query = '''
    mutation (\$email:String ){
	response: resident_mobile_resident_find_phone_by_email  (email:\$email) {
		code
		message
		data
	}
}
    ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'email': email,
      },
    );
    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message!);
    } else {
      return res.response.data;
    }
  }

  static Future createResidentAccount({
    required BuildContext context,
    required String user,
    required String name,
    required String email,
    required String passWord,
    required String confirmPassword,
  }) async {
    var mutationCreateResidentAccount = '''
      mutation (\$name:String,\$password:String,\$email:String,\$confirmPassword:String,\$user:String){
    response: resident_mobile_create_resident_account (name: \$name,password: \$password,email: \$email,confirmPassword: \$confirmPassword,user: \$user ) {
        code
        message
        data
    }
}
        
     
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutationCreateResidentAccount),
      variables: {
        'user': user,
        'name': name,
        'email': email,
        'password': passWord,
        'confirmPassword': confirmPassword,
      },
    );

    final data = await ApiService.shared.mutationhqlQuery(options);
    var res = ResponseModule.fromJson(data);
    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return (res.response.data);
    }
  }

  static Future changePassword(
    String oldPass,
    String newPass,
    String confirmNewPass,
    String? accountId,
  ) async {
    var mutation = '''
     mutation (\$oldPass:String,\$newPass:String,\$confirmNewPass:String,\$accountId:String){
    response: authorization_mobile_change_password (oldPass: \$oldPass,newPass: \$newPass,confirmNewPass: \$confirmNewPass,accountId:\$accountId ) {
        code
        message
        data
    }
    }

    ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'oldPass': oldPass,
        'newPass': newPass,
        'confirmNewPass': confirmNewPass,
        'accountId': accountId,
      },
    );

    final data = await ApiService.shared.mutationhqlQuery(options);
    var res = ResponseModule.fromJson(data);
    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return (res.response.data);
    }
  }

  static Future saveAccount(
    Map<String, dynamic> dat,
  ) async {
    var mutation = '''
    mutation (\$data: AccountInputDto){
	response:save_Account_dto(data:\$data){
		message
		code
		data {
			_id
		}
    }
  }

    ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'data': dat,
      },
    );

    final data = await ApiService.shared.mutationhqlQuery(options);
    var res = ResponseModule.fromJson(data);
    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return (res.response.data);
    }
  }

  static Future sendOtpAddMoreEmail(
    String email,
    bool isNew,
    String accountId,
  ) async {
    var sendOtp = '''
mutation (\$email:String,\$isNew:Boolean,\$accountId:String){
    response: authorization_mobile_send_OTP_add_email (email: \$email,isNew: \$isNew,accountId: \$accountId ) {
        code
        message
        data
    }
}
        
        
        
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(sendOtp),
      variables: {
        'email': email,
        "isNew": isNew,
        "accountId": accountId,
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future verifyOtpAddMoreEmail(
    String email,
    String accountId,
    String otp,
  ) async {
    var sendOtp = '''
mutation (\$email:String,\$accountId:String,\$otp:String){
    response: authorization_mobile_verify_add_email (email: \$email,accountId: \$accountId,otp: \$otp ) {
        code
        message
        data
    }
}
        
        
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(sendOtp),
      variables: {
        'email': email,
        'accountId': accountId,
        'otp': otp,
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }
}
