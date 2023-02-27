// ignore_for_file: non_constant_identifier_names

import 'status.dart';

class MissingObject {
  MissingObject({
    this.apartmentId,
    this.code,
    this.createdTime,
    this.customer,
    this.describe,
    this.find_time,
    this.find_place,
    this.id,
    this.image,
    this.phone_number,
    this.status,
    this.time,
    this.name,
    this.updatedTime,
    this.lost_time,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? customer;
  String? phone_number;
  String? apartmentId;
  String? status;
  String? time;
  String? describe;
  String? name;
  String? find_time;
  String? find_place;
  String? lost_time;
  List<MissingImage>? image;
  Status? s;
  MissingObject.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    customer = json['customer'];
    phone_number = json['phone_number'];
    apartmentId = json['apartmentId'];
    status = json['status'];
    time = json['time'];
    describe = json['describe'];
    find_time = json['find_time'];
    find_place = json['find_place'];
    lost_time = json['lost_time'];
    name = json['name'];
    s = json['s'] != null ? Status.fromJson(json['s']) : null;
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
    data['apartmentId'] = apartmentId;
    data['status'] = status;
    data['time'] = time;
    data['describe'] = describe;
    data['find_time'] = find_time;
    data['find_place'] = find_place;
    data['describe'] = describe;
    data['lost_time'] = lost_time;
    data['name'] = name;
    data['image'] = image != null
        ? image!.map((e) {
            return e.toJson();
          }).toList()
        : [];
    return data;
  }
}

class MissingImage {
  MissingImage({this.id, this.name});
  String? id;
  String? name;
  MissingImage.fromJson(Map<String, dynamic> json) {
    id = json['file_id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_id'] = id;
    data['name'] = name;
    return data;
  }
}

class LootItem {
  LootItem({
    this.address,
    this.code,
    this.createdTime,
    this.date,
    this.describe,
    this.id,
    this.name,
    this.residential,
    this.status,
    this.tel,
    this.time_pay,
    this.updatedTime,
    this.photo,
    this.s,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? residential;
  String? tel;
  String? date;
  String? status;
  String? address;
  String? describe;
  String? name;
  String? time_pay;
  List<MissingImage>? photo;
  Status? s;
  LootItem.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    residential = json['residential'];
    tel = json['tel'];
    date = json['date'];
    status = json['status'];
    address = json['address'];
    describe = json['describe'];
    name = json['name'];
    time_pay = json['time_pay'];
    s = json['s'] != null ? Status.fromJson(json['s']) : null;
    photo = json['photo'] != null
        ? json['photo'].isNotEmpty
            ? json['photo']
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
    data['residential'] = residential;
    data['tel'] = tel;
    data['date'] = date;
    data['status'] = status;
    data['address'] = address;
    data['residential'] = residential;
    data['describe'] = describe;
    data['name'] = name;
    data['time_pay'] = time_pay;
    data['photo'] = photo != null
        ? photo!.map((e) {
            return e.toJson();
          }).toList()
        : [];
    return data;
  }
}
