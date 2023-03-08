import 'package:graphql/client.dart';

import '../models/response.dart';
import 'api_service.dart';

class APIExtraService {
  static Future deleteRegistrationService(String id) async {
    var query = '''
  mutation (\$_id: String){
	response: remove_ServiceRegistration_dto(_id:\$_id){
	message
	code
	data {
		  _id
      }
    }
  }
      ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {"_id": id});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future changeStatus(Map<String, dynamic> data) async {
    var query = '''
    mutation (\$data:Dictionary){
    response: service_mobile_change_status_extra_service (data: \$data ) {
        code
        message
        data
      }
  }
        
        
    ''';

    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {"data": data});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future saveRegistrationService(data) async {
    var query = '''
    mutation (\$data:ServiceRegistrationInputDto){
      response:save_ServiceRegistration_dto(data:\$data){
        message
        code
        data{
          _id
        }
      }
    }
    ''';

    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {"data": data});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getPaymentCycle() async {
    var query = '''
    query (\$filter:GeneralCollectionFilterInput){
      response: query_PaymentCycles_dto (filter:\$filter){
        code
        message
        data{ 
        _id
          display_name,
          updatedTime
          createdTime
          name
          isValue
          month
          code
        }
      }
    }
    ''';

    final MutationOptions options =
        MutationOptions(document: gql(query), variables: const {
      "filter": {"limit": 1000}
    });

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getServiceRegistration(
      String residentId, String arisingServiceId, int year, int month) async {
    var query = '''
    mutation (\$residentId:String,\$arisingServiceId:String,\$year:Float,\$month:Float){
    response: service_mobile_get_service_registration_by_residentId_and_arising_service_id (residentId: \$residentId,arisingServiceId: \$arisingServiceId,year: \$year,month: \$month ) {
        code
        message
        data
    }
}
        
    ''';
    final MutationOptions options =
        MutationOptions(document: gql(query), variables: {
      "residentId": residentId,
      "arisingServiceId": arisingServiceId,
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

  static Future getExtraServiceList() async {
    var query = '''
    mutation {
        response: service_mobile_get_extra_service_list  {
            code
            message
            data
        }
    }
      
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(query),
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
