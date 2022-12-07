class New {
  New({
    this.code,
    this.content,
    this.createdTime,
    this.date,
    this.detail,
    this.employeeId,
    this.id,
    this.image,
    this.isSend,
    this.title,
    this.type,
    this.updatedTime,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? title;
  String? date;
  String? type;
  String? content;
  String? detail;
  String? image;
  String? employeeId;
  bool? isSend;

  New.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    title = json['title'];
    date = json['date'];
    type = json['type'];
    content = json['content'];
    detail = json['detail'];
    image = json['image'];
    employeeId = json['employeeId'];
    isSend = json['isSend'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['code'] = code;
    data['title'] = title;
    data['date'] = date;
    data['type'] = type;
    data['content'] = content;
    data['detail'] = detail;
    data['image'] = image;
    data['employeeId'] = employeeId;
    data['isSend'] = isSend;
    return data;
  }
}
