// ignore_for_file: non_constant_identifier_names

import 'account.dart';
import 'relationship.dart';

class ResponseResidentInfo {
  String? id;
  String? createdTime;
  String? updatedTime;
  dynamic avatar;
  bool? isLocked;
  bool? isDraft;
  String? code;
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
  String? place_of_issue;
  String? identity_card;
  String? phone;
  String? m;
  RelationShip? re;
  Account? account;
  ResponseResidentInfo(
      {this.code,
      this.createdTime,
      this.date_birth,
      this.districtId,
      this.education,
      this.email,
      this.ethnicId,
      this.id,
      this.avatar,
      this.identity_card,
      this.identity_card_required,
      this.info_name,
      this.isDraft,
      this.isLocked,
      this.job,
      this.material_status,
      this.nationalId,
      this.permanent_address,
      this.phone,
      this.phone_required,
      this.place_of_issue,
      this.place_of_issue_required,
      this.provinceId,
      this.qualification,
      this.residence_type,
      this.sex,
      this.updatedTime,
      this.re,
      this.wardsId,
      this.account});

  ResponseResidentInfo.fromJson(Map<String, dynamic> json) {
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    id = json['_id'];
    avatar = json['avatar'];
    re = json['re'] != null ? RelationShip.fromMap(json['re']) : null;

    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    isLocked = json['isLocked'];
    isDraft = json['isDraft'];
    code = json['code'];
    info_name = json['info_name'];
    sex = json['sex'];
    date_birth = json['date_birth'];
    residence_type = json['residence_type'];
    phone_required = json['phone_required'];
    email = json['email'];
    nationalId = json['nationalId'];
    identity_card_required = json['identity_card_required'];
    place_of_issue_required = json['place_of_issue_required'];
    education = json['education'];
    qualification = json['qualification'];
    job = json['job'];
    material_status = json['material_status'];
    ethnicId = json['ethnicId'];
    permanent_address = json['permanent_address'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    wardsId = json['wardsId'];
    place_of_issue = json['place_of_issue'];
    identity_card = json['identity_card'];
    phone = json['phone'];
    phone = json['m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['isLocked'] = isLocked;
    data['isDraft'] = isDraft;
    data['code'] = code;
    data['info_name'] = info_name;
    data['sex'] = sex;
    data['date_birth'] = date_birth;
    data['residence_type'] = residence_type;
    data['email'] = email;
    data['nationalId'] = nationalId;
    data['identity_card_required'] = identity_card_required;
    data['place_of_issue_required'] = place_of_issue_required;
    data['education'] = education;
    data['qualification'] = qualification;
    data['job'] = job;
    data['material_status'] = material_status;
    data['ethnicId'] = ethnicId;
    data['permanent_address'] = permanent_address;
    data['provinceId'] = provinceId;
    data['districtId'] = districtId;
    data['wardsId'] = wardsId;
    data['place_of_issue'] = place_of_issue;
    data['identity_card'] = identity_card;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['account'] = account != null ? account!.toJson() : null;
    return data;
  }
}
