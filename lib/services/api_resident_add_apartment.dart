import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIResidentAddApartment {
  static Future saveFormResidentAddApartment(Map<String, dynamic> data) async {
    var query = '''
 mutation (\$data:Dictionary){
    response: addnewresident_mobile_db_save (data: \$data ) {
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

  static Future changeStatusFormResidentAddApartment(
    Map<String, dynamic> data,
  ) async {
    var query = '''
    mutation (\$data:Dictionary){
        response: addnewresident_mobile_change_status (data: \$data ) {
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

  static Future getFormResidentAddApartment(
    String residentId,
    String? apartmentId,
  ) async {
    var query = '''
   mutation (\$residentId:String,\$apartmentId:String){
    response: addnewresident_mobile_get_form_add_new_resident_apartment_by_residentId (residentId: \$residentId,apartmentId: \$apartmentId ) {
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

  static Future getDependentResident(String? residentId) async {
    var query = '''
mutation (\$residentId:String){
    response: addnewresident_mobile_get_list_dependence (residentId: \$residentId ) {
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
}
