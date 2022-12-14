import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIConstruction {
  static Future changeStatus(Map<String, dynamic> data) async {
    var query = '''
        mutation (\$data:Dictionary){
    response: constructionregistration_mobile_change_status (data: \$data ) {
        code
        message
        data
      }
    }
        
        
      ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {"data": data});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future removeConstructionHistory(String id) async {
    var query = '''
        mutation (\$constructionRegistrationId:String){
    response: constructiondocumenthistory_mobile_remove_construction_history (constructionRegistrationId: \$constructionRegistrationId ) {
        code
        message
        data
    }
}
        
      ''';
    final MutationOptions options = MutationOptions(
        document: gql(query), variables: {"constructionRegistrationId": id});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future removeConstructionRegistration(String id) async {
    var query = '''
        mutation (\$_id: String){
    response: remove_ConstructionRegistration_dto(_id:\$_id){
      code
      message
      data {
        _id
      }
    }
    }
      ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {"_id": id});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future saveConstructionHistory(data) async {
    var query = '''
        mutation(\$data:ConstructionHistoryInputDto ){
      response: save_ConstructionHistory_dto(data:\$data){
        code
        message
        data {
          _id
        }
      }
    }
      ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {"data": data});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future saveConstructionRegistration(data) async {
    var query = '''
          
          mutation (\$data:ConstructionRegistrationInputDto){
      response: save_ConstructionRegistration_dto(data:\$data){
        code
        message,
        data {
          _id
        }
      }
    }
      ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {"data": data});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getDayOff() async {
    var query = '''
   query{
	response: query_DayOffs_dto{
		message
		code
		data {
			_id
			createdTime
			updatedTime
			d_0
			d_1
			d_2
			d_3
			d_4
			d_5
			d_6
		}
	}
}
        
    ''';
    final QueryOptions options = QueryOptions(
      document: gql(query),
    );

    final results = await ApiService.shared.graphqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionTypeList() async {
    var query = '''
    mutation {
    response: construction_mobile_get_constructioType_list  {
        code
        message
        data
    }
    }
        
    ''';
    final MutationOptions options = MutationOptions(document: gql(query));

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionHistory(
      String constructionregistrationId) async {
    var query = '''
    mutation (\$constructionregistrationId:String){
        response: constructiondocumenthistory_mobile_get_construction_history (constructionregistrationId: \$constructionregistrationId ) {
            code
            message
            data
        }
    }
              
  ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "constructionregistrationId": constructionregistrationId,
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

  static Future getConstructionDocumentList(
      String residentId, String apartmentId) async {
    var query = '''
    mutation (\$residentId:String,\$apartmentId:String){
        response: constructiondocument_mobile_get_construction_document_by_residentId_and_apartmentId (residentId: \$residentId,apartmentId: \$apartmentId ) {
            code
            message
            data
        }
    }
            
    ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"residentId": residentId, "apartmentId": apartmentId},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionRegistrationList(
      String residentId, String apartmentId) async {
    var query = '''
    mutation (\$residentId:String,\$apartmentId:String){
        response: constructionregistration_mobile_get_constructionregistration_by_residentId_and_apartmentId (residentId: \$residentId,apartmentId: \$apartmentId ) {
            code
            message
            data
        }
    }
            
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"residentId": residentId, "apartmentId": apartmentId},
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
