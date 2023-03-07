import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIProvince {
  static Future getProvince() async {
    var query = '''
    query {
      response: query_Provinces_dto{
        message
        code 
        data {
          _id
          createdTime
          updatedTime
          code
          display_name
          name
          name_with_type
          region
          slug
          type
          vnp_code
        }
      }
    }
    ''';
    final QueryOptions options = QueryOptions(document: gql(query));

    final results = await ApiService.shared.graphqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getDistric(provinceCode) async {
    var query = '''
    mutation (\$provinceCode:String){
    response: district_mobile_get_dictric_by_province_code (provinceCode: \$provinceCode ) {
        code
        message
        data
    }
}
        
    ''';
    final MutationOptions options = MutationOptions(
        document: gql(query), variables: {"provinceCode": provinceCode});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getWards(districtCode) async {
    var query = '''
    mutation (\$districtCode:String){
    response: wards_mobile_get_wards_by_district_code (districtCode: \$districtCode ) {
        code
        message
        data
    }
}
        
        
    ''';
    final MutationOptions options = MutationOptions(
        document: gql(query), variables: {"districtCode": districtCode});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }
}
