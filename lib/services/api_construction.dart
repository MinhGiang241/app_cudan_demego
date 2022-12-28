import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIConstruction {
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
