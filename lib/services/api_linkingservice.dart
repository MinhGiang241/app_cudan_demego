import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APILinkingService {
  static Future getLinkingServiceList() async {
    var query = '''
    mutation {
        response: linkingservice_mobile_get_all_linking_service_list  {
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
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }
}
