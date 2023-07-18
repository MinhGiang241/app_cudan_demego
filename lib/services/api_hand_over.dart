import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIHandOver {
  static Future getHandOverList(String? residentId) async {
    var query = '''
      mutation (\$residentId:String){
    response: handover_mobile_get_hand_over_list (residentId: \$residentId ) {
        code
        message
        data
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

  static Future getApointmentScheduleList(String? phone) async {
    var query = '''
      mutation (\$phone:String){
    response: handover_mobile_get_apointment_schedule (phone: \$phone ) {
        code
         data
         message
    }
}
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"phone": phone},
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

  static Future reBookScheduleList(Map<String, dynamic>? data) async {
    var query = '''
    mutation (\$data:Dictionary){
    response: appointment_schedule_change_schedule (data: \$data )
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

  static Future getApartmentContract(String? phone) async {
    var query = '''
     mutation (\$phone:String){
    response: salecontract_mobile_get_apartment_list_contract (phone: \$phone ) {
        code
        message
        data
    }
}
        
        
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"phone": phone},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future veryfyExistScheduleAndSendOTP(
    String? phone,
    String? apartmentId,
    Map<String, dynamic> data,
  ) async {
    var query = '''
 mutation (\$apartmentId:String,\$phone:String,\$data:Dictionary){
    response: handover_mobile_check_existed_apointment_schedule (apartmentId: \$apartmentId,phone: \$phone,data: \$data ) {
        code
        message
        data
    }
}
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"phone": phone, 'apartmentId': apartmentId, "data": data},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future checkReport(
    Map<String, dynamic> data,
    bool isReport,
  ) async {
    var query = '''
mutation (\$data:Dictionary,\$isReport:Boolean){
    response: handover_check_report (data: \$data,isReport: \$isReport )
}
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"data": data, "isReport": isReport},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getDefect() async {
    var query = '''
mutation {
    response: defect_mobile_get_defect  {
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

  static Future errorReport(
    Map<String, dynamic> data,
    String reason,
    String note,
  ) async {
    var query = '''
mutation (\$data:Dictionary,\$reason:String,\$note:String){
    response: handover_error_report (data: \$data,reason: \$reason,note: \$note )
}
        
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'data': data,
        'reason': reason,
        "note": note,
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

  static Future check_handle_handover(
    Map<String, dynamic> data,
  ) async {
    var query = '''
mutation (\$data:Dictionary){
    response: handover_check_handle (data: \$data )
}
        
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'data': data,
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

  static Future getHandOverById(
    String? id,
  ) async {
    var query = '''
mutation (\$id:String){
    response: handover_mobile_get_handover_by_Id (id: \$id ) {
        code
        message
        data
    }
}
        
        
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'id': id,
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

  static Future saveHandOver(
    Map<String, dynamic> data,
  ) async {
    var query = '''
mutation (\$data:Dictionary){
    response: handover_mobile_save_handover (data: \$data ) {
        code
        message
        data
    }
}          
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "data": data,
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

  static Future getResultsWorkByVirtualId(
    String handOverId,
    String? virtualId,
  ) async {
    var query = '''
mutation (\$virtualId:String,\$handOverId:String){
    response: handover_mobile_get_work_arising_by_virtualId (virtualId: \$virtualId,handOverId: \$handOverId ) {
        code
        message
        data
    }
}
         
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "virtualId": virtualId,
        "handOverId": handOverId,
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

  static Future checkComplete(
    Map<String, dynamic> data,
  ) async {
    var query = '''
mutation (\$data:Dictionary){
    response: handover_mobile_check_complete (data: \$data ) {
        code
        message
        data
    }
}
        
         
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "data": data,
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

  static Future getHanOverPerson(
    String? appointmentScheduleId,
  ) async {
    var query = '''
mutation (\$appointmentScheduleId:String){
    response: handover_get_person_handover (appointmentScheduleId: \$appointmentScheduleId ) {
        code
        message
        data
    }
}
        
        
         
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "appointmentScheduleId": appointmentScheduleId,
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
