import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIParcel {
  static Future getParcelList(int year, int month, String phone) async {
    var query = '''
    mutation (\$year:Float,\$month:Float,\$phone:String){
        response: reception_mobile_find_parcel_by_phone_and_month (year: \$year,month: \$month,phone: \$phone ) {
            code
            message
            data
        }
    }
            
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {"year": year, "month": month, "phone": phone},
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
