import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIReflection {
  static Future getReflection(
    String status,
    int? year,
    int? month,
    String residentId,
  ) async {
    var query = '''
        mutation (\$status:String,\$year:Float,\$month:Float,\$residentId:String){
    response: ticket_mobile_get_ticket_by_status_and_residentId (status: \$status,year: \$year,month: \$month,residentId: \$residentId ) {
        code
        message
        data
      }
    }
        
      ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      "status": status,
      "year": year,
      "month": month,
      "residentId": residentId,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getComplainReaction() async {
    var query = '''
        query {
	response: query_ComplaintReasons_dto{
	message
	code
	data {
		_id
    code
		createdTime
		updatedTime
		display_name
		content
		description
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

  static Future getOpinion() async {
    var query = '''
            query {
      response: query_OpinionContributes_dto{
      message
      code
      data {
        _id
        code
        createdTime
        updatedTime
        display_name
        content
        description
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

  static Future saveOpinionContribute(Map<String, dynamic> data) async {
    var query = '''
        mutation(\$data: OpinionContributeInputDto){
    response: save_OpinionContribute_dto(data:\$data){
      message
      code
      data {
        _id
        display_name
        code
        updatedTime
        createdTime
        description
        content
      }
    }
  }
          
      ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      "data": data,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future saveTicket(Map<String, dynamic> data) async {
    var query = '''
        mutation(\$data: TicketInputDto){
	response: save_Ticket_dto(data:\$data){
		message
		code
		data {
			_id
			
		}
	}
}
      ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      "data": data,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getListAreaByType(String type) async {
    var query = '''
          mutation (\$type:String){
    response: area_mobile_get_area_list_by_type (type: \$type ) {
        code
        message
        data
    }
    }
        
      ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      "type": type,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}