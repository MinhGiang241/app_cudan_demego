// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'file_upload.dart';
import 'province.dart';
import 'relationship.dart';
import 'response_resident_own.dart';
import 'status.dart';

class DependenceSignUp {
  String? id;
  String? createdTime;
  String? updatedTime;
  List<FileUploadModel>? avatar;
  List<FileUploadModel>? id_card;
  String? info_name;
  String? sex;
  String? residence_type;
  String? phone_required;
  String? email;
  String? identity_card_required;
  String? permanent_address;
  String? provinceId;
  String? districtId;
  String? wardsId;
  String? date_birth;
  String? status;
  String? buildingId;
  String? floorId;
  String? apartmentId;
  String? relationshipId;
  String? dependentId;
  String? type;
  String? nationalId;
  String? education;
  String? qualification;
  String? job;
  String? material_status;
  String? ethnicId;
  List<FileUploadModel>? upload;
  String? facebook;
  String? zalo;
  String? instagram;
  String? linkedin;
  String? tiktok;
  String? ticket_code;
  String? sent_date;
  String? note_reason;
  String? reasons;
  String? residentId;
  String? full_name;
  String? place_of_issue;
  Status? s;
  Apartment? a;
  Building? b;
  Floor? f;
  RelationShip? r;
  Province? p;
  Distric? d;
  Ward? w;
  DependenceSignUp({
    this.id,
    this.place_of_issue,
    this.createdTime,
    this.updatedTime,
    this.avatar,
    this.id_card,
    this.info_name,
    this.sex,
    this.residence_type,
    this.phone_required,
    this.email,
    this.identity_card_required,
    this.permanent_address,
    this.provinceId,
    this.districtId,
    this.wardsId,
    this.date_birth,
    this.status,
    this.buildingId,
    this.floorId,
    this.apartmentId,
    this.relationshipId,
    this.dependentId,
    this.type,
    this.nationalId,
    this.education,
    this.qualification,
    this.job,
    this.material_status,
    this.ethnicId,
    this.upload,
    this.facebook,
    this.zalo,
    this.instagram,
    this.linkedin,
    this.tiktok,
    this.ticket_code,
    this.sent_date,
    this.note_reason,
    this.reasons,
    this.residentId,
    this.full_name,
    this.a,
    this.b,
    this.f,
    this.r,
    this.p,
    this.d,
    this.w,
    this.s,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'avatar': avatar?.map((x) => x.toMap()).toList(),
      'id_card': id_card?.map((x) => x.toMap()).toList(),
      'info_name': info_name,
      'sex': sex,
      'residence_type': residence_type,
      'phone_required': phone_required,
      'email': email,
      'identity_card_required': identity_card_required,
      'permanent_address': permanent_address,
      'provinceId': provinceId,
      'districtId': districtId,
      'wardsId': wardsId,
      'date_birth': date_birth,
      'status': status,
      'buildingId': buildingId,
      'floorId': floorId,
      'apartmentId': apartmentId,
      'relationshipId': relationshipId,
      'dependentId': dependentId,
      'type': type,
      'nationalId': nationalId,
      'education': education,
      'qualification': qualification,
      'job': job,
      'material_status': material_status,
      'ethnicId': ethnicId,
      'upload': upload?.map((x) => x.toMap()).toList(),
      'facebook': facebook,
      'zalo': zalo,
      'instagram': instagram,
      'linkedin': linkedin,
      'tiktok': tiktok,
      'ticket_code': ticket_code,
      'sent_date': sent_date,
      'note_reason': note_reason,
      'reasons': reasons,
      'residentId': residentId,
      'full_name': full_name,
      'place_of_issue': place_of_issue,
    };
  }

  factory DependenceSignUp.fromMap(Map<String, dynamic> map) {
    return DependenceSignUp(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      avatar: map['id_card'] != null
          ? List<FileUploadModel>.from(
              (map['id_card'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      id_card: map['id_card'] != null
          ? List<FileUploadModel>.from(
              (map['id_card'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      info_name: map['info_name'] != null ? map['info_name'] as String : null,
      sex: map['sex'] != null ? map['sex'] as String : null,
      residence_type: map['residence_type'] != null
          ? map['residence_type'] as String
          : null,
      phone_required: map['phone_required'] != null
          ? map['phone_required'] as String
          : null,
      email: map['email'] != null ? map['email'] as String : null,
      identity_card_required: map['identity_card_required'] != null
          ? map['identity_card_required'] as String
          : null,
      permanent_address: map['permanent_address'] != null
          ? map['permanent_address'] as String
          : null,
      provinceId:
          map['provinceId'] != null ? map['provinceId'] as String : null,
      districtId:
          map['districtId'] != null ? map['districtId'] as String : null,
      wardsId: map['wardsId'] != null ? map['wardsId'] as String : null,
      date_birth:
          map['date_birth'] != null ? map['date_birth'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      buildingId:
          map['buildingId'] != null ? map['buildingId'] as String : null,
      floorId: map['floorId'] != null ? map['floorId'] as String : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      relationshipId: map['relationshipId'] != null
          ? map['relationshipId'] as String
          : null,
      dependentId:
          map['dependentId'] != null ? map['dependentId'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      nationalId:
          map['nationalId'] != null ? map['nationalId'] as String : null,
      education: map['education'] != null ? map['education'] as String : null,
      qualification:
          map['qualification'] != null ? map['qualification'] as String : null,
      job: map['job'] != null ? map['job'] as String : null,
      material_status: map['material_status'] != null
          ? map['material_status'] as String
          : null,
      ethnicId: map['ethnicId'] != null ? map['ethnicId'] as String : null,
      upload: map['upload'] != null
          ? List<FileUploadModel>.from(
              (map['upload'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      facebook: map['facebook'] != null ? map['facebook'] as String : null,
      zalo: map['zalo'] != null ? map['zalo'] as String : null,
      instagram: map['instagram'] != null ? map['instagram'] as String : null,
      linkedin: map['linkedin'] != null ? map['linkedin'] as String : null,
      tiktok: map['tiktok'] != null ? map['tiktok'] as String : null,
      ticket_code:
          map['ticket_code'] != null ? map['ticket_code'] as String : null,
      sent_date: map['sent_date'] != null ? map['sent_date'] as String : null,
      note_reason:
          map['note_reason'] != null ? map['note_reason'] as String : null,
      reasons: map['reasons'] != null ? map['reasons'] as String : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      place_of_issue: map['place_of_issue'] != null
          ? map['place_of_issue'] as String
          : null,
      full_name: map['full_name'] != null ? map['full_name'] as String : null,
      s: map["s"] != null ? Status.fromJson(map['s']) : null,
      a: map["a"] != null ? Apartment.fromJson(map['a']) : null,
      b: map["b"] != null ? Building.fromJson(map['b']) : null,
      f: map["f"] != null ? Floor.fromJson(map['f']) : null,
      r: map["r"] != null ? RelationShip.fromMap(map['r']) : null,
      p: map["p"] != null ? Province.fromMap(map['p']) : null,
      d: map["d"] != null ? Distric.fromMap(map['d']) : null,
      w: map["w"] != null ? Ward.fromMap(map['w']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DependenceSignUp.fromJson(String source) =>
      DependenceSignUp.fromMap(json.decode(source) as Map<String, dynamic>);
}
