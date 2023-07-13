// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:graphql/client.dart';

import '../generated/l10n.dart';
import '../models/response.dart';

class ApiProjectService {
  ApiProjectService({
    this.expireDate,
    required this.domain,
    required this.access_token,
  }) {
    _dio = Dio(BaseOptions(baseUrl: domain));
    apiGraphql = domain;
    _graphqlLink = HttpLink(apiGraphql);
  }

  final String access_token;
  DateTime? expireDate;
  String domain;
  late String apiGraphql;

  late Dio _dio;
  late HttpLink _graphqlLink;

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

  Future<GraphQLClient> getClientGraphQL() async {
    late AuthLink authLink;
    if (access_token == null) {
      authLink = AuthLink(getToken: () => 'Bearer ');
    } else if (expireDate == null ||
        expireDate!.compareTo(DateTime.now()) < 0) {
      authLink = AuthLink(getToken: () => 'Bearer ');
    } else {
      log(access_token);
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

  Future registeResident(String accountType, String? owninfoId) async {
    var query = '''
  mutation (\$accountType:String,\$owninfoId:String){
    response: guest_qltn_register_resident (accountType: \$accountType,owninfoId: \$owninfoId ) {
        code
        message
        data
    }
}
''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "accountType": accountType,
        "owninfoId": owninfoId,
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

  Future loadDataRegister() async {
    var query = '''
 mutation {
    response: guest_qltn_get_registry_info  {
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
