import 'package:app_cudan/services/api_service.dart';
import 'package:graphql/client.dart';

import '../models/response.dart';

class APIBookingService {
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
    mutation (\$data:String){
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
}
