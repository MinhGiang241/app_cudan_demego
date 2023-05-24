import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIChat {
  static Future getChatSubject() async {
    var query = '''
         mutation {
    response: rocketchat_mobile_get_subject_chat  {
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
