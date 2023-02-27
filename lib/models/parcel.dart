// ignore_for_file: non_constant_identifier_names

import 'status.dart';

class Parcel {
  Parcel({
    this.code,
    this.createdTime,
    this.customer,
    this.describe,
    this.id,
    this.image,
    this.name,
    this.phone_number,
    this.staffGetId,
    this.staffOutId,
    this.status,
    this.time_get,
    this.time_out,
    this.s,
    this.updatedTime,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? name;
  String? customer;
  String? phone_number;
  String? status;
  String? staffGetId;
  String? time_get;
  String? describe;
  String? time_out;
  String? staffOutId;
  Status? s;
  List<ParcelImage>? image;

  Parcel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    name = json['name'];
    customer = json['customer'];
    phone_number = json['phone_number'];
    status = json['status'];
    staffGetId = json['staffGetId'];
    time_get = json['time_get'];
    time_out = json['time_out'];
    describe = json['describe'];
    staffOutId = json['staffOutId'];
    s = json['s'] != null ? Status.fromJson(json['s']) : null;
    image = json['image'] != null
        ? json['image'].isNotEmpty
            ? json['image']
                .map<ParcelImage>((e) => ParcelImage.fromJson(e))
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
    data['name'] = name;
    data['customer'] = customer;
    data['phone_number'] = phone_number;
    data['status'] = status;
    data['staffGetId'] = staffGetId;
    data['time_get'] = time_get;
    data['time_out'] = time_out;
    data['describe'] = describe;
    data['staffOutId'] = staffOutId;
    data['image'] = image != null
        ? image!.map((e) {
            return e.toJson();
          }).toList()
        : [];
    return data;
  }
}

class ParcelImage {
  String? id;
  String? name;
  ParcelImage.fromJson(Map<String, dynamic> json) {
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
