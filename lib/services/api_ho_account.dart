import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../constants/api_account_constant.dart';
import '../generated/l10n.dart';
import '../models/response.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'api_ho_service.dart';

class APIHOAccount {
  static Future getProjectListApi() async {
    var query = '''
   mutation {
    response: guest_qltn_my_approved_registrations_1hld8x3wv  {
        code
        message
        data
    }
}
        
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {},
    );
    final results = await ApiHOService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getProjectListNotApprovedRegistrationApi() async {
    var query = '''
    mutation {
    response: guest_qltn_my_not_approved_registrations  {
        code
        message
        data
    }
}
        
        
        
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
    );
    final results = await ApiHOService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getProjectRegistrationListApi(bool status) async {
    var query = '''
   mutation (\$status:Boolean){
    response: guest_qltn_my_approved_registrations (status: \$status ) {
        code
        message
        data
    }
}
        
      
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"status": status},
    );
    final results = await ApiHOService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getApartmentSuggestion(
    String registrationId,
    String key,
  ) async {
    var query = '''
    mutation (\$registrationId:String,\$key:String){
    response: guest_qltn_get_suggest_apartmentcode (registrationId: \$registrationId,key: \$key ) {
        code
        message
        data
    }
}
        
      
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"registrationId": registrationId, "key": key},
    );
    final results = await ApiHOService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getProjectSuggestion() async {
    var query = '''
    mutation {
    response: guest_qltn_get_tenant_suggestion  {
        code
        message
        data
    }
}
        
      
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
    );
    final results = await ApiHOService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future loginHO(
    String userName,
    String password,
  ) async {
    await ApiHOService.shared.LoginHO(userName, password);
  }

  static Future getRelationshipList(
    String registrationId,
  ) async {
    var query = '''
    mutation (\$registrationId:String){
    response: guest_qltn_load_relationships (registrationId: \$registrationId ) {
        code
        message
        data
    }
}
        
      
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "registrationId": registrationId,
      },
    );
    final results = await ApiHOService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future submitResidentRegister(
    String registrationId,
    String apartmentCode,
    String relationship,
    String contractCode,
  ) async {
    var query = '''
   mutation (\$registrationId:String,\$apartmentCode:String,\$relationship:String,\$contractCode:String){
    response: guest_qltn_register_resident (registrationId: \$registrationId,apartmentCode: \$apartmentCode,relationship: \$relationship,contractCode: \$contractCode ) {
        code
        message
        data
    }
}
        
        
      
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "registrationId": registrationId,
        "apartmentCode": apartmentCode,
        "relationship": relationship,
        "contractCode": contractCode,
      },
    );
    final results = await ApiHOService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getSupportPhoneNumber() async {
    var query = '''
   mutation {
    response: guest_qltn_mobile_get_support_phone_number  {
        code
        message
        data
    }
}   
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
    );
    final results = await ApiHOService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future createAccount(
    String phone,
    String password,
    String email,
    String fullName,
  ) async {
    var query = '''
   mutation (\$phone:String,\$password:String,\$email:String, \$fullName:String) {
    response: guest_qltn_register_account(phone:\$phone,password:\$password,email:\$email, fullName:\$fullName)  {
        code
        message
        data
    }
}   
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "phone": phone,
        "password": password,
        "email": email,
        "fullName": fullName,
      },
    );
    final results = await ApiHOService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
