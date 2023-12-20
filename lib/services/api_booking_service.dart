import 'package:app_cudan/services/api_service.dart';
import 'package:graphql/client.dart';

import '../models/response.dart';

class APIBookingService {
  static Future addCommentToRegisterService(Map<String, dynamic> data) async {
    var query = '''
    mutation (\$data:Dictionary){
    response: serviceconfiguration_mobile_update_vote_register_service (data: \$data ) {
        code
        message
        data
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

  static Future getServiceList() async {
    var query = '''
    mutation {
    response: serviceconfiguration_mobile_get_service_configuration_list  {
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

  static Future getAreaListBooking(
    String? time_start,
    String? time_end,
    List<Map<String, dynamic>> areas,
  ) async {
    var query = '''
mutation (\$time_start:String,\$time_end:String,\$areas:Dictionary){
    response: serviceconfiguration_mobile_get_service_area_list (time_start: \$time_start,time_end: \$time_end,areas: \$areas ) {
        code
        message
        data
    }
}
    ''';
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        "time_start": time_start,
        "time_end": time_end,
        "areas": areas,
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

  static Future saveRegiterService(
    Map<String, dynamic> data,
  ) async {
    var query = '''
    mutation (\$data:Dictionary){
    response: serviceconfiguration_mobile_register_service (data: \$data ) {
        code
        message
        data
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

  static Future getShelfLifeList(
    List<Map<String, dynamic>> feeByMonthList,
  ) async {
    var query = '''
mutation (\$feeByMonthList:Dictionary){
    response: serviceconfiguration_mobile_get_all_shelflife (feeByMonthList: \$feeByMonthList ) {
        code
        message
        data
    }
}

    ''';
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        "feeByMonthList": feeByMonthList,
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

  static Future getRegisterServiceHistoryList(
    String? type,
    String? residentId,
    String? apartmentId,
    String? phone,
  ) async {
    var query = '''
mutation (\$type:String,\$residentId:String,\$apartmentId:String,\$phone:String){
    response: serviceconfiguration_mobile_get_register_service_list_by_type (type: \$type,residentId: \$residentId,apartmentId: \$apartmentId,phone: \$phone ) {
        code
        message
        data
    }
}

    ''';
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'type': type,
        'residentId': residentId,
        'apartmentId': apartmentId,
        'phone': phone,
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

// mutation ($data:Dictionary,$status:String){
//     response: service_change_status (data: $data,status: $status )
// }
  static Future changeStatusRegisterService(
    Map<String, dynamic> data,
    String status,
  ) async {
    var query = '''
mutation (\$data:Dictionary,\$status:String){
    response: service_mobile_change_status_register_service (data: \$data,status: \$status ) {
        code
        message
        data
    }
}
        
    ''';
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'data': data,
        'status': status,
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
