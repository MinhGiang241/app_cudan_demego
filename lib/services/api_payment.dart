import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIPayment {
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
      "data": data,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
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
      "data": data,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
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
      "data": data,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getReceiptsList(
      String residentId, String apartmentId, int year, int month) async {
    var query = '''
    mutation (\$residentId:String,\$apartmentId:String,\$year:Float,\$month:Float){
    response: receipts_mobile_get_receipts_by_residentid_and_apartmentId (residentId: \$residentId,apartmentId: \$apartmentId,year: \$year,month: \$month ) {
        code
        message
        data
    }
    }
        
    ''';

    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      "residentId": residentId,
      "apartmentId": apartmentId,
      "year": year,
      "month": month,
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
