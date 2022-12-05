import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIExtraService {
  static Future getServiceRegistration(
      String residentId, String arisingServiceId) async {
    var query = '''
    mutation (\$residentId:String,\$arisingServiceId:String){
    response: service_moblie_get_service_registration_by_residentId_and_arising_service_id (residentId: \$residentId,arisingServiceId: \$arisingServiceId ) {
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
          "arisingServiceId": arisingServiceId
        });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getExtraServiceList() async {
    var query = '''
    mutation {
        response: service_mobile_get_extra_service_list  {
            code
            message
            data
        }
    }
      
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
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
