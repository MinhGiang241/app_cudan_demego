import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIConstruction {
  static Future changeStatus(
    Map<String, dynamic> data,
    List<Map<String, dynamic>>? receipts,
    Map<String, dynamic> history,
  ) async {
    var query = '''
        mutation (\$data:Dictionary,\$receipts:Dictionary,\$history:Dictionary){
    response: constructionregistration_mobile_change_status (data: \$data,receipts: \$receipts,history: \$history ) {
        code
        message
        data
    }
}
           
      ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {'data': data, 'receipts': receipts, 'history': history},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future removeConstructionHistory(String id) async {
    var query = '''
        mutation (\$constructionRegistrationId:String){
    response: constructiondocumenthistory_mobile_remove_construction_history (constructionRegistrationId: \$constructionRegistrationId ) {
        code
        message
        data
    }
}
        
      ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {'constructionRegistrationId': id},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future removeConstructionRegistration(String id) async {
    var query = '''
        mutation (\$_id: String){
    response: remove_ConstructionRegistration_dto(_id:\$_id){
      code
      message
      data {
        _id
      }
    }
    }
      ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {'_id': id});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future saveConstructionHistory(data) async {
    var query = '''
        mutation(\$data:ConstructionHistoryInputDto ){
      response: save_ConstructionHistory_dto(data:\$data){
        code
        message
        data {
          _id
        }
      }
    }
      ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {'data': data});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future saveConstructionRegistration(data) async {
    var query = '''
          
          mutation (\$data:ConstructionRegistrationInputDto){
      response: save_ConstructionRegistration_dto(data:\$data){
        code
        message,
        data {
          _id
        }
      }
    }
      ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {'data': data});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getDayOff() async {
    var query = '''
   mutation {
    response: construction_mobile_get_dayoff  {
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
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionTypeList() async {
    var query = '''
    mutation {
    response: construction_mobile_get_constructioType_list  {
        code
        message
        data
    }
    }
        
    ''';
    final MutationOptions options = MutationOptions(document: gql(query));

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionHistory(
    String constructionregistrationId,
  ) async {
    var query = '''
    mutation (\$constructionregistrationId:String){
        response: constructiondocumenthistory_mobile_get_construction_history (constructionregistrationId: \$constructionregistrationId ) {
            code
            message
            data
        }
    }
              
  ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'constructionregistrationId': constructionregistrationId,
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionDocumentHistory(
    String constructionDocumentId,
  ) async {
    var query = '''
    mutation (\$constructionDocumentId:String){
    response: constructiondocument_mobile_get_construction_document_history (constructionDocumentId: \$constructionDocumentId ) {
        code
        message
        data
    }
}
        
              
  ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'constructionDocumentId': constructionDocumentId,
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionDocumentList(
    String residentId,
    String apartmentId,
  ) async {
    var query = '''
    mutation (\$residentId:String,\$apartmentId:String){
        response: constructiondocument_mobile_get_construction_document_by_residentId_and_apartmentId (residentId: \$residentId,apartmentId: \$apartmentId ) {
            code
            message
            data
        }
    }
            
    ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {'residentId': residentId, 'apartmentId': apartmentId},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionRegistrationList(
    String residentId,
    String apartmentId,
  ) async {
    var query = '''
    mutation (\$residentId:String,\$apartmentId:String){
        response: constructionregistration_mobile_get_constructionregistration_by_residentId_and_apartmentId (residentId: \$residentId,apartmentId: \$apartmentId ) {
            code
            message
            data
        }
    }
            
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {'residentId': residentId, 'apartmentId': apartmentId},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionRegistrationListWait(
    String residentId,
  ) async {
    var query = '''
   mutation (\$residentId:String){
    response: constructionregistration_get_list_wait_confirm (residentId: \$residentId ) {
        code
        message
        data
    }
}
        
            
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'residentId': residentId,
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future saveNewConstructionRegistration(
    Map<String, dynamic> register,
    Map<String, dynamic>? history,
    List<Map<String, dynamic>?>? receipt,
  ) async {
    var query = '''
    mutation (\$history:Dictionary,\$receipt:Dictionary,\$register:Dictionary){
    response: constructionregistration_mobile_save_construction_registration (history: \$history,receipt: \$receipt,register: \$register ) {
        code
        message
        data
      }
    }
            
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {'history': history, 'receipt': receipt, 'register': register},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionBills(
    String constructionregistrationId,
    String? residentId,
  ) async {
    var query = '''
   mutation (\$constructionregistrationId:String,\$residentId:String){
    response: constructionregistration_mobile_get_receipts_by_constructionregistrationId (constructionregistrationId: \$constructionregistrationId,residentId: \$residentId ) {
        code
        message
        data
    }
}
           
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'constructionregistrationId': constructionregistrationId,
        'residentId': residentId,
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getFixedDateService() async {
    var query = '''
   mutation {
    response: service_mobile_get_fixed_serviced  {
        code
        message
        data
      }
    }
    
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: const {
        'filter': {'limit': 1000},
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future ownerChangeStatus(
    Map<String, dynamic> data,
    List<Map<String, dynamic>> receiptList,
  ) async {
    var query = '''
 mutation (\$data:Dictionary,\$receiptList:Dictionary){
    response: constructionregistration_owner_refuse_or_accept (data: \$data,receiptList: \$receiptList ) {
        code
        message
        data
    }
}
        
        
           
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {'data': data, "receiptList": receiptList},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionExtensionList(
    String? residentId,
  ) async {
    var query = '''
mutation (\$residentId:String){
    response: construction_mobile_get_construction_extension_list (residentId: \$residentId ) {
        code
        message
        data
    }
}
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {'residentId': residentId},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionStopList(
    String? residentId,
  ) async {
    var query = '''
mutation (\$residentId:String){
    response: construction_mobile_get_construction_stop_list (residentId: \$residentId ) {
        code
        message
        data
    }
}

    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {'residentId': residentId},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionDocumentListByApartmentId(
    String? apartmentId,
  ) async {
    var query = '''
        mutation (\$apartmentId:String){
    response: construction_mobile_get_construction_document_by_apartmentId (apartmentId: \$apartmentId ) {
        code
        message
        data
    }
}
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {'apartmentId': apartmentId},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future saveConstructionExtension(
    Map<String, dynamic> data,
  ) async {
    var query = '''
mutation (\$data:Dictionary){
    response: construction_mobile_save_construction_extension (data: \$data ) {
        code
        message
        data
    }
}
        
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {'data': data},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future saveAndChangeConstructionStop(
    Map<String, dynamic> data,
    String status,
    String? reason,
    bool? editable,
  ) async {
    var query = '''
mutation (\$data:Dictionary,\$status:String,\$reason:String,\$note:String,\$editable:Boolean,\$file_cancel:Dictionary){
    response: constructiontemporarilystopped_change_status (data: \$data,status: \$status,reason: \$reason,note: \$note,editable: \$editable,file_cancel: \$file_cancel )
}

    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'data': data,
        'status': status,
        'reason': reason,
        'editable': editable,
      },
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future changeStatusConstructionExtension(
    Map<String, dynamic> data,
  ) async {
    var query = '''
mutation (\$data:Dictionary){
    response: construction_mobile_change_status_construction_extension (data: \$data ) {
        code
        message
        data
    }
}
                
        
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {'data': data},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionExtensionWaitList(
    String? residentId,
  ) async {
    var query = '''
mutation (\$residentId:String){
    response: construction_mobile_get_wait_owner_construction_extension (residentId: \$residentId ) {
        code
        message
        data
    }
}
                         
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {'residentId': residentId},
    );

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getConstructionContentList() async {
    var query = '''
mutation {
    response: constructioncontent_mobile_get_construction_content_list  {
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
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }
}
