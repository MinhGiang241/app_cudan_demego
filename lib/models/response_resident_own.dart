// ignore_for_file: non_constant_identifier_names

import 'response_resident_info.dart';

class ResponseResidentOwn {
  String? id;
  String? createdTime;
  String? updatedTime;
  bool? isLocked;
  bool? isDraft;
  String? residentId;
  String? buildingId;
  String? floorId;
  String? apartmentId;
  String? type;
  String? status;
  Building? building;
  ResponseResidentInfo? resident;
  Apartment? apartment;
  Floor? floor;

  ResponseResidentOwn({
    this.apartmentId,
    this.buildingId,
    this.createdTime,
    this.floorId,
    this.id,
    this.isDraft,
    this.isLocked,
    this.residentId,
    this.status,
    this.type,
    this.updatedTime,
    this.apartment,
  });

  ResponseResidentOwn.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    isLocked = json['isLocked'];
    isDraft = json['isDraft'];
    residentId = json['residentId'];
    buildingId = json['buildingId'];
    floorId = json['floorId'];
    apartmentId = json['apartmentId'];
    type = json['type'];
    status = json['status'];
    building = Building.fromJson(json['building']);
    resident = ResponseResidentInfo.fromJson(json['resident']);
    floor = Floor.fromJson(json['floor']);
    apartment = Apartment.fromJson(json['apartment']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['isLocked'] = isLocked;
    data['isDraft'] = isDraft;
    data['residentId'] = residentId;
    data['buildingId'] = buildingId;
    data['apartmentId'] = apartmentId;
    data['floorId'] = floorId;
    data['type'] = type;
    data['status'] = status;
    return data;
  }
}

class Building {
  String? id;
  String? createdTime;
  String? updatedTime;
  bool? isLocked;
  bool? isDraft;
  String? code;
  String? name;
  Building({
    this.code,
    this.createdTime,
    this.id,
    this.isDraft,
    this.isLocked,
    this.name,
    this.updatedTime,
  });
  Building.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    isLocked = json['isLocked'];
    isDraft = json['isDraft'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['isLocked'] = isLocked;
    data['isDraft'] = isDraft;
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}

class Apartment {
  String? id;
  String? createdTime;
  String? updatedTime;
  bool? isLocked;
  bool? isDraft;
  String? code;
  String? name;
  int? area;
  String? buildingId;
  String? floorId;
  String? apartment_type;
  String? apartment_status;
  String? apartmentTypeId;
  String? status;
  Apartment({
    this.code,
    this.createdTime,
    this.id,
    this.isDraft,
    this.isLocked,
    this.name,
    this.updatedTime,
    this.apartmentTypeId,
    this.apartment_status,
    this.apartment_type,
    this.area,
    this.buildingId,
    this.floorId,
    this.status,
  });

  Apartment.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    isLocked = json['isLocked'];
    isDraft = json['isDraft'];
    code = json['code'];
    name = json['name'];
    area = json['area'];
    buildingId = json['buildingId'];
    floorId = json['floorId'];
    apartment_type = json['apartment_type'];
    apartment_status = json['apartment_status'];
    apartmentTypeId = json['apartmentTypeId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['isLocked'] = isLocked;
    data['isDraft'] = isDraft;
    data['code'] = code;
    data['name'] = name;
    data['area'] = area;
    data['buildingId'] = buildingId;
    data['floorId'] = floorId;
    data['apartment_type'] = apartment_type;
    data['apartment_status'] = apartment_status;
    data['apartmentTypeId'] = apartmentTypeId;
    data['apartmentTypeId'] = apartmentTypeId;
    data['status'] = status;
    return data;
  }
}

class Floor {
  String? id;
  String? createdTime;
  String? updatedTime;
  bool? isLocked;
  bool? isDraft;
  String? code;
  String? name;
  String? buildingId;
  int? area;

  Floor({
    this.area,
    this.buildingId,
    this.code,
    this.createdTime,
    this.id,
    this.isDraft,
    this.isLocked,
    this.name,
    this.updatedTime,
  });
  Floor.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    isLocked = json['isLocked'];
    isDraft = json['isDraft'];
    code = json['code'];
    name = json['name'];
    area = json['area'];
    buildingId = json['buildingId'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['isLocked'] = isLocked;
    data['isDraft'] = isDraft;
    data['code'] = code;
    data['name'] = name;
    data['area'] = area;
    data['buildingId'] = buildingId;
    return data;
  }
}
