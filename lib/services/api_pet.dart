import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIPet {
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
