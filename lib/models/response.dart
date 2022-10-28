class ResponseModule {
  String? error;
  dynamic response;

  ResponseModule({this.response, this.error});

  ResponseModule.fromJson(Map<String, dynamic> json) {
    response = json["response"];

    error = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["response"] = response;
    data["error"] = error;
    return data;
  }
}
