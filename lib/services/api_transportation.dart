import 'package:app_cudan/utils/error_handler.dart';
import 'package:graphql/client.dart';

import '../generated/l10n.dart';
import '../models/response.dart';
import 'api_service.dart';

class APITrans {
  static Future getTransportCardList(String residentId) async {
    var query = '''
        mutation (\$residentId:String){
      response: vehicle_get_transportation_card_list_by_residentId (residentId: \$residentId ) {
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
