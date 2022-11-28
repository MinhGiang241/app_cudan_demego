// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_cudan/utils/utils.dart';
import 'package:app_cudan/widgets/primary_dialog.dart';
import 'package:flutter/cupertino.dart';

import '../constants/constants.dart';
import '../constants/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:graphql/client.dart';

import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:path_provider/path_provider.dart';

import '../generated/l10n.dart';
import '../screens/auth/sign_in_screen.dart';
import '../utils/error_handler.dart';

typedef OnSendProgress = Function(int, int);

class ApiService {
  static ApiService shared = ApiService();

  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseURL));
  String tokenEndpointUrl = ApiConstants.authorizationEndpoint;
  String clientId = ApiConstants.clientId; //"importer";
  String secret = ApiConstants.clientSecret;
  String scope = ApiConstants.scope;

  String userName = '';
  String passWord = '';

  final _graphqlLink = HttpLink(ApiConstants.baseURL);

  Future<oauth2.Client?> getClient(
      {required BuildContext context,
      required String username,
      required String password,
      bool remember = false,
      ErrorHandleFunc? onError}) async {
    userName = username;
    passWord = password;

    final client = await getExistClient();
    if (client != null) {
      if (client.credentials.isExpired) {
        return await _getCre(username, password, onError, remember);
      } else {
        return client;
      }
    } else {
      return await _getCre(username, password, onError, remember);
    }
  }

  Future<oauth2.Client?> _getCre(String username, String password,
      ErrorHandleFunc? onError, remember) async {
    final authorizationEndpoint = Uri.parse(tokenEndpointUrl);
    try {
      final cli = await oauth2.resourceOwnerPasswordGrant(
        authorizationEndpoint,
        username,
        password,
        identifier: clientId,
        secret: secret,
        scopes: [scope],
      );
      final path = await getApplicationDocumentsDirectory();
      final credentialsFile = File('${path.path}/credential.json');
      // if (remember) {
      await credentialsFile.writeAsString(cli.credentials.toJson());
      // }

      return cli;
    } catch (e) {
      onError?.call(e.toString());
      return null;
    }
  }

  Future<oauth2.Client?> getExistClient() async {
    try {
      final path = await getApplicationDocumentsDirectory();
      final credentialsFile = File('${path.path}/credential.json');
      var exists = await credentialsFile.exists();
      if (exists) {
        var credentials =
            oauth2.Credentials.fromJson(await credentialsFile.readAsString());
        return oauth2.Client(
          credentials,
          identifier: clientId,
          secret: '',
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  deleteCre() async {
    final path = await getApplicationDocumentsDirectory();
    final credentialsFile = File('${path.path}/credential.json');
    if (await credentialsFile.exists()) {
      await credentialsFile.delete();
    }
  }

  Future<oauth2.Client> refresh(oauth2.Client client, remember) async {
    // try {
    final cli = await client.refreshCredentials();
    final path = await getApplicationDocumentsDirectory();
    final credentialsFile = File('${path.path}/credential.json');

    await credentialsFile.writeAsString(client.credentials.toJson());

    return cli;
    // } catch (e) {
    //   // return oauth2.Client;
    // }
  }

  Future<bool> isExpired(BuildContext context) async {
    final client = await getExistClient();
    return client!.credentials.isExpired;
  }

  Future<String> getToken(BuildContext context) async {
    final client = await getExistClient();
    return client!.credentials.accessToken;
  }

  Future<Map<String, dynamic>> postApi(
      {dynamic data,
      required BuildContext context,
      required String path,
      bool useToken = true,
      ErrorHandleFunc? onError,
      bool remember = false,
      OnSendProgress? onSendProgress}) async {
    Options? options;
    if (useToken) {
      var client = await getExistClient();
      if (client == null) {
        onError?.call('');
      } else {
        //print(client.credentials.expiration);
        if (client.credentials.isExpired) {
          // print("EXPired");
          client = await refresh(client, remember);
          log(client.credentials.accessToken);
          options = Options(
            headers: {
              'Authorization': "Bearer ${client.credentials.accessToken}",
              "Accept": "application/json"
            },
          );
        } else {
          //await client.refreshCredentials();
          log(client.credentials.accessToken);
          options = Options(
            headers: {
              'Authorization': "Bearer ${client.credentials.accessToken}",
              "Accept": "application/json"
            },
          );
        }
      }
    }
    try {
      final response = await _dio.post(path,
          data: data, options: options, onSendProgress: onSendProgress);
      print(data);
      return {"data": response.toString(), "name": data.fields[0].value};
    } on DioError catch (e) {
      if (e.response != null) {
        try {
          log(e.response.toString());
          final data = jsonDecode(e.response.toString());
          return data;
        } catch (err) {
          return {"status": "error", "message": e.message};
        }
      } else {
        return {
          "status": "internet_error",
          "message": "network_connection_err"
        };
      }
    }
  }

  Future<Map<String, dynamic>> getApi(
      {required String path,
      bool useToken = true,
      bool remember = false,
      Map<String, dynamic>? params,
      ErrorHandleFunc? onError}) async {
    Options? options;
    if (useToken) {
      var client = await getExistClient();
      if (client == null) {
        onError?.call('');
      } else {
        //print(client.credentials.expiration);
        if (client.credentials.isExpired) {
          // print("EXPired");
          client = await refresh(client, remember);
          log(client.credentials.accessToken);
          options = Options(
            headers: {
              'Authorization': "Bearer ${client.credentials.accessToken}",
              "Accept": "application/json"
            },
          );
        } else {
          //await client.refreshCredentials();
          log(client.credentials.accessToken);
          options = Options(
            headers: {
              'Authorization': "Bearer ${client.credentials.accessToken}",
              "Accept": "application/json"
            },
          );
        }
      }
    }
    try {
      final response =
          await _dio.get(path, options: options, queryParameters: params);
      return jsonDecode(response.toString());
    } on DioError catch (e) {
      //print(e);
      if (e.response != null) {
        try {
          final data = jsonDecode(e.response.toString());
          return data;
        } catch (err) {
          return {"status": "error", "message": e.message};
        }
      } else {
        return {
          "status": "internet_error",
          "message": "network_connection_err"
        };
      }
    }
  }

  Future<Map<String, dynamic>> deleteApi(
      {dynamic data,
      required String path,
      required BuildContext context,
      bool useToken = true,
      bool remember = false,
      ErrorHandleFunc? onError,
      OnSendProgress? onSendProgress}) async {
    Options? options;
    if (useToken) {
      var client = await getExistClient();
      if (client == null) {
        onError?.call('');
      } else {
        //print(client.credentials.expiration);
        if (client.credentials.isExpired) {
          // print("EXPired");
          client = await refresh(client, remember);
          log(client.credentials.accessToken);
          options = Options(
            headers: {
              'Authorization': "Bearer ${client.credentials.accessToken}",
              "Accept": "application/json"
            },
          );
        } else {
          //await client.refreshCredentials();
          log(client.credentials.accessToken);
          options = Options(
            headers: {
              'Authorization': "Bearer ${client.credentials.accessToken}",
              "Accept": "application/json"
            },
          );
        }
      }
    }
    try {
      final response = await _dio.delete(path, data: data, options: options);

      return jsonDecode(response.toString());
    } on DioError catch (e) {
      if (e.response != null) {
        try {
          log(e.response.toString());
          final data = jsonDecode(e.response.toString());
          return data;
        } catch (err) {
          return {"status": "error", "message": e.message};
        }
      } else {
        return {
          "status": "internet_error",
          "message": "network_connection_err"
        };
      }
    }
  }

  Future<GraphQLClient> getClientGraphQL(
      {ErrorHandleFunc? onError, bool remember = false}) async {
    late AuthLink authLink;
    var client = await getExistClient();
    if (client == null) {
      authLink = AuthLink(getToken: () => 'Bearer ');
      onError?.call('');
    } else {
      //print(client.credentials.expiration);
      if (client.credentials.isExpired) {
        // print("EXPired");
        client = await refresh(client, remember);
        log(client.credentials.accessToken);
        authLink = AuthLink(
          getToken: () async => 'Bearer ${client?.credentials.accessToken}',
        );
      } else {
        //await client.refreshCredentials();
        log(client.credentials.accessToken);
        authLink = AuthLink(
          getToken: () async => 'Bearer ${client?.credentials.accessToken}',
        );
      }
    }
    Link link = authLink.concat(_graphqlLink);

    final GraphQLClient graphQLClient = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );

    return graphQLClient;
  }

  Future<Map<String, dynamic>> graphqlQuery(QueryOptions options) async {
    final cl = await getClientGraphQL();
    try {
      final result = await cl.query(options);
      if (result.data == null) {
        return {
          "response": {"code": 1, "message": S.current.err_conn, "data": null}
        };
      }
      return result.data!;
    } on OperationException catch (e) {
      return {
        "response": {"code": 1, "message": e.toString(), "data": null}
      };
    }
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
}
