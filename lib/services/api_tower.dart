import 'package:app_cudan/models/response.dart';
import 'package:graphql/client.dart';
import 'api_service.dart';

class APITower {
  static Future getResidentInfo(String userName) async {
    var query = '''
    mutation (\$userName:String){
    response: resident_mobile_get_resident_info_by_account (userName: \$userName ) {
        code
        message
        data
    }
    }    
       
    ''';
    final MutationOptions options = MutationOptions(
        document: gql(query), variables: {"userName": userName});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getUserOwnInfo(String residentId) async {
    var queryGetUserInfo = '''
    mutation (\$residentId:String){
    response: resident_mobile_get_resident_own_info (residentId: \$residentId ) {
        code
        message
        data
    }
}

  ''';

    final MutationOptions options = MutationOptions(
      document: gql(queryGetUserInfo),
      variables: {
        "residentId": residentId,
      },
    );
    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
