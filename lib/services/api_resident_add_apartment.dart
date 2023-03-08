import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIResidentAddApartment {
  static Future saveFormResidentAddApartment(Map<String, dynamic> data) async {
    var query = '''
   mutation (\$data: FormAddNewResidentApartmentInputDto) {
	response : save_FormAddNewResidentApartment_dto(data: \$data){
	message
		code
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

  static Future getFormResidentAddApartment(String residentId) async {
    var query = '''
   mutation (\$residentId:String){
    response: formAddNewResidentApartment_mobile_get_form_add_new_resident_apartment_by_residentId (residentId: \$residentId ) {
        code
        message
        data
    }
}
        
    ''';

    final MutationOptions options = MutationOptions(
        document: gql(query), variables: {"residentId": residentId});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
