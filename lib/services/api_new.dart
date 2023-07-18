import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APINew {
  static Future markRead(data) async {
    var query = '''
    mutation (\$data: MarkReadInputDto){
      response: save_MarkRead_dto(data:\$data){
        code
        message
        data{
          _id
        }
      }
    }
    ''';
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        "data": data,
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

  static Future getNewList(
    int limit,
    int skip,
    String type,
    String accountId,
  ) async {
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
   mutation (\$limit:Float,\$skip:Float,\$type:String,\$accountId:String){
    response: news_mobile_get_news (limit: \$limit,skip: \$skip,type: \$type,accountId: \$accountId ) {
        code
        message
        data
    }
}
        
         
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        "limit": limit,
        "skip": skip,
        "type": type,
        "accountId": accountId
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
