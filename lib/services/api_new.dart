import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APINew {
  static Future getNewList(int limit, int skip) async {
//     var query = '''
//     query (\$filter: GeneralCollectionFilterInput){
// 	response: query_Newss_dto(filter:\$filter){
// 		message
// 		code
// 		data {
// 			_id
// 			code
// 			title
// 			date
// 			type
// 			content
// 			detail
// 			image
// 			isSend
// 			employeeId
// 			createdTime
// 			updatedTime
// 		}
// 	}
// }
//     ''';

    var query = '''
    mutation (\$limit:Float,\$skip:Float){
        response: news_mobile_get_news (limit: \$limit,skip: \$skip ) {
            code
            message
            data
        }
    }
            
    ''';
    final QueryOptions options = QueryOptions(
        document: gql(query), variables: {"limit": limit, "skip": skip});

    final results = await ApiService.shared.graphqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
