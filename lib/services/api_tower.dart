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
      document: gql(query),
      variables: {"userName": userName},
    );

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

  static Future getPlanInfo(String? apartmentId) async {
    var query = '''
    mutation (\$apartmentId:String){
    response: apartment_mobile_get_apartment_info_by_Id (apartmentId: \$apartmentId ) {
        code
        message
        data
    }
}
        

  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "apartmentId": apartmentId,
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

  static Future getResidentOwnInfo(String? residentId) async {
    var query = '''
    mutation (\$residentId:String){
        response: owninfo_mobile_find_dependent_resident_apartmentList (residentId: \$residentId ) {
            code
            message
            data
        }
    }
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
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

  static Future getCardCountOwnInfo(
    String? residentId,
    String? apartmentId,
  ) async {
    var query = '''
   mutation (\$residentId:String,\$apartmentId:String){
    response: card_mobile_count_managecard_by_residentId_and_apartmentId (residentId: \$residentId,apartmentId: \$apartmentId ) {
        code
        message
        data
    }
}
        
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "residentId": residentId,
        "apartmentId": apartmentId,
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

  static Future getManageCardList(
    String? residentId,
    String? phone,
  ) async {
    var query = '''
   mutation (\$phone:String,\$residentId:String){
    response: card_mobile_get_managecard_list_by_resident_id_and_phone (phone: \$phone,residentId: \$residentId ) {
        code
        message
        data
    }
}
        
        
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "residentId": residentId,
        "phone": phone,
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

  static Future mobileMe() async {
    var query = '''
 mutation {
    response: authorization_me_resident_app  {
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
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
