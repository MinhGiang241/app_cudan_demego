import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIChat {
  static Future getChatSubject() async {
    var query = '''
          query  {
      response :query_MessageSubjects_dto{
        message
        code
        data {
          _id
          display_name
          createdTime
          updatedTime
          name
          code
          note
        }
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
