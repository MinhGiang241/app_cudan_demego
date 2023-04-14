// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:app_cudan/models/file_upload.dart';
import 'package:app_cudan/models/reason.dart';
import 'package:app_cudan/models/transportation_card.dart';

import 'status.dart';

class ManageCard {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? assetId;
  String? residentId;
  String? apartmentId;
  String? relationship;
  String? registration_date;
  List<FileUploadModel>? resident_image;
  List<FileUploadModel>? identity_image;
  List<FileUploadModel>? other_image;
  bool? confirmation;
  String? name;
  String? address_apartment;
  String? address;
  String? phone_number;
  String? identity;
  String? name_resident;
  bool? integrated;
  String? card_type;
  String? status;
  String? card_name;
  String? transportCardId;
  String? residentCardId;
  String? release_date;
  String? serial_lot;
  String? reasons;
  String? note_reason;
  String? lost_success;
  String? month_filter;
  String? user;
  String? rules;

  //more
  Status? s;
  TransportCard? t;
  Reason? r;

  ManageCard({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.assetId,
    this.residentId,
    this.apartmentId,
    this.relationship,
    this.registration_date,
    this.resident_image,
    this.identity_image,
    this.other_image,
    this.confirmation,
    this.name,
    this.address_apartment,
    this.address,
    this.phone_number,
    this.identity,
    this.name_resident,
    this.integrated,
    this.card_type,
    this.status,
    this.card_name,
    this.transportCardId,
    this.residentCardId,
    this.release_date,
    this.serial_lot,
    this.reasons,
    this.note_reason,
    this.lost_success,
    this.month_filter,
    this.user,
    this.rules,
    this.s,
    this.t,
    this.r,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'assetId': assetId,
      'residentId': residentId,
      'apartmentId': apartmentId,
      'relationship': relationship,
      'registration_date': registration_date,
      'resident_image': resident_image?.map((x) => x.toMap()).toList(),
      'identity_image': identity_image?.map((x) => x.toMap()).toList(),
      'other_image': other_image?.map((x) => x.toMap()).toList(),
      'confirmation': confirmation,
      'name': name,
      'address_apartment': address_apartment,
      'address': address,
      'phone_number': phone_number,
      'identity': identity,
      'name_resident': name_resident,
      'integrated': integrated,
      'card_type': card_type,
      'status': status,
      'card_name': card_name,
      'transportCardId': transportCardId,
      'residentCardId': residentCardId,
      'release_date': release_date,
      'serial_lot': serial_lot,
      'reasons': reasons,
      'note_reason': note_reason,
      'lost_success': lost_success,
      'month_filter': month_filter,
      'user': user,
      'rules': rules,
    };
  }

  factory ManageCard.fromMap(Map<String, dynamic> map) {
    return ManageCard(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      assetId: map['assetId'] != null ? map['assetId'] as String : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      relationship:
          map['relationship'] != null ? map['relationship'] as String : null,
      registration_date: map['registration_date'] != null
          ? map['registration_date'] as String
          : null,
      resident_image: map['resident_image'] != null
          ? List<FileUploadModel>.from(
              (map['resident_image'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      identity_image: map['identity_image'] != null
          ? List<FileUploadModel>.from(
              (map['identity_image'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      other_image: map['other_image'] != null
          ? List<FileUploadModel>.from(
              (map['other_image'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      confirmation:
          map['confirmation'] != null ? map['confirmation'] as bool : null,
      name: map['name'] != null ? map['name'] as String : null,
      address_apartment: map['address_apartment'] != null
          ? map['address_apartment'] as String
          : null,
      address: map['address'] != null ? map['address'] as String : null,
      phone_number:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      identity: map['identity'] != null ? map['identity'] as String : null,
      name_resident:
          map['name_resident'] != null ? map['name_resident'] as String : null,
      integrated: map['integrated'] != null ? map['integrated'] as bool : null,
      card_type: map['card_type'] != null ? map['card_type'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      card_name: map['card_name'] != null ? map['card_name'] as String : null,
      transportCardId: map['transportCardId'] != null
          ? map['transportCardId'] as String
          : null,
      residentCardId: map['residentCardId'] != null
          ? map['residentCardId'] as String
          : null,
      release_date:
          map['release_date'] != null ? map['release_date'] as String : null,
      serial_lot:
          map['serial_lot'] != null ? map['serial_lot'] as String : null,
      reasons: map['reasons'] != null ? map['reasons'] as String : null,
      note_reason:
          map['note_reason'] != null ? map['note_reason'] as String : null,
      lost_success:
          map['lost_success'] != null ? map['lost_success'] as String : null,
      month_filter:
          map['month_filter'] != null ? map['month_filter'] as String : null,
      user: map['user'] != null ? map['user'] as String : null,
      rules: map['rules'] != null ? map['rules'] as String : null,
      s: map['s'] != null
          ? Status.fromJson(map['s'] as Map<String, dynamic>)
          : null,
      t: map['t'] != null
          ? TransportCard.fromMap(map['t'] as Map<String, dynamic>)
          : null,
      r: map['r'] != null
          ? Reason.fromJson(map['r'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ManageCard.fromJson(String source) =>
      ManageCard.fromMap(json.decode(source) as Map<String, dynamic>);
}
