import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIElectricity {
  static Future getIndicatorByYear(String? apartmentId, int year) async {
    var query = '''
        mutation (\$apartmentId:String,\$year:Float){
    response: indicator_mobile_get_indicator_by_apartmentId_and_year (apartmentId: \$apartmentId,year: \$year ) {
        code
        message
        data
    }
}        
      ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        "apartmentId": apartmentId,
        "year": year,
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
}
