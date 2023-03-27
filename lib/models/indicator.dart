import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class Indicator {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? residentId;
  String? apartmentId;
  String? employeeId;
  String? phone;
  double? electricity_head;
  double? water_head;
  int? year;
  int? month;
  bool? latch;
  String? owner_name;
  String? phone_number;
  Indicator({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.residentId,
    this.apartmentId,
    this.employeeId,
    this.phone,
    this.electricity_head,
    this.water_head,
    this.year,
    this.month,
    this.latch,
    this.owner_name,
    this.phone_number,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'residentId': residentId,
      'apartmentId': apartmentId,
      'employeeId': employeeId,
      'phone': phone,
      'electricity_head': electricity_head,
      'water_head': water_head,
      'year': year,
      'month': month,
      'latch': latch,
      'owner_name': owner_name,
      'phone_number': phone_number,
    };
  }

  factory Indicator.fromMap(Map<String, dynamic> map) {
    return Indicator(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      employeeId:
          map['employeeId'] != null ? map['employeeId'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      electricity_head:
          double.tryParse(map['electricity_head'].toString()) != null
              ? double.parse(map['electricity_head'].toString())
              : null,
      water_head: double.tryParse(map['water_head'].toString()) != null
          ? double.parse(map['water_head'].toString())
          : null,
      year: int.tryParse(map['year'].toString()) != null
          ? int.parse(map['year'].toString())
          : null,
      month: int.tryParse(map['month'].toString()) != null
          ? int.parse(map['month'].toString())
          : null,
      latch: map['latch'] != null ? map['latch'] as bool : null,
      owner_name:
          map['owner_name'] != null ? map['owner_name'] as String : null,
      phone_number:
          map['phone_number'] != null ? map['phone_number'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Indicator.fromJson(String source) =>
      Indicator.fromMap(json.decode(source) as Map<String, dynamic>);
}
