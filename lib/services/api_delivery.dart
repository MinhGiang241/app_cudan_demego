import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIDelivery {
  static Future changeStatus(Map<String, dynamic> data) async {
    var query = '''
        mutation (\$data:Dictionary){
    response: transfer_mobile_change_status (data: \$data ) {
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

  static Future deleteDelivery(String id) async {
    var query = '''
        mutation (\$_id:String){
      response: remove_TransferItems_dto(_id:\$_id){
        code
        message
        data{
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

  static Future saveNewDelivery(Map<String, dynamic> data) async {
    var query = '''
  mutation (\$data:TransferItemsInputDto) {
    response: save_TransferItems_dto(data:\$data){
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

  static Future getDeliveryListByResidentId(String id) async {
    var query = '''
      mutation (\$residentId:String){
    response: transfer_mobile_get_tranfer_items_by_residentId (residentId: \$residentId ) {
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
