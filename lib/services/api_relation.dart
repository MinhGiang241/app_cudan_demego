import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIRelation {
  static Future preFetchDataRelation() async {
    var query = '''
    query (\$filter:GeneralCollectionFilterInput) {
      response: query_Relationships_dto (filter:\$filter){
        message
        code 
        data {
          _id
          createdTime
          updatedTime
          code
          display_name
          name
        }
      }
    }
''';
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: const {
        "filter": {"limit": 1000},
      },
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
