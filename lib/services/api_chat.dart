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

  static Future saveSessionChatSubject(Map<String, dynamic> data) async {
    var query = '''
        mutation (\$data:Dictionary){
    response: rocketchat_mobile_save_session_chat_subject (data: \$data ) {
        code
        message
        data
    }
}
        
        
    ''';
    final QueryOptions options =
        QueryOptions(document: gql(query), variables: {"data": data});

    final results = await ApiService.shared.graphqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future checkExistedSessionChatSubject(String sessionId) async {
    var query = '''
        mutation (\$sessionId:String){
    response: rocketchat_mobile_check_existed_session_subject (sessionId: \$sessionId ) {
        code
        message
        data
    }
}
        
        
        
    ''';
    final QueryOptions options =
        QueryOptions(document: gql(query), variables: {"sessionId": sessionId});

    final results = await ApiService.shared.graphqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
