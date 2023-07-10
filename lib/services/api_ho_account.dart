import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../constants/api_account_constant.dart';
import '../generated/l10n.dart';
import '../models/response.dart';
import '../screens/ho/select_project_screen.dart';

class APIHOAccount {
  static final Dio _dio =
      Dio(BaseOptions(baseUrl: APIAccountConstant.domainApi));
  static final _graphqlLink = HttpLink(APIAccountConstant.apiGraphql);
  static String? access_token;
  static DateTime? expireDate;

  static Future<GraphQLClient> getClientGraphQL() async {
    late AuthLink authLink;
    if (APIHOAccount.access_token == null) {
      authLink = AuthLink(getToken: () => 'Bearer ');
    } else if (expireDate == null ||
        expireDate!.compareTo(DateTime.now()) < 0) {
      authLink = AuthLink(getToken: () => 'Bearer ');
    } else {
      log(access_token!);
      authLink = AuthLink(
        getToken: () async => 'Bearer ${access_token}',
      );
    }
    Link link = authLink.concat(_graphqlLink);

    final GraphQLClient graphQLClient = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );

    return graphQLClient;
  }

  static Future<Map<String, dynamic>> mutationhqlQuery(
    MutationOptions options,
  ) async {
    try {
      final cl = await getClientGraphQL();
      final result = await cl.mutate(options);

      if (result.data == null) {
        // throw ("network_connection_err");
        return {
          "response": {"code": 1, "message": S.current.err_conn}
        };
      }
      return result.data!;
    } catch (e) {
      return {
        "response": {"code": 1, "message": e.toString()}
      };
    }
  }

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
    final results = await mutationhqlQuery(options);

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
    final results = await mutationhqlQuery(options);

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
    final results = await mutationhqlQuery(options);

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
    final results = await mutationhqlQuery(options);

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
    final results = await mutationhqlQuery(options);

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
    try {
      var options = Options(
        headers: {
          'Authorization': "Bearer ${APIHOAccount.access_token}",
          "Accept": "application/json"
        },
      );

      var query = {
        "userName": userName,
        "password": password,
        "audience": "guest",
      };
      var results = await _dio.post(
        APIAccountConstant.apiLogin,
        options: options,
        queryParameters: query,
      );
      access_token = results.data?['access_token'];
      expireDate = DateTime.tryParse(results.data?['expires_at']) != null
          ? DateTime.parse(results.data?['expires_at'])
          : null;
      print(access_token);

      // Navigator.pushNamed(context, ProjectSelectionScreen.routeName);
    } catch (e) {
      throw (e);
    }
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
    final results = await mutationhqlQuery(options);

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
    final results = await mutationhqlQuery(options);

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
    final results = await mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
