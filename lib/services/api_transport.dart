import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APITransport {
  static Future getTransportCardList(
    String? residentId,
    String? apartmentId,
    String? phone,
  ) async {
    var query = '''
    mutation (\$residentId:String,\$apartmentId:String,\$phone:String){
    response: card_mobile_get_transport_card_list_by_residentId_and_apartmentId (residentId: \$residentId,apartmentId: \$apartmentId,phone: \$phone ) {
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

  static Future getTransportLetterList(
    String? residentId,
    String? apartmentId,
    bool isLetter,
    String? phone,
  ) async {
    var query = '''
   mutation (\$residentId:String,\$apartmentId:String,\$isLetter:Boolean,\$phone:String){
    response: vehicle_mobile_get_transportation_card_list_by_residentId (residentId: \$residentId,apartmentId: \$apartmentId,isLetter: \$isLetter,phone: \$phone ) {
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
        "isLetter": isLetter,
        "phone": phone
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

  static Future getShelfLife() async {
    var query = '''
  mutation {
    response: card_mobile_list_shelfLife_transport  {
        code
        message
        data
    }
}
        
''';

    final QueryOptions options = QueryOptions(document: gql(query));

    final results = await ApiService.shared.graphqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future deleteListTransport(String? id) async {
    var query = '''
  mutation (\$id:String){
    response: card_mobile_remove_lissTransort (id: \$id ) {
        code
        message
        data
    }
}
        
        
''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "id": id,
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

  static Future saveTransportLetter(
    Map<String, dynamic> data,
    bool isUncontrol,
    bool isEdit,
  ) async {
    var query = '''
    mutation (\$data:Dictionary,\$isUncontrol:Boolean,\$isEdit:Boolean){
    response: card_mobile_save_transport_card_letter (data: \$data,isUncontrol: \$isUncontrol,isEdit: \$isEdit ) {
        code
        message
        data
    }
}
        
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "data": data,
        "isUncontrol": isUncontrol,
        "isEdit": isEdit,
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

  static Future saveListTransport(
    Map<String, dynamic>? data,
  ) async {
    var query = '''

mutation (\$data:ListTransportInputDto ){
	response: save_ListTransport_dto(data:\$data){
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
      variables: {
        "data": data,
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

  static Future saveManageCard(Map<String, dynamic> data) async {
    var query = '''
mutation(\$data:ManageCardInputDto){
	response: save_ManageCard_dto(data: \$data) {
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
      variables: {
        "data": data,
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

  static Future lockManageCard(Map<String, dynamic> card) async {
    var query = '''
mutation (\$card:Dictionary){
    response: card_mobile_lock_transport_card (card: \$card ) {
        code
        message
        data
    }
}
        
''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "card": card,
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

  static Future saveExtendForm(Map<String, dynamic> data) async {
    var query = '''
mutation (\$data:FormRenewalTransportInputDto ){
	response: save_FormRenewalTransport_dto(data:\$data){
		code
		message
		data{
			_id
			shelfLifeId
			expire_date
			renewal_date
			expire_date_old
			listTransportId
			transports_list {
				_id
				vehicleTypeId
				seats
				number_plate
				registration_number
				vehicle_amount
				current_date
				expire_date
				cost
			}
		}
	}
}
''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "data": data,
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

  static Future getListTransportByManageCardId(String? managecardId) async {
    var query = '''
         mutation (\$managecardId:String){
    response: card_mobile_get_list_transport_by_managecardId (managecardId: \$managecardId ) {
        code
        message
        data
    }
}
        
      ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"managecardId": managecardId},
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
