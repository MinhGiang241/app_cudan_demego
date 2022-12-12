import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIEvent {
  static Future getEventList(int skip, int limit, String type) async {
    var query = '''
   mutation (\$limit:Float,\$skip:Float,\$type:String){
    response: event_mobile_get_event_list (limit: \$limit,skip: \$skip,type: \$type ) {
        code
        message
        data
    }
  }      
  ''';

    print(type);
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"skip": skip, "limit": limit, "type": type},
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
