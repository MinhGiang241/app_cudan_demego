import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APINotification {
  static Future getUnreadNotfication() async {
    var query = '''
       mutation {
    response: notify_resident_my_unread_notify_state  {
        code
        message
        data
      }
    }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future markReadNotification(String? id) async {
    var query = '''
       mutation (\$_id:String){
    response: notify_update_read_status (_id: \$_id ){
      message
      code
      data 
      }
    }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "_id": id,
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

  static Future getNotficationList(String typeId, int skip, int limit) async {
    var query = '''
    mutation (\$typeId:String,\$skip:Float,\$limit:Float){
        response: notify_resident_load_my_notify (typeId: \$typeId,skip: \$skip,limit: \$limit ) {
            code
            message
            data
        }
    }
            
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "typeId": typeId,
        "skip": skip,
        "limit": limit,
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

  static Future getNotficationTypeList() async {
    var query = '''
    mutation {
        response: notify_mobile_get_resident_notification_type  {
            code
            message
            data
        }
    }       
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
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
