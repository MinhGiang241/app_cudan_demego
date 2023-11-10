import 'package:app_cudan/services/api_service.dart';
import 'package:graphql/client.dart';

import '../models/response.dart';

class APIBookingService {
  static Future getServiceList() async {
    var query = '''
    mutation {
    response: serviceconfiguration_mobile_get_service_configuration_list  {
        code
        message
        data
      }
    }
    ''';
    final QueryOptions options = QueryOptions(
      document: gql(query),
    );

    final results = await ApiService.shared.graphqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
