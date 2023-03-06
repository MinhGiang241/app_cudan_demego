import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIRelation {
  static Future preFetchDataRelation() async {
    var query = '''
    query {
      response: query_Relationships_dto{
        message
        code 
        data {
          _id
          createdTime
          updatedTime
          code
          display_name
          code
          name
        }
      }
    }
''';
    final QueryOptions options = QueryOptions(document: gql(query));

    final results = await ApiService.shared.graphqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
