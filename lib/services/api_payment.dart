// ignore_for_file: require_trailing_commas

import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIPayment {
  static Future getReceiptListFromTo(
    String from,
    String to,
    String? apartmentId,
  ) async {
    var query = '''
       mutation (\$from:DateTime,\$to:DateTime,\$apartmentId:String){
    response: servicebill_mobile_get_receipts_by_apartmentId (from: \$from,to: \$to,apartmentId: \$apartmentId ) {
        code
        message
        data
    }
} 
        
  ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      'from': from,
      'to': to,
      'apartmentId': apartmentId,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future makePayment(Map<String, dynamic> data) async {
    var query = '''
    mutation (\$data:Dictionary){
    response: receipts_mobile_make_payment_receipts (data: \$data ) {
        code
        message
        data
    }
}
        
        
  ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      'data': data,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future saveHistoryTransaction(List<Map<String, dynamic>> data) async {
    var query = '''
    mutation(\$data: [TransactionHistoryInputDto] ){
	response:save_many_TransactionHistory_dto(data:\$data){
		code
		message
		data
    }
  }
  ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      'data': data,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future saveManyPayment(List<Map<String, dynamic>> data) async {
    var query = '''
    mutation(\$data: [ReceiptsInputDto] ){
      response:save_many_Receipts_dto(data:\$data){
        code
        message
        data
      }
    }
   ''';

    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      'data': data,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getReceiptsList(String? residentId, String? apartmentId,
      int year, int month, String phone) async {
    var query = '''
   
    mutation (\$residentId:String,\$apartmentId:String,\$year:Float,\$month:Float,\$phone:String){
    response: receipts_mobile_get_receipts_by_residentid_and_apartmentId (residentId: \$residentId,apartmentId: \$apartmentId,year: \$year,month: \$month,phone: \$phone ) {
        code
        message
        data
    }
}
        
        
    ''';

    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      'residentId': residentId,
      'apartmentId': apartmentId,
      'year': year,
      'month': month,
      'phone': phone,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }

  static Future getReceipt(String receiptId) async {
    var query = '''
   mutation (\$receiptId:String){
    response: receipts_mobile_find_receipts_by_id (receiptId: \$receiptId ) {
        code
        message
        data
    }
}
        
        
    ''';

    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      'receiptId': receiptId,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? '');
    } else {
      return res.response.data;
    }
  }
}
