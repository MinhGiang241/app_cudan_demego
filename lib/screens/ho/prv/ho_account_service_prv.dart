import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../../../constants/api_account_constant.dart';
import '../../../generated/l10n.dart';
import '../../../models/account.dart';
import '../../../models/ho_model.dart';
import '../../../models/response.dart';
import '../../../services/api_auth.dart';
import '../../../utils/error_handler.dart';
import '../../../utils/utils.dart';
import '../../auth/project_selection_screen.dart';
import '../select_project_screen.dart';

class HOAccountServicePrv extends ChangeNotifier {
  HOAccountServicePrv(this.context);
  BuildContext context;
  String? access_token;
  DateTime? expireDate;
  List<Project> projectList = [];

  final Dio _dio = Dio(BaseOptions(baseUrl: APIAccountConstant.domainApi));
  final _graphqlLink = HttpLink(APIAccountConstant.apiGraphql);

  Future loginHO(String userName, String password, BuildContext context) async {
    try {
      var options = Options(
        headers: {
          'Authorization': "Bearer ${access_token}",
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

      Navigator.pushNamed(context, SelectProjectScreen.routeName);
      // Navigator.pushNamed(context, ProjectSelectionScreen.routeName);
    } catch (e) {
      if ((e as DioError).response?.statusCode == 401) {
        throw (S.of(context).incorrect_usn_pass);
      }
      throw ((e).error.toString());
    }
  }

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
      return result.data!;
    } catch (e) {
      return {
        "response": {"code": 1, "message": e.toString()}
      };
    }
  }

  Future getProjectListApi() async {
    var query = '''
    mutation {
      response: guest_qltn_get_tenant_suggestion{
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

  Future getProjectListApprovedRegistrationApi(bool status) async {
    var query = '''
    mutation (\$status:Boolean){
      response: guest_qltn_my_approved_registrations(status:\$status){
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

  Future getProjectRegistrationListApi(bool status) async {
    var query = '''
    mutation (\$status:Boolean){
      
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

  Future getProjectList(BuildContext context) async {
    await getProjectListApi().then((v) {
      if (v != null) {
        projectList.clear();
        for (var i in v) {
          var pj = Project.fromMap(i);
          if (pj.status == "ACTIVED") {
            projectList.add(pj);
          }
        }
      }
      print(projectList);
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });

    return;
  }

  Future getRegisterList(BuildContext context) async {}
}
