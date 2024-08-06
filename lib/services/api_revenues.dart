import 'package:app_cudan/models/response.dart';
import 'package:app_cudan/services/api_service.dart';
import 'package:graphql/client.dart';

class APIRevenues {
  static Future get(
    String? apartmentId,
    int? month,
    int? year,
  ) async {
    var query = '''
    mutation (\$apartmentId:String,\$month:Float,\$year:Float){
    response: servicebill_get_link (apartmentId: \$apartmentId,month: \$month,year: \$year ) {
        code
        message
        data
    }
}

  ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'apartmentId': apartmentId,
        'month': month,
        'year': year,
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
//load html hoa don ky nay
  static Future getHTML(
    String? apartmentId,
  ) async {
    var query = '''
  mutation (\$apartmentId:String){
    response: servicebill_get_current_month_bill (apartmentId: \$apartmentId ) {
        code
        message
        data
    }
}

  ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'apartmentId': apartmentId,
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
