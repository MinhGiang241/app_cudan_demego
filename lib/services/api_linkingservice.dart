import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APILinkingService {
  static Future getProductListInShop(
    String? serviceId,
    int skip,
    int limit,
    String search,
  ) async {
    var query = '''
mutation (\$serviceId:String,\$skip:Float,\$limit:Float,\$search:String){
    response: linkingservice_mobile_get_product_list (serviceId: \$serviceId,skip: \$skip,limit: \$limit,search: \$search ) {
        code
        message
        data
    }
}
        
        
        
    ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'serviceId': serviceId,
        'skip': skip,
        'limit': limit,
        "search": search,
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

  static Future getImageListInShop(
    String? linkingserviceId,
    String? productId,
    int skip,
    int limit,
  ) async {
    var query = '''
mutation (\$linkingserviceId:String,\$skip:Float,\$limit:Float,\$productId:String){
    response: linkingservice_mobile_get_images_by_linkingserviceId (linkingserviceId: \$linkingserviceId,skip: \$skip,limit: \$limit,productId: \$productId ) {
        code
        message
        data
    }
}

    ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'linkingserviceId': linkingserviceId,
        'productId': productId,
        'skip': skip,
        'limit': limit,
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

  static Future getLinkingServiceList(
    String search,
    String industries,
  ) async {
    var query = '''
mutation (\$search:String,\$industries:String){
    response: linkingservice_mobile_get_all_linking_service_list (search: \$search,industries: \$industries ) {
        code
        message
        data
    }
}

    ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'search': search,
        'industries': industries,
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

  static Future countHit(
    String? serviceId,
  ) async {
    var query = '''
mutation (
  \$serviceId:String){
    response: linkingservice_count_hits (serviceId: \$serviceId ) {
        code
        message
        data
    }
}


    ''';
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: {
        'serviceId': serviceId,
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
