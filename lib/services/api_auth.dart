import 'dart:io';

// import 'package:graphql/client.dart';

import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

import '../constants/api_constant.dart';
import 'package:dio/dio.dart';
import '../models/response_file_upload.dart';
import '../models/response_register.dart';
import '../models/response.dart';
import '../models/response_user.dart';
import '../services/api_service.dart';
import '../constants/regex_text.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class APIAuth {
  static Future<oauth2.Client?> signIn({
    required BuildContext context,
    required String username,
    required String password,
    ErrorHandle? onError,
    bool remember = false,
  }) async {
    var user = username;
    if (RegexText.isEmail(username)) {
      var data = await findUserNameByEmail(email: username);
      if (data['resident_resident_find_phone_by_email']['data'] != null) {
        user = data['resident_resident_find_phone_by_email']['data'];
      }
    }

    return await ApiService.shared.getClient(
        username: user,
        password: password,
        onError: onError,
        context: context,
        remember: remember);
  }

  static Future getUserInformationByUsername(String phone) async {
    var findAccountQuerry = '''
    mutation (\$phone:String){
        response: account_find_email_by_phone (phone: \$phone ) {
            code
            message
            data
        }
    }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(findAccountQuerry),
      variables: {
        "phone": phone,
      },
    );

    final data = await ApiService.shared.mutationhqlQuery(options);
    return data;
  }

  static Future<ResponseRegister> verifyOTP({
    required BuildContext context,
    required String phoneNum,
    required String otp,
  }) async {
    final body = {"phoneNumber": phoneNum, "Otp": otp};
    final data = await ApiService.shared.postApi(
        path: 'api/mobile/verifyOtp',
        useToken: false,
        data: body,
        context: context);
    // print(data);
    return ResponseRegister.fromJson(data);
  }

  static Future<void> signOut(
      {ErrorHandle? onError, required BuildContext context}) async {
    return await ApiService.shared.deleteCre();
  }

  static Future<ResponseUser> getUserInfo(BuildContext context) async {
    final data = await ApiService.shared.getApi(
      path: 'api/mobile/userinfo',
    );
    // print(data);
    return ResponseUser.fromJson(data);
  }

  static Future<ResponseFileUpload> uploadImage(
      {required List<File> files,
      OnSendProgress? onSendProgress,
      required BuildContext context}) async {
    final multipartFiles = <MultipartFile>[];
    for (var i = 0; i < files.length; i++) {
      final mpf = await MultipartFile.fromFile(files[i].path);
      multipartFiles.add(mpf);
    }

    final map = {"files": multipartFiles};
    final body = FormData.fromMap(map);
    final data = await ApiService.shared.postApi(
        path: 'api/media',
        data: body,
        onSendProgress: onSendProgress,
        context: context);
    // print(data);
    return ResponseFileUpload.fromJson(data);
  }

  static Future<ResponseRegister> updateUserInfo(
      {required BuildContext context,
      String? email,
      String? userName,
      String? company,
      String? avatarLink,
      String? birthday,
      String? sex,
      String? cmnd,
      String? national}) async {
    final body = {};
    if (email != null && email.isNotEmpty) body['email'] = email;
    if (userName != null && userName.isNotEmpty) body['userName'] = userName;
    if (company != null && company.isNotEmpty) body['congTy'] = company;
    if (avatarLink != null && avatarLink.isNotEmpty) {
      body['avatarLink'] = avatarLink;
    }
    if (birthday != null && birthday.isNotEmpty) body['birthday'] = birthday;
    if (sex != null && sex.isNotEmpty) body['sex'] = sex;
    if (cmnd != null && cmnd.isNotEmpty) body['cmnd'] = cmnd;
    if (national != null && national.isNotEmpty) body['national'] = national;

    //print(body);
    final data = await ApiService.shared
        .postApi(path: 'api/mobile/updateInfo', data: body, context: context);
    // print(data);
    return ResponseRegister.fromJson(data);
  }

  static Future<ResponseRegister> changePass(
      {required BuildContext context,
      required String phoneNum,
      required String oldPass,
      required String newPass}) async {
    final body = {
      "phoneNumber": phoneNum,
      "OldPassWord": oldPass,
      "NewPassWord": newPass
    };
    final data = await ApiService.shared.postApi(
        path: 'api/mobile/changePassword', data: body, context: context);
    // print(data);
    return ResponseRegister.fromJson(data);
  }

  static Future<ResponseRegister> forgotPass({
    required String phoneNum,
    required BuildContext context,
  }) async {
    final body = {
      "PhoneNumber": phoneNum,
    };
    final data = await ApiService.shared.postApi(
        path: 'api/mobile/forgotPassword',
        useToken: false,
        data: body,
        context: context);
    // print(data);
    return ResponseRegister.fromJson(data);
  }

  static Future<ResponseRegister> generateToken(
      {required BuildContext context,
      required String phoneNum,
      required String otp}) async {
    final body = {"PhoneNumber": phoneNum, "Otp": otp};
    final data = await ApiService.shared.postApi(
        path: 'api/mobile/generateToken',
        useToken: false,
        data: body,
        context: context);
    // print(data);
    return ResponseRegister.fromJson(data);
  }

  static Future<ResponseRegister> resetPass({
    required BuildContext context,
    required String phoneNum,
    required String token,
    required String newPass,
    required String confirmPass,
  }) async {
    final body = {
      "PhoneNumber": phoneNum,
      "Token": token,
      "NewPassWord": newPass,
      "ConfirmPassword": confirmPass
    };
    final data = await ApiService.shared.postApi(
        path: 'api/mobile/resetPassword',
        useToken: false,
        data: body,
        context: context);
    // print(data);
    return ResponseRegister.fromJson(data);
  }

  static Future findUserNameByEmail({required String email}) async {
    var querry = '''
    mutation (\$email:String ){
	resident_resident_find_phone_by_email(email:\$email) {
		code
		message
		data
	}
}
    ''';
    final MutationOptions options = MutationOptions(
      document: gql(querry),
      variables: {
        "email": email,
      },
    );

    final data = await ApiService.shared.mutationhqlQuery(options);
    return data;
  }

  static Future<ResponseRegister> createResidentAccount(
      {required BuildContext context,
      required String user,
      required String name,
      required String email,
      required String passWord,
      required String confirmPassword}) async {
    var mutationCreateResidentAccount = '''
      mutation (\$user:String, \$name:String,\$password:String,\$email:String,\$confirmPassword:String){
    response: resident_create_resident_account (user :\$user,name: \$name,password: \$password,email: \$email,confirmPassword: \$confirmPassword ) {
        code
        message
        data 
      }
    }
     
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutationCreateResidentAccount),
      variables: {
        "user": user,
        "name": name,
        "email": email,
        "password": passWord,
        "confirmPassword": confirmPassword
      },
    );

    final data = await ApiService.shared.mutationhqlQuery(options);
    var res = ResponseModule.fromJson(data);
    if (res.response == null) {
      res.error != null ? throw (res.error!) : throw ('');
    }

    return ResponseRegister.fromJson(res.response);
  }
}
