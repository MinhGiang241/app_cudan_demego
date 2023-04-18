// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:app_cudan/models/file_upload.dart';

import 'reason.dart';
import 'resident_info.dart';
import 'response_resident_own.dart';
import 'status.dart';

class ResidentCard {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? apartmentId;
  String? residentId;
  String? reasons;
  bool? isMobile;
  String? code;

  String? ticket_status;
  String? note_reason;
  String? relationship;
  String? registration_date;
  bool? confirmation;
  List<FileUploadModel>? identity_image;
  List<FileUploadModel>? resident_image;
  List<FileUploadModel>? other_image;
  String? regisrtation_date_filter;

  ResponseResidentInfo? resident;
  Apartment? apartment;
  Status? s;
  Reason? r;

  ResidentCard({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.apartmentId,
    this.residentId,
    this.reasons,
    this.isMobile,
    this.code,
    this.ticket_status,
    this.note_reason,
    this.relationship,
    this.registration_date,
    this.confirmation,
    this.identity_image,
    this.resident_image,
    this.other_image,
    this.regisrtation_date_filter,
    this.apartment,
    this.resident,
    this.s,
    this.r,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'apartmentId': apartmentId,
      'residentId': residentId,
      'reasons': reasons,
      'isMobile': isMobile,
      'code': code,
      'ticket_status': ticket_status,
      'note_reason': note_reason,
      'relationship': relationship,
      'registration_date': registration_date,
      'confirmation': confirmation,
      'identity_image': identity_image?.map((x) => x.toMap()).toList(),
      'resident_image': resident_image?.map((x) => x.toMap()).toList(),
      'other_image': other_image?.map((x) => x.toMap()).toList(),
      'regisrtation_date_filter': regisrtation_date_filter,
    };
  }

  factory ResidentCard.fromMap(Map<String, dynamic> map) {
    return ResidentCard(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      reasons: map['reasons'] != null ? map['reasons'] as String : null,
      isMobile: map['isMobile'] != null ? map['isMobile'] as bool : null,
      code: map['code'] != null ? map['code'] as String : null,
      ticket_status:
          map['ticket_status'] != null ? map['ticket_status'] as String : null,
      note_reason:
          map['note_reason'] != null ? map['note_reason'] as String : null,
      relationship:
          map['relationship'] != null ? map['relationship'] as String : null,
      registration_date: map['registration_date'] != null
          ? map['registration_date'] as String
          : null,
      confirmation:
          map['confirmation'] != null ? map['confirmation'] as bool : null,
      identity_image: map['identity_image'] != null
          ? List<FileUploadModel>.from(
              (map['identity_image'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      resident_image: map['resident_image'] != null
          ? List<FileUploadModel>.from(
              (map['resident_image'] as List<dynamic>).map<FileUploadModel?>(
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
      regisrtation_date_filter: map['regisrtation_date_filter'] != null
          ? map['regisrtation_date_filter'] as String
          : null,
      resident: map['resident'] != null
          ? ResponseResidentInfo.fromJson(map['resident'])
          : null,
      apartment: map['apartment'] != null
          ? Apartment.fromJson(map['apartment'])
          : null,
      s: map['s'] != null ? Status.fromJson(map['s']) : null,
      r: map['r'] != null ? Reason.fromJson(map['r']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResidentCard.fromJson(String source) =>
      ResidentCard.fromMap(json.decode(source) as Map<String, dynamic>);
}
