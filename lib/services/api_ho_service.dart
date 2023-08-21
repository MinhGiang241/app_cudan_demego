import 'dart:developer';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_ho_account.dart';
import 'package:app_cudan/services/prf_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';

import '../constants/api_account_constant.dart';
import '../generated/l10n.dart';
import '../screens/auth/sign_in_screen.dart';
import '../utils/utils.dart';

class ApiHOService {
  static ApiHOService shared = ApiHOService();

  final Dio _dio = Dio(BaseOptions(baseUrl: APIAccountConstant.domainApi));
  final _graphqlLink = HttpLink(APIAccountConstant.apiGraphql);
  String? access_token;
  DateTime? expireDate;
  Future<GraphQLClient> getClientGraphQL() async {
    late AuthLink authLink;
    if (access_token == null) {
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

  Future<Map<String, dynamic>> mutationhqlQuery(
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
      if (result.data?['response']?['message'] == 2) {
        throw ("RELOGIN");
      }
      return result.data!;
    } catch (e) {
      return {
        "response": {"code": 1, "message": e.toString()}
      };
    }
  }

  Future LoginHO(
    String userName,
    String password,
  ) async {
    try {
      var options = Options(
        headers: {
          'Authorization': "Bearer ${ApiHOService.shared.access_token}",
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

  Future deleteAccount(BuildContext context) async {
    await APIHOAccount.deleteHOAccount()
        //await Future.delayed(Duration(milliseconds: 0))
        .then((v) async {
      context.read<ResidentInfoPrv>().clearData();
      PrfData.shared.deleteUser();
      PrfData.shared.deleteProject();
      PrfData.shared.deleteApartment();
      PrfData.shared.deleteAuthState();
      expireDate = null;
      access_token = null;
      Navigator.of(context).pushNamedAndRemoveUntil(
        SignInScreen.routeName,
        ((route) => route.isCurrent),
        arguments: {
          "delete": true,
        },
      );
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
