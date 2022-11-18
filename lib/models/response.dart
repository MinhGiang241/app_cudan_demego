class ResponseModule {
  late Response response;

  ResponseModule({required this.response});

  ResponseModule.fromJson(Map<String, dynamic> json) {
    response = Response.fromJson(json["response"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["response"] = response.toJson();
    return data;
  }
}

class Response {
  late int code;
  late String? message;
  dynamic data;
  Response({required this.code, this.data, this.message});
  Response.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}
