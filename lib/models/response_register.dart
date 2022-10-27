class ResponseRegister {
  bool? success;
  String? message;
  int? code;
  dynamic status;

  ResponseRegister({this.success, this.message, this.code});

  ResponseRegister.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"];
    code = json["code"];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    data["message"] = message;
    data["code"] = code;
    return data;
  }
}
