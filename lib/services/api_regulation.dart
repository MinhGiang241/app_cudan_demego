import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIRegulation {
  static Future getRegulation(
    String scheme,
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
        MutationOptions(document: gql(query), variables: {});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
