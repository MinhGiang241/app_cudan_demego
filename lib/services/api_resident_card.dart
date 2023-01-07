import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIResCard {
  static Future changeStatus(Map<String, dynamic> data) async {
    var query = '''
  mutation (\$data:Dictionary){
    response: card_mobile_change_status_resident_card (data: \$data ) {
        code
        message
        data
    }
}
        

  ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"data": data},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future removeResidentCard(String id) async {
    var query = '''
  mutation (\$_id:String){
    response : remove_ResidentCard_dto(_id:\$_id){
      message
      code
      data {
        _id
      }
    }
  }

  ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"_id": id},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future saveResidentCard(data) async {
    var query = '''
        mutation (\$data:ResidentCardInputDto){
    response:	save_ResidentCard_dto(data:\$data){
      code
      message
      data {
        _id
      }
    }
    }
    ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"data": data},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getResidentCardById(String id) async {
    var query = '''
      mutation (\$residentId:String){
    response: card_mobile_get_resident_card_by_residentId (residentId: \$residentId ) {
        code
        message
        data
    }
    }
        
    ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"residentId": id},
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
