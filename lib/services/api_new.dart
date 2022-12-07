import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APINew {
  static Future getNewList(filter) async {
    var query = '''
    query (\$filter: GeneralCollectionFilterInput){
	response: query_Newss_dto(filter:\$filter){
		message
		code
		data {
			_id
			code
			title
			date
			type
			content
			detail
			image
			isSend
			employeeId
			createdTime
			updatedTime
		}
	}
}
    ''';
    final QueryOptions options =
        QueryOptions(document: gql(query), variables: {"filter": filter});

    final results = await ApiService.shared.graphqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
