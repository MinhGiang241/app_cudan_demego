class ResponseRegister {
  String? message;
  int? code;
  dynamic data;

  ResponseRegister({this.data, this.message, this.code});

  ResponseRegister.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    code = json["code"];
    data = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["message"] = message;
    data["code"] = code;
    return data;
  }
}
