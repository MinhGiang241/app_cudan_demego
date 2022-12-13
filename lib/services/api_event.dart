import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIEvent {
  static Future participateEvent(Map<String, dynamic> data) async {
    var query = '''
    mutation(\$data:EventParticipationInputDto ){
      response: save_EventParticipation_dto(data:\$data) {
        message
        code
        data {
          _id
        }
      }
    }
    ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"data": data},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getEventList(
      int skip, int limit, String type, String accountId) async {
    var query = '''
  mutation (\$limit:Float,\$skip:Float,\$type:String,\$accountId:String){
    response: event_mobile_get_event_list (limit: \$limit,skip: \$skip,type: \$type,accountId: \$accountId ) {
        code
        message
        data
    }
}
        
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "skip": skip,
        "limit": limit,
        "type": type,
        "accountId": accountId,
      },
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
