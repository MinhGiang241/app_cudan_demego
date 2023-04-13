import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APITransport {
  static Future getTransportCardList(
    String? residentId,
    String? apartmentId,
  ) async {
    var query = '''
    mutation (\$residentId:String,\$apartmentId:String){
    response: card_mobile_get_transport_card_list_by_residentId_and_apartmentId (residentId: \$residentId,apartmentId: \$apartmentId ) {
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

  static Future getTransportLetterList(
    String? residentId,
    String? apartmentId,
    bool isLetter,
  ) async {
    var query = '''
     mutation (\$residentId:String,\$apartmentId:String,\$isLetter:Boolean){
    response: vehicle_mobile_get_transportation_card_list_by_residentId (residentId: \$residentId,apartmentId: \$apartmentId,isLetter: \$isLetter ) {
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
        "isLetter": isLetter
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
   query {
	response: query_ShelfLifes_dto{
		code 
		message
		data {
			_id
			createdTime
			updatedTime
			code
			use_time
			describe
			type_time
			time
			order
		}
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

  static Future saveTransportLetter(
    Map<String, dynamic> data,
  ) async {
    var query = '''
     mutation (\$data:Dictionary){
    response: card_mobile_save_transport_card_letter (data: \$data ) {
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
