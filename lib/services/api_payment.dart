import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIPayment {
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
