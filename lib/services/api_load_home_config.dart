import 'api_service.dart';

class ApiLoadHomeConfig{
  static Future load_home_config() async{
    var query='''mutation {
    response: residentapp_load_home_config  {
        code
        message
        data
    }
}
        ''';
    var data= await ApiService.shared.executeGraphQueryResponse(query, null);
    return data;

  }
}