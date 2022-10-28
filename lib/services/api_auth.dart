import 'dart:io';

// import 'package:graphql/client.dart';

import 'package:graphql/client.dart';

import '../constants/api_constant.dart';
import 'package:dio/dio.dart';
import '../models/response_file_upload.dart';
import '../models/response_register.dart';
import '../models/response.dart';
import '../models/response_user.dart';
import '../services/api_service.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class APIAuth {
  static Future<oauth2.Client?> signIn(
      {required String username,
      required String password,
      ErrorHandle? onError}) async {
    return await ApiService.shared
        .getClient(username: username, password: password, onError: onError);
  }

  // static Future<ResponseRegister> createAccount(
  //     {required String phoneNum,
  //     required String fullName,
  //     required String email,
  //     required String passWord,
  //     required String confirmPassword}) async {
  //   final body = {
  //     "phoneNumber": phoneNum,
  //     "fullName": fullName,
  //     "email": email,
  //     "password": passWord,
  //     "confirmPassword": passWord
  //   };
  //   final data = await ApiService.shared
  //       .postApi(path: 'api/mobile/register', useToken: false, data: body);
  //   // print(data);
  //   return ResponseRegister.fromJson(data);
  // }

  static Future<ResponseRegister> verifyOTP({
    required String phoneNum,
    required String otp,
  }) async {
    final body = {"phoneNumber": phoneNum, "Otp": otp};
    final data = await ApiService.shared
        .postApi(path: 'api/mobile/verifyOtp', useToken: false, data: body);
    // print(data);
    return ResponseRegister.fromJson(data);
  }

  static Future<void> signOut({ErrorHandle? onError}) async {
    return await ApiService.shared.deleteCre();
  }

  static Future<ResponseUser> getUserInfo() async {
    final data = await ApiService.shared.getApi(
      path: 'api/mobile/userinfo',
    );
    // print(data);
    return ResponseUser.fromJson(data);
  }

  static Future<ResponseFileUpload> uploadImage(
      {required List<File> files, OnSendProgress? onSendProgress}) async {
    final multipartFiles = <MultipartFile>[];
    for (var i = 0; i < files.length; i++) {
      final mpf = await MultipartFile.fromFile(files[i].path);
      multipartFiles.add(mpf);
    }

    final map = {"files": multipartFiles};
    final body = FormData.fromMap(map);
    final data = await ApiService.shared
        .postApi(path: 'api/media', data: body, onSendProgress: onSendProgress);
    // print(data);
    return ResponseFileUpload.fromJson(data);
  }

  static Future<ResponseRegister> updateUserInfo(
      {String? email,
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
        .postApi(path: 'api/mobile/updateInfo', data: body);
    // print(data);
    return ResponseRegister.fromJson(data);
  }

  static Future<ResponseRegister> changePass(
      {required String phoneNum,
      required String oldPass,
      required String newPass}) async {
    final body = {
      "phoneNumber": phoneNum,
      "OldPassWord": oldPass,
      "NewPassWord": newPass
    };
    final data = await ApiService.shared
        .postApi(path: 'api/mobile/changePassword', data: body);
    // print(data);
    return ResponseRegister.fromJson(data);
  }

  static Future<ResponseRegister> forgotPass({
    required String phoneNum,
  }) async {
    final body = {
      "PhoneNumber": phoneNum,
    };
    final data = await ApiService.shared.postApi(
        path: 'api/mobile/forgotPassword', useToken: false, data: body);
    // print(data);
    return ResponseRegister.fromJson(data);
  }

  static Future<ResponseRegister> generateToken(
      {required String phoneNum, required String otp}) async {
    final body = {"PhoneNumber": phoneNum, "Otp": otp};
    final data = await ApiService.shared
        .postApi(path: 'api/mobile/generateToken', useToken: false, data: body);
    // print(data);
    return ResponseRegister.fromJson(data);
  }

  static Future<ResponseRegister> resetPass({
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
    final data = await ApiService.shared
        .postApi(path: 'api/mobile/resetPassword', useToken: false, data: body);
    // print(data);
    return ResponseRegister.fromJson(data);
  }

  static Future<ResponseRegister> createResidentAccount(
      {required String user,
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
