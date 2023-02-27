// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'file_upload.dart';

class FormAddResidence {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? tenantId;
  String? avatar;
  String? id_card;
  String? info_name;
  String? sex;
  String? date_birth;
  String? residence_type;
  String? phone_required;
  String? email;
  String? nationalId;
  String? identity_card_required;
  String? place_of_issue_required;
  String? education;
  String? qualification;
  String? job;
  String? material_status;
  String? ethnicId;
  String? permanent_address;
  String? provinceId;
  String? districtId;
  String? wardsId;
  String? type;
  String? dependentId;
  String? relationshipId;
  String? apartmentId;
  String? buildingId;
  String? floorId;
  String? residentId;
  String? facebook;
  String? instagram;
  String? zalo;
  String? linkedin;
  String? tiktok;
  List<FileUploadModel>? upload;
  List<FileUploadModel>? identity_images;
  List<FileUploadModel>? resident_images;
  FormAddResidence({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.tenantId,
    this.avatar,
    this.id_card,
    this.info_name,
    this.sex,
    this.date_birth,
    this.residence_type,
    this.phone_required,
    this.email,
    this.nationalId,
    this.identity_card_required,
    this.place_of_issue_required,
    this.education,
    this.qualification,
    this.job,
    this.material_status,
    this.ethnicId,
    this.permanent_address,
    this.provinceId,
    this.districtId,
    this.wardsId,
    this.type,
    this.dependentId,
    this.relationshipId,
    this.apartmentId,
    this.buildingId,
    this.floorId,
    this.residentId,
    this.facebook,
    this.instagram,
    this.zalo,
    this.linkedin,
    this.tiktok,
    this.upload,
    this.identity_images,
    this.resident_images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'tenantId': tenantId,
      'avatar': avatar,
      'id_card': id_card,
      'info_name': info_name,
      'sex': sex,
      'date_birth': date_birth,
      'residence_type': residence_type,
      'phone_required': phone_required,
      'email': email,
      'nationalId': nationalId,
      'identity_card_required': identity_card_required,
      'place_of_issue_required': place_of_issue_required,
      'education': education,
      'qualification': qualification,
      'job': job,
      'material_status': material_status,
      'ethnicId': ethnicId,
      'permanent_address': permanent_address,
      'provinceId': provinceId,
      'districtId': districtId,
      'wardsId': wardsId,
      'type': type,
      'dependentId': dependentId,
      'relationshipId': relationshipId,
      'apartmentId': apartmentId,
      'buildingId': buildingId,
      'floorId': floorId,
      'residentId': residentId,
      'facebook': facebook,
      'instagram': instagram,
      'zalo': zalo,
      'linkedin': linkedin,
      'tiktok': tiktok,
      'upload': upload?.map((x) => x.toMap()).toList(),
      'identity_images': identity_images?.map((x) => x.toMap()).toList(),
      'resident_images': resident_images?.map((x) => x.toMap()).toList(),
    };
  }

  factory FormAddResidence.fromMap(Map<String, dynamic> map) {
    return FormAddResidence(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      tenantId: map['tenantId'] != null ? map['tenantId'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      id_card: map['id_card'] != null ? map['id_card'] as String : null,
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
      education: map['education'] != null ? map['education'] as String : null,
      qualification:
          map['qualification'] != null ? map['qualification'] as String : null,
      job: map['job'] != null ? map['job'] as String : null,
      material_status: map['material_status'] != null
          ? map['material_status'] as String
          : null,
      ethnicId: map['ethnicId'] != null ? map['ethnicId'] as String : null,
      permanent_address: map['permanent_address'] != null
          ? map['permanent_address'] as String
          : null,
      provinceId:
          map['provinceId'] != null ? map['provinceId'] as String : null,
      districtId:
          map['districtId'] != null ? map['districtId'] as String : null,
      wardsId: map['wardsId'] != null ? map['wardsId'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      dependentId:
          map['dependentId'] != null ? map['dependentId'] as String : null,
      relationshipId: map['relationshipId'] != null
          ? map['relationshipId'] as String
          : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      buildingId:
          map['buildingId'] != null ? map['buildingId'] as String : null,
      floorId: map['floorId'] != null ? map['floorId'] as String : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      facebook: map['facebook'] != null ? map['facebook'] as String : null,
      instagram: map['instagram'] != null ? map['instagram'] as String : null,
      zalo: map['zalo'] != null ? map['zalo'] as String : null,
      linkedin: map['linkedin'] != null ? map['linkedin'] as String : null,
      tiktok: map['tiktok'] != null ? map['tiktok'] as String : null,
      upload: map['upload'] != null
          ? List<FileUploadModel>.from(
              (map['upload'] as List<int>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      identity_images: map['identity_images'] != null
          ? List<FileUploadModel>.from(
              (map['identity_images'] as List<int>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      resident_images: map['resident_images'] != null
          ? List<FileUploadModel>.from(
              (map['resident_images'] as List<int>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormAddResidence.fromJson(String source) =>
      FormAddResidence.fromMap(json.decode(source) as Map<String, dynamic>);
}
