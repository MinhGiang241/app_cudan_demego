import 'dart:convert';

import 'package:app_cudan/models/response_resident_own.dart';

import 'resident_info.dart';

class ApartmentRelationship {
  String? id;
  ResponseResidentOwn? ownInfo;
  List<ResponseResidentInfo>? residents;
  Apartment? apartment;
  Building? building;
  Floor? floor;
  ApartmentRelationship({
    this.id,
    this.ownInfo,
    this.residents,
    this.apartment,
    this.building,
    this.floor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'ownInfo': ownInfo?.toJson(),
      'residents': residents?.map((x) => x.toJson()).toList(),
      'apartment': apartment?.toJson(),
      'building': building?.toJson(),
      'floor': floor?.toJson(),
    };
  }

  factory ApartmentRelationship.fromMap(Map<String, dynamic> map) {
    return ApartmentRelationship(
      id: map['id'] != null ? map['id'] as String : null,
      ownInfo: map['ownInfo'] != null
          ? ResponseResidentOwn.fromJson(map['ownInfo'] as Map<String, dynamic>)
          : null,
      residents: map['residents'] != null
          ? List<ResponseResidentInfo>.from(
              (map['residents'] as List<dynamic>).map<ResponseResidentInfo?>(
                (x) => ResponseResidentInfo.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      apartment: map['apartment'] != null
          ? Apartment.fromJson(map['apartment'] as Map<String, dynamic>)
          : null,
      floor: map['floor'] != null
          ? Floor.fromJson(map['floor'] as Map<String, dynamic>)
          : null,
      building: map['building'] != null
          ? Building.fromJson(map['building'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApartmentRelationship.fromJson(String source) =>
      ApartmentRelationship.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
