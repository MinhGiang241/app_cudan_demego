class ChatSubject {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? name;
  String? code;
  String? note;
  ChatSubject({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.name,
    this.code,
    this.note,
  });

  ChatSubject.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    name = json['name'];
    code = json['code'];
    note = json['note'];
  }
}
