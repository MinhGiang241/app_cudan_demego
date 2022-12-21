// ignore_for_file: non_constant_identifier_names

class MissingObject {
  MissingObject({
    this.apartment,
    this.code,
    this.createdTime,
    this.customer,
    this.describe,
    this.findTime,
    this.id,
    this.image,
    this.phone_number,
    this.status,
    this.time,
    this.name,
    this.updatedTime,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? customer;
  String? phone_number;
  String? apartment;
  String? status;
  String? time;
  String? describe;
  String? name;
  String? findTime;
  List<MissingImage>? image;
  MissingObject.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    customer = json['customer'];
    phone_number = json['phone_number'];
    apartment = json['apartment'];
    status = json['status'];
    time = json['time'];
    describe = json['describe'];
    findTime = json['findTime'];
    name = json['name'];
    image = json['image'] != null
        ? json['image'].isNotEmpty
            ? json['image']
                .map<MissingImage>((e) => MissingImage.fromJson(e))
                .toList()
            : []
        : [];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['code'] = code;
    data['customer'] = customer;
    data['phone_number'] = phone_number;
    data['apartment'] = apartment;
    data['status'] = status;
    data['time'] = time;
    data['describe'] = describe;
    data['findTime'] = findTime;
    data['describe'] = describe;
    data['name'] = name;
    data['image'] = image != null
        ? image!.map((e) {
            e.toJson();
          }).toList()
        : [];
    return data;
  }
}

class MissingImage {
  String? file_id;
  String? name;
  MissingImage.fromJson(Map<String, dynamic> json) {
    file_id = json['file_id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_id'] = file_id;
    data['name'] = name;
    return data;
  }
}
