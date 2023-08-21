import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIParcel {
  static Future getParcelList(
    int year,
    int month,
    String phone,
    String? residentId,
    String? apartmentId,
    bool init,
  ) async {
    var query = '''
    mutation (\$year:Float,\$month:Float,\$phone:String,\$init:Boolean,\$residentId:String,\$apartmentId:String){
    response: reception_mobile_find_parcel_by_month (year: \$year,month: \$month,phone: \$phone,init: \$init,residentId: \$residentId,apartmentId: \$apartmentId ) {
        code
        message
        data
    }
}
                
            
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "year": year,
        "month": month,
        "phone": phone,
        "init": init,
        "residentId": residentId,
        "apartmentId": apartmentId,
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

  static Future acceptParcel(Map<String, dynamic> data) async {
    var query = '''
    mutation (\$data:Dictionary){
    response: reception_mobile_change_status_parcel (data: \$data ) {
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
