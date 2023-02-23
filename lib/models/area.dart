import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class Area {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? type;
  String? name;
  String? pin_name;
  String? code;
  String? buildingId;
  String? floorId;
  Area({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.type,
    this.name,
    this.pin_name,
    this.code,
    this.buildingId,
    this.floorId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'type': type,
      'name': name,
      'pin_name': pin_name,
      'code': code,
      'buildingId': buildingId,
      'floorId': floorId,
    };
  }

  factory Area.fromMap(Map<String, dynamic> map) {
    return Area(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      pin_name: map['pin_name'] != null ? map['pin_name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      buildingId:
          map['buildingId'] != null ? map['buildingId'] as String : null,
      floorId: map['floorId'] != null ? map['floorId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Area.fromJson(String source) =>
      Area.fromMap(json.decode(source) as Map<String, dynamic>);
}
