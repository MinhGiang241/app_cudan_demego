import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIHistory {
  static Future getHistoryLetter(String? refId, String? type) async {
    var query = '''
 mutation (\$refId:String,\$type:String){
    response: history_mobile_get_history_letter (refId: \$refId,type: \$type ) {
        code
        message
        data
    }
}
        
        
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"refId": refId, "type": type},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getHistoryCard(String? manageCardId) async {
    var query = '''
mutation (\$manageCardId:String){
    response: card_mobile_get_manage_card_history (manageCardId: \$manageCardId ) {
        code
        message
        data
    }
}
        
        
        
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"manageCardId": manageCardId},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future saveHistoryCard(Map<String, dynamic>? data) async {
    var query = '''
mutation (\$data:CardHistoryInputDto){
    response: save_CardHistory_dto (data: \$data ) {
        code
        message
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
}
