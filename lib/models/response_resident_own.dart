// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:app_cudan/models/relationship.dart';

import 'resident_info.dart';

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
  RelationShip? r;
  String? relationshipId;

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
    this.relationshipId,
    this.r,
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
    relationshipId = json['relationshipId'];
    r = json['r'] != null ? RelationShip.fromMap(json['r']) : null;
    building =
        json['building'] != null ? Building.fromJson(json['building']) : null;
    resident = json['resident'] != null
        ? ResponseResidentInfo.fromJson(json['resident'])
        : null;
    floor = json['floor'] != null ? Floor.fromJson(json['floor']) : null;
    apartment = json['apartment'] != null
        ? Apartment.fromJson(json['apartment'])
        : null;
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
    data['building'] = building != null ? building!.toJson() : null;
    data['floor'] = floor != null ? floor!.toJson() : null;
    data['apartment'] = apartment != null ? apartment!.toJson() : null;
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
  double? area;
  String? buildingId;
  String? floorId;
  String? apartment_type;
  String? apartment_status;
  String? apartmentTypeId;
  String? status;
  String? electrical_code;
  String? water_code;
  Building? b;
  Floor? f;
  Apartment({
    this.electrical_code,
    this.water_code,
    this.code,
    this.f,
    this.b,
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
    area = json['area'] != null
        ? double.tryParse(json['area'].toString()) != null
            ? double.parse(json['area'].toString())
            : 0
        : 0;
    buildingId = json['buildingId'];
    floorId = json['floorId'];
    apartment_type = json['apartment_type'];
    apartment_status = json['apartment_status'];
    apartmentTypeId = json['apartmentTypeId'];
    status = json['status'];
    electrical_code = json['electrical_code'];
    water_code = json['water_code'];
    b = json['b'] != null ? Building.fromJson(json['b']) : null;
    f = json['f'] != null ? Floor.fromJson(json['f']) : null;
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
  double? area;
  Building? b;

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
    this.b,
  });
  Floor.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    isLocked = json['isLocked'];
    isDraft = json['isDraft'];
    code = json['code'];
    name = json['name'];
    area = json['area'] != null
        ? double.tryParse(json['area'].toString()) != null
            ? double.parse(json['area'].toString())
            : 0
        : 0;
    buildingId = json['buildingId'];
    b = json['b'] != null ? Building.fromJson(json['b']) : null;
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

class ResidentInfoFromHO {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? info_name;
  String? sex;
  String? date_birth;
  String? residence_type;
  String? phone_required;
  String? email;
  String? nationalId;
  String? identity_card_required;
  String? place_of_issue_required;
  String? job;
  String? permanent_address;
  String? provinceId;
  String? districtId;
  String? wardsId;
  String? code;
  List<OwnInfofromHO>? owninfo;
  ResidentInfoFromHO({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.info_name,
    this.sex,
    this.date_birth,
    this.residence_type,
    this.phone_required,
    this.email,
    this.nationalId,
    this.identity_card_required,
    this.place_of_issue_required,
    this.job,
    this.permanent_address,
    this.provinceId,
    this.districtId,
    this.wardsId,
    this.code,
    this.owninfo,
  });

  ResidentInfoFromHO copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? info_name,
    String? sex,
    String? date_birth,
    String? residence_type,
    String? phone_required,
    String? email,
    String? nationalId,
    String? identity_card_required,
    String? place_of_issue_required,
    String? job,
    String? permanent_address,
    String? provinceId,
    String? districtId,
    String? wardsId,
    String? code,
    List<OwnInfofromHO>? owninfo,
  }) {
    return ResidentInfoFromHO(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      info_name: info_name ?? this.info_name,
      sex: sex ?? this.sex,
      date_birth: date_birth ?? this.date_birth,
      residence_type: residence_type ?? this.residence_type,
      phone_required: phone_required ?? this.phone_required,
      email: email ?? this.email,
      nationalId: nationalId ?? this.nationalId,
      identity_card_required:
          identity_card_required ?? this.identity_card_required,
      place_of_issue_required:
          place_of_issue_required ?? this.place_of_issue_required,
      job: job ?? this.job,
      permanent_address: permanent_address ?? this.permanent_address,
      provinceId: provinceId ?? this.provinceId,
      districtId: districtId ?? this.districtId,
      wardsId: wardsId ?? this.wardsId,
      code: code ?? this.code,
      owninfo: owninfo ?? this.owninfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'info_name': info_name,
      'sex': sex,
      'date_birth': date_birth,
      'residence_type': residence_type,
      'phone_required': phone_required,
      'email': email,
      'nationalId': nationalId,
      'identity_card_required': identity_card_required,
      'place_of_issue_required': place_of_issue_required,
      'job': job,
      'permanent_address': permanent_address,
      'provinceId': provinceId,
      'districtId': districtId,
      'wardsId': wardsId,
      'code': code,
      'owninfo': owninfo?.map((x) => x.toMap()).toList(),
    };
  }

  factory ResidentInfoFromHO.fromMap(Map<String, dynamic> map) {
    return ResidentInfoFromHO(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      info_name: map['info_name'] != null ? map['info_name'] as String : null,
      sex: map['sex'] != null ? map['sex'] as String : null,
      date_birth:
          map['date_birth'] != null ? map['date_birth'] as String : null,
      residence_type: map['residence_type'] != null
          ? map['residence_type'] as String
          : null,
      phone_required: map['phone_required'] != null
          ? map['phone_required'] as String
          : null,
      email: map['email'] != null ? map['email'] as String : null,
      nationalId:
          map['nationalId'] != null ? map['nationalId'] as String : null,
      identity_card_required: map['identity_card_required'] != null
          ? map['identity_card_required'] as String
          : null,
      place_of_issue_required: map['place_of_issue_required'] != null
          ? map['place_of_issue_required'] as String
          : null,
      job: map['job'] != null ? map['job'] as String : null,
      permanent_address: map['permanent_address'] != null
          ? map['permanent_address'] as String
          : null,
      provinceId:
          map['provinceId'] != null ? map['provinceId'] as String : null,
      districtId:
          map['districtId'] != null ? map['districtId'] as String : null,
      wardsId: map['wardsId'] != null ? map['wardsId'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      owninfo: map['owninfo'] != null
          ? List<OwnInfofromHO>.from(
              (map['owninfo'] as List<dynamic>).map<OwnInfofromHO?>(
                (x) => OwnInfofromHO.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResidentInfoFromHO.fromJson(String source) =>
      ResidentInfoFromHO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResidentInfoFromHO(id: $id, createdTime: $createdTime, updatedTime: $updatedTime, info_name: $info_name, sex: $sex, date_birth: $date_birth, residence_type: $residence_type, phone_required: $phone_required, email: $email, nationalId: $nationalId, identity_card_required: $identity_card_required, place_of_issue_required: $place_of_issue_required, job: $job, permanent_address: $permanent_address, provinceId: $provinceId, districtId: $districtId, wardsId: $wardsId, code: $code, owninfo: $owninfo)';
  }

  @override
  bool operator ==(covariant ResidentInfoFromHO other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdTime == createdTime &&
        other.updatedTime == updatedTime &&
        other.info_name == info_name &&
        other.sex == sex &&
        other.date_birth == date_birth &&
        other.residence_type == residence_type &&
        other.phone_required == phone_required &&
        other.email == email &&
        other.nationalId == nationalId &&
        other.identity_card_required == identity_card_required &&
        other.place_of_issue_required == place_of_issue_required &&
        other.job == job &&
        other.permanent_address == permanent_address &&
        other.provinceId == provinceId &&
        other.districtId == districtId &&
        other.wardsId == wardsId &&
        other.code == code &&
        listEquals(other.owninfo, owninfo);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdTime.hashCode ^
        updatedTime.hashCode ^
        info_name.hashCode ^
        sex.hashCode ^
        date_birth.hashCode ^
        residence_type.hashCode ^
        phone_required.hashCode ^
        email.hashCode ^
        nationalId.hashCode ^
        identity_card_required.hashCode ^
        place_of_issue_required.hashCode ^
        job.hashCode ^
        permanent_address.hashCode ^
        provinceId.hashCode ^
        districtId.hashCode ^
        wardsId.hashCode ^
        code.hashCode ^
        owninfo.hashCode;
  }
}

class RelationFromHO {
  String? code;
  String? name;
  RelationFromHO({
    this.code,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
    };
  }

  factory RelationFromHO.fromMap(Map<String, dynamic> map) {
    return RelationFromHO(
      code: map['code'] != null ? map['code'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RelationFromHO.fromJson(String source) =>
      RelationFromHO.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OwnInfofromHO {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? buildingId;
  String? floorId;
  String? apartmentId;
  String? type;
  String? residentId;
  RelationFromHO? relation;
  String? status;
  ApartmentFromHO? apartment;
  OwnInfofromHO({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.buildingId,
    this.floorId,
    this.apartmentId,
    this.type,
    this.residentId,
    this.status,
    this.apartment,
    this.relation,
  });

  OwnInfofromHO copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? buildingId,
    String? floorId,
    String? apartmentId,
    String? type,
    String? residentId,
    String? status,
    ApartmentFromHO? apartment,
  }) {
    return OwnInfofromHO(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      buildingId: buildingId ?? this.buildingId,
      floorId: floorId ?? this.floorId,
      apartmentId: apartmentId ?? this.apartmentId,
      type: type ?? this.type,
      residentId: residentId ?? this.residentId,
      status: status ?? this.status,
      apartment: apartment ?? this.apartment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'buildingId': buildingId,
      'floorId': floorId,
      'apartmentId': apartmentId,
      'type': type,
      'residentId': residentId,
      'status': status,
      'apartment': apartment?.toMap(),
    };
  }

  factory OwnInfofromHO.fromMap(Map<String, dynamic> map) {
    return OwnInfofromHO(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      buildingId:
          map['buildingId'] != null ? map['buildingId'] as String : null,
      floorId: map['floorId'] != null ? map['floorId'] as String : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      apartment: map['apartment'] != null
          ? ApartmentFromHO.fromMap(map['apartment'] as Map<String, dynamic>)
          : null,
      relation: map['relation'] != null
          ? RelationFromHO.fromMap(map['relation'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnInfofromHO.fromJson(String source) =>
      OwnInfofromHO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OwnInfofromHO(id: $id, createdTime: $createdTime, updatedTime: $updatedTime, buildingId: $buildingId, floorId: $floorId, apartmentId: $apartmentId, type: $type, residentId: $residentId, status: $status, apartment: $apartment)';
  }

  @override
  bool operator ==(covariant OwnInfofromHO other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdTime == createdTime &&
        other.updatedTime == updatedTime &&
        other.buildingId == buildingId &&
        other.floorId == floorId &&
        other.apartmentId == apartmentId &&
        other.type == type &&
        other.residentId == residentId &&
        other.status == status &&
        other.apartment == apartment;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdTime.hashCode ^
        updatedTime.hashCode ^
        buildingId.hashCode ^
        floorId.hashCode ^
        apartmentId.hashCode ^
        type.hashCode ^
        residentId.hashCode ^
        status.hashCode ^
        apartment.hashCode;
  }
}

class ApartmentFromHO {
  String? id;
  String? value;
  String? label;
  ApartmentFromHO({
    this.id,
    this.value,
    this.label,
  });

  ApartmentFromHO copyWith({
    String? id,
    String? value,
    String? label,
  }) {
    return ApartmentFromHO(
      id: id ?? this.id,
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'value': value,
      'label': label,
    };
  }

  factory ApartmentFromHO.fromMap(Map<String, dynamic> map) {
    return ApartmentFromHO(
      id: map['_id'] != null ? map['_id'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
      label: map['label'] != null ? map['label'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApartmentFromHO.fromJson(String source) =>
      ApartmentFromHO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ApartmentFromHO(id: $id, value: $value, label: $label)';

  @override
  bool operator ==(covariant ApartmentFromHO other) {
    if (identical(this, other)) return true;

    return other.id == id && other.value == value && other.label == label;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode ^ label.hashCode;
}
