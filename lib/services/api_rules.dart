import 'package:app_cudan/services/api_service.dart';
import 'package:graphql/client.dart';

import '../models/response.dart';

class APIRule {
  static Future getListRulesFiles(String? schema) async {
    var query = '''
        mutation (\$schema:String){
    response: card_mobile_get_rules_list_file (schema: \$schema ) {
        code
        message
        data
    }
}
        
        
      ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"schema": schema},
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
