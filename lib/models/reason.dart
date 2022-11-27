class Reason {
  Reason({
    this.code,
    this.createdTime,
    this.id,
    this.name,
    this.updatedTime,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? name;
  String? code;
  Reason.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    name = json['name'];
    code = json['code'];
  }
}
