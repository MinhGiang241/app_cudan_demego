import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIHandOver {
  static Future getHandOverHistory(String residentId) async {
    var query = '''
      mutation (\$residentId:String){
    response: handover_mobile_get_hand_over_by_residentId (residentId: \$residentId ) {
        code
        message
        data
    }
    }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"residentId": residentId},
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
