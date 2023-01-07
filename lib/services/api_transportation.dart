import 'package:app_cudan/services/api_auth.dart';
import 'package:app_cudan/utils/error_handler.dart';
import 'package:graphql/client.dart';

import '../generated/l10n.dart';
import '../models/response.dart';
import 'api_service.dart';

class APITrans {
  static Future changeStatus(Map<String, dynamic> data) async {
    var query = '''
    mutation (\$data:Dictionary){
    response: card_mobile_change_status_transportcard (data: \$data ) {
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

  static Future lockTransportationCard(String id) async {
    var query = '''
    mutation (\$_id:String,\$status:String){
        response: card_change_active_status_transport_card (_id: \$_id,status:\$status )
    }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"_id": id, "status": "INACTIVE"},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future sendToApproveTransportationCard(String id) async {
    var query = '''
    mutation (\$id:String){
        response: card_mobile_send_to_approved_transportation_card (id: \$id ) {
            code
            message
            data
        }
      } 
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"id": id},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future removeTransportationCard(String id) async {
    var query = '''
        mutation (\$_id: String){
    response: remove_TransportCard_dto (_id:\$_id){
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

  static Future saveTransportationCard(data) async {
    var query = '''
          mutation (\$data: TransportCardInputDto){
      response: save_TransportCard_dto(data:\$data){
        data {
          _id
        }
        message
        code
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

  static Future getTransportationType() async {
    var query = '''
    query  {
      response :query_Vehicles_dto {
        message
        code
        data {
          _id
          name
          display_name
          code
          createdTime
          updatedTime
        }
      }
    }''';

    final QueryOptions options = QueryOptions(document: gql(query));

    final results = await ApiService.shared.graphqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getTransportCardList(String residentId) async {
    var query = '''
        mutation (\$residentId:String){
      response: vehicle_mobile_get_transportation_card_list_by_residentId (residentId: \$residentId ) {
          code
          message
          data
      }
    }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"residentId": residentId},
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
