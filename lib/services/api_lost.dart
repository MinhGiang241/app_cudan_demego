import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APILost {
  static Future saveLootItem(data) async {
    var query = '''
        mutation(\$data:LootItemsInputDto){
    response:save_LootItems_dto (data:\$data){
      message
      code
      data{
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

  static Future saveLostItem(data) async {
    var query = '''
      mutation(\$data:LostItemsInputDto){
  response:save_LostItems_dto (data:\$data){
    message
    code
    data{
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

  static Future getLootItemList(
      int year, int month, String phone, bool isInit) async {
    var query = '''
  mutation (\$year:Float,\$month:Float,\$phone:String,\$init:Boolean){
    response: reception_mobile_find_loot_item_by_phone_and_month (year: \$year,month: \$month,phone: \$phone,init: \$init ) {
        code
        message
        data
    }
}
        
        
        
''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"year": year, "month": month, "phone": phone, "init": isInit},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getLostItemList(
      int year, int month, String phone, bool isInit) async {
    var query = '''
    mutation (\$year:Float,\$month:Float,\$phone:String,\$init:Boolean){
    response: reception_mobile_find_lost_items_list_by_phone_and_month (year: \$year,month: \$month,phone: \$phone,init: \$init ) {
        code
        message
        data
    }
}
        
            
    ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"year": year, "month": month, "phone": phone, "init": isInit},
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
