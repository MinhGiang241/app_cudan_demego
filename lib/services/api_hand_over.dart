import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIHandOver {
  static Future getHandOverList(String? residentId) async {
    var query = '''
      mutation (\$residentId:String){
    response: handover_mobile_get_handover_list_by_residentId (residentId: \$residentId ) {
        code
        message
        data
    }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"residentId": residentId},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getApointmentScheduleList(String? residentId) async {
    var query = '''
      mutation (\$residentId:String){
    response: handover_mobile_get_apointment_schedule (residentId: \$residentId ) {
        code
         data
         message
    }
}
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"residentId": residentId},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future saveApointmentScheduleList(Map<String, dynamic>? data) async {
    var query = '''
     mutation (\$data:Dictionary){
    response: handover_mobile_save_appointment_schedule (data: \$data ) {
        code
        message
        data
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
