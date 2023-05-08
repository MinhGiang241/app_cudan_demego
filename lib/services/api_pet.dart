import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIPet {
  static Future deletePet(String id) async {
    var query = '''
mutation(\$_id:String){
response: remove_Pet_dto(_id:\$_id){
	message
	code
	data{
		_id
	}
}
}
''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      "_id": id,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future savePet(data, isEdit) async {
    var query = '''
 mutation (\$data:Dictionary,\$isEdit:Boolean){
    response: pet_mobile_save_pet (data: \$data,isEdit: \$isEdit ) {
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

  static Future changeStatus(Map<String, dynamic> data) async {
    var query = '''
    mutation (\$data:Dictionary){
    response: pet_mobile_change_status_pet (data: \$data ) {
        code
        message
        data
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

  static Future getPetList(String? residentId, String? apartmentId) async {
    var query = '''
    mutation (\$residentId:String,\$apartmentId:String){
        response: pet_mobile_get_pet_list_by_residentId_and_apartmentId (residentId: \$residentId,apartmentId: \$apartmentId ) {
            code
            message
            data
        }
    }
            
    ''';

    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      "residentId": residentId,
      "apartmentId": apartmentId,
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
