class Status {
  Status({
    this.createdTime,
    this.id,
    this.name,
    this.order,
    this.updatedTime,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? name;
  int? order;

  Status.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    name = json['name'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['name'] = name;
    data['order'] = order;
    return data;
  }
}
