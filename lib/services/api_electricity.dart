import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIElectricity {
  static Future getElectricFee() async {
    var query = '''
    query {
	response : query_ElectricFees_dto {
		message
		code
		data {
			_id
			createdTime
			updatedTime
			fixed_price,
			electric_fee {
				from
				to
				price
			}
			message
		}
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

  static Future getMonthElectricIndicator(
    String? apartmentId,
    int year,
    int month,
  ) async {
    var query = '''
         mutation (\$apartmentId:String,\$year:Float,\$month:Float){
    response: indicator_mobile_get_indicator_by_month (apartmentId: \$apartmentId,year: \$year,month: \$month ) {
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
        "month": month,
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

  static Future getReceiptByYear(
    String? apartmentId,
    int year,
    bool isElectric,
  ) async {
    var query = '''
        mutation (\$year:Float,\$apartmentId:String,\$isElectric:Boolean){
    response: receipts_mobile_find_electricity_receipt_by_apartmentId_and_month_year (year: \$year,apartmentId: \$apartmentId,isElectric: \$isElectric ) {
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
        "isElectric": isElectric,
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
