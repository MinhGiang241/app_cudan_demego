// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class RelationShip {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? name;
  String? describe;
  String? code;
  String? display_name;
  RelationShip({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.name,
    this.describe,
    this.code,
    this.display_name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'name': name,
      'describe': describe,
      'code': code,
      'display_name': display_name,
    };
  }

  factory RelationShip.fromMap(Map<String, dynamic> map) {
    return RelationShip(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      describe: map['describe'] != null ? map['describe'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      display_name:
          map['display_name'] != null ? map['display_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RelationShip.fromJson(String source) =>
      RelationShip.fromMap(json.decode(source) as Map<String, dynamic>);
}
