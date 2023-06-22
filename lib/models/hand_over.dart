import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:app_cudan/models/file_upload.dart';
import 'package:app_cudan/models/reason.dart';
import 'package:app_cudan/models/response_resident_own.dart';

import 'status.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file= public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names
// ignore_for_file= non_constant_identifier_names

class HandOver {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? apartmentId;
  String? apartmentTypeId;
  String? residentId;
  String? schedule_date;
  String? appointmentScheduleId;
  String? date;
  String? hour;
  String? time;
  String? status;
  String? status_error;
  String? resident_code;
  String? resident_phone;
  String? resident_card;
  String? resident_address;
  String? apartment_status;
  String? contract_code;
  dynamic floor_area;
  dynamic acreage;
  List<FileUploadModel>? floor_plan_drawing;
  List<Materials>? material_list;
  List<AddAsset>? list_assets_additional;
  String? rules;
  dynamic in_project;
  String? name_company;
  String? business_code;
  String? tax_code;
  String? tel_company;
  String? legal_representative;
  String? positon;
  String? person_handover;
  String? cancel_reason;
  String? cancel_note;
  String? work_code;
  String? departmentId;
  String? assignee_employeeId;
  List<FileUploadModel>? work_file;
  String? saleContractId;
  double? real_floor_area;
  double? real_acreage;
  String? filter_time_schedule;
  String? filter_time;
  String? schedule_hour;
  String? schedule_time;
  String? reason_cancel;
  String? label;

  Apartment? a;
  HandOverStatus? s;
  HandOverStatus? se;
  HandOver(
      {this.id,
      this.createdTime,
      this.updatedTime,
      this.code,
      this.apartmentId,
      this.apartmentTypeId,
      this.residentId,
      this.schedule_date,
      this.appointmentScheduleId,
      this.date,
      this.hour,
      this.time,
      this.status,
      this.status_error,
      this.resident_code,
      this.resident_phone,
      this.resident_card,
      this.resident_address,
      this.apartment_status,
      this.contract_code,
      required this.floor_area,
      required this.acreage,
      this.floor_plan_drawing,
      this.material_list,
      this.list_assets_additional,
      this.rules,
      required this.in_project,
      this.name_company,
      this.business_code,
      this.tax_code,
      this.tel_company,
      this.legal_representative,
      this.positon,
      this.person_handover,
      this.cancel_reason,
      this.cancel_note,
      this.work_code,
      this.departmentId,
      this.assignee_employeeId,
      this.work_file,
      this.saleContractId,
      this.real_floor_area,
      this.real_acreage,
      this.filter_time_schedule,
      this.filter_time,
      this.schedule_hour,
      this.schedule_time,
      this.reason_cancel,
      this.a,
      this.s,
      this.se,
      this.label});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'apartmentId': apartmentId,
      'apartmentTypeId': apartmentTypeId,
      'residentId': residentId,
      'schedule_date': schedule_date,
      'appointmentScheduleId': appointmentScheduleId,
      'date': date,
      'hour': hour,
      'time': time,
      'status': status,
      'status_error': status_error,
      'resident_code': resident_code,
      'resident_phone': resident_phone,
      'resident_card': resident_card,
      'resident_address': resident_address,
      'apartment_status': apartment_status,
      'contract_code': contract_code,
      'floor_area': floor_area,
      'acreage': acreage,
      'floor_plan_drawing': floor_plan_drawing?.map((x) => x.toMap()).toList(),
      'material_list': material_list?.map((x) => x.toMap()).toList(),
      'list_assets_additional':
          list_assets_additional?.map((x) => x.toMap()).toList(),
      'rules': rules,
      'in_project': in_project,
      'name_company': name_company,
      'business_code': business_code,
      'tax_code': tax_code,
      'tel_company': tel_company,
      'legal_representative': legal_representative,
      'positon': positon,
      'person_handover': person_handover,
      'cancel_reason': cancel_reason,
      'cancel_note': cancel_note,
      'work_code': work_code,
      'departmentId': departmentId,
      'assignee_employeeId': assignee_employeeId,
      'work_file': work_file?.map((x) => x.toMap()).toList(),
      'saleContractId': saleContractId,
      'real_floor_area': real_floor_area,
      'real_acreage': real_acreage,
      'filter_time_schedule': filter_time_schedule,
      'filter_time': filter_time,
      'schedule_hour': schedule_hour,
      'schedule_time': schedule_time,
      'reason_cancel': reason_cancel,
    };
  }

  factory HandOver.fromMap(Map<String, dynamic> map) {
    return HandOver(
      id: map['id'] != null ? map['id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      apartmentTypeId: map['apartmentTypeId'] != null
          ? map['apartmentTypeId'] as String
          : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      schedule_date:
          map['schedule_date'] != null ? map['schedule_date'] as String : null,
      appointmentScheduleId: map['appointmentScheduleId'] != null
          ? map['appointmentScheduleId'] as String
          : null,
      date: map['date'] != null ? map['date'] as String : null,
      hour: map['hour'] != null ? map['hour'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      status_error:
          map['status_error'] != null ? map['status_error'] as String : null,
      resident_code:
          map['resident_code'] != null ? map['resident_code'] as String : null,
      resident_phone: map['resident_phone'] != null
          ? map['resident_phone'] as String
          : null,
      resident_card:
          map['resident_card'] != null ? map['resident_card'] as String : null,
      resident_address: map['resident_address'] != null
          ? map['resident_address'] as String
          : null,
      apartment_status: map['apartment_status'] != null
          ? map['apartment_status'] as String
          : null,
      contract_code:
          map['contract_code'] != null ? map['contract_code'] as String : null,
      floor_area: map['floor_area'] as dynamic,
      acreage: map['acreage'] as dynamic,
      floor_plan_drawing: map['floor_plan_drawing'] != null
          ? List<FileUploadModel>.from(
              (map['floor_plan_drawing'] as List<dynamic>)
                  .map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      material_list: map['material_list'] != null
          ? List<Materials>.from(
              (map['material_list'] as List<dynamic>).map<Materials?>(
                (x) => Materials.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      list_assets_additional: map['list_assets_additional'] != null
          ? List<AddAsset>.from(
              (map['list_assets_additional'] as List<dynamic>).map<AddAsset?>(
                (x) => AddAsset.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      rules: map['rules'] != null ? map['rules'] as String : null,
      in_project: map['in_project'] as dynamic,
      name_company:
          map['name_company'] != null ? map['name_company'] as String : null,
      business_code:
          map['business_code'] != null ? map['business_code'] as String : null,
      tax_code: map['tax_code'] != null ? map['tax_code'] as String : null,
      tel_company:
          map['tel_company'] != null ? map['tel_company'] as String : null,
      legal_representative: map['legal_representative'] != null
          ? map['legal_representative'] as String
          : null,
      positon: map['positon'] != null ? map['positon'] as String : null,
      person_handover: map['person_handover'] != null
          ? map['person_handover'] as String
          : null,
      cancel_reason:
          map['cancel_reason'] != null ? map['cancel_reason'] as String : null,
      cancel_note:
          map['cancel_note'] != null ? map['cancel_note'] as String : null,
      work_code: map['work_code'] != null ? map['work_code'] as String : null,
      departmentId:
          map['departmentId'] != null ? map['departmentId'] as String : null,
      assignee_employeeId: map['assignee_employeeId'] != null
          ? map['assignee_employeeId'] as String
          : null,
      work_file: map['work_file'] != null
          ? List<FileUploadModel>.from(
              (map['work_file'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      saleContractId: map['saleContractId'] != null
          ? map['saleContractId'] as String
          : null,
      real_floor_area:
          double.tryParse(map['real_floor_area'].toString()) != null
              ? double.parse(map['real_floor_area'].toString())
              : null,
      real_acreage: double.tryParse(map['real_acreage'].toString()) != null
          ? double.parse(map['real_acreage'].toString())
          : null,
      filter_time_schedule: map['filter_time_schedule'] != null
          ? map['filter_time_schedule'] as String
          : null,
      filter_time:
          map['filter_time'] != null ? map['filter_time'] as String : null,
      schedule_hour:
          map['schedule_hour'] != null ? map['schedule_hour'] as String : null,
      schedule_time:
          map['schedule_time'] != null ? map['schedule_time'] as String : null,
      reason_cancel:
          map['reason_cancel'] != null ? map['reason_cancel'] as String : null,
      label: map['label'] != null ? map['label'] as String : null,
      a: map['a'] != null ? Apartment.fromJson(map['a']) : null,
      s: map['s'] != null ? HandOverStatus.fromJson(map['s']) : null,
      se: map['se'] != null ? HandOverStatus.fromJson(map['se']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HandOver.fromJson(String source) =>
      HandOver.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Materials {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? assetPositionId;
  String? materialListId;
  String? material_specification;
  String? trademark;
  String? note;
  String? code;
  bool? not_achieve;
  bool? achieve;
  List<FileUploadModel>? img;
  AssetPosition? assetposition;
  MaterialList? materiallist;
  Materials({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.assetPositionId,
    this.materialListId,
    this.material_specification,
    this.trademark,
    this.note,
    this.img,
    this.not_achieve,
    this.achieve,
    this.assetposition,
    this.materiallist,
    this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'assetPositionId': assetPositionId,
      'materialListId': materialListId,
      'material_specification': material_specification,
      'trademark': trademark,
      'note': note,
      'code': code,
      'img': img?.map((x) => x.toMap()).toList(),
      'not_achieve': not_achieve,
      'achieve': achieve,
    };
  }

  factory Materials.fromMap(Map<String, dynamic> map) {
    return Materials(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      assetPositionId: map['assetPositionId'] != null
          ? map['assetPositionId'] as String
          : null,
      materialListId: map['materialListId'] != null
          ? map['materialListId'] as String
          : null,
      material_specification: map['material_specification'] != null
          ? map['material_specification'] as String
          : null,
      trademark: map['trademark'] != null ? map['trademark'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      img: map['img'] != null
          ? List<FileUploadModel>.from(
              (map['img'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      not_achieve:
          map["not_achieve"] != null ? map["not_achieve"] as bool : null,
      achieve: map["achieve"] != null ? map["achieve"] as bool : null,
      assetposition: map["assetposition"] != null
          ? AssetPosition.fromMap(map["assetposition"])
          : null,
      materiallist: map["materiallist"] != null
          ? MaterialList.fromMap(map["materiallist"])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Materials.fromJson(String source) =>
      Materials.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AddAsset {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? assetPositionId_additional;
  String? name_additional;
  String? material_additional;
  String? trademark_additional;
  int? quantity_additional;
  String? unitId_additional;
  String? note_additional;
  bool? not_achieve;
  bool? achieve;
  String? reason_not_achieve;
  AssetPosition? assetposition;
  Unit? unit;
  AddAsset({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.assetPositionId_additional,
    this.name_additional,
    this.material_additional,
    this.trademark_additional,
    this.quantity_additional,
    this.unitId_additional,
    this.note_additional,
    this.assetposition,
    this.unit,
    this.reason_not_achieve,
    this.not_achieve,
    this.achieve,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'assetPositionId_additional': assetPositionId_additional,
      'name_additional': name_additional,
      'material_additional': material_additional,
      'trademark_additional': trademark_additional,
      'quantity_additional': quantity_additional,
      'unitId_additional': unitId_additional,
      'note_additional': note_additional,
      'not_achieve': not_achieve,
      'achieve': achieve,
      'reason_not_achieve': reason_not_achieve,
    };
  }

  factory AddAsset.fromMap(Map<String, dynamic> map) {
    return AddAsset(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      assetPositionId_additional: map['assetPositionId_additional'] != null
          ? map['assetPositionId_additional'] as String
          : null,
      name_additional: map['name_additional'] != null
          ? map['name_additional'] as String
          : null,
      material_additional: map['material_additional'] != null
          ? map['material_additional'] as String
          : null,
      trademark_additional: map['trademark_additional'] != null
          ? map['trademark_additional'] as String
          : null,
      quantity_additional:
          int.tryParse(map['quantity_additional'].toString()) != null
              ? int.parse(map['quantity_additional'].toString())
              : null,
      unitId_additional: map['unitId_additional'] != null
          ? map['unitId_additional'] as String
          : null,
      note_additional: map['note_additional'] != null
          ? map['note_additional'] as String
          : null,
      assetposition: map["assetposition"] != null
          ? AssetPosition.fromMap(map["assetposition"])
          : null,
      unit: map["unit"] != null ? Unit.fromMap(map["unit"]) : null,
      not_achieve:
          map["not_achieve"] != null ? map["not_achieve"] as bool : null,
      achieve: map["achieve"] != null ? map["achieve"] as bool : null,
      reason_not_achieve: map["reason_not_achieve"] != null
          ? map["reason_not_achieve"] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddAsset.fromJson(String source) =>
      AddAsset.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HandOverStatus {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? name;
  String? code;
  int? order;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'name': name,
      'code': code,
      'order': order,
    };
  }

  HandOverStatus.fromJson(Map<String, dynamic> map) {
    id = map['_id'];
    createdTime = map['createdTime'];
    updatedTime = map['updatedTime'];
    name = map['name'];
    code = map['code'];
    order = int.tryParse(map['order'].toString()) != null
        ? int.parse(map['order'].toString())
        : null;
  }
}

class AppointmentSchedule {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? time;
  String? customersId;
  String? apartmentId;
  String? apartment_type;
  String? status;
  String? resident_phone;
  String? email;
  String? apartmentTypeId;
  String? date;
  String? hour;
  // String? month;
  String? cancel_reason;
  String? cancel_note;

  //add
  Status? s;
  Reason? r;
  Apartment? a;
  Customer? c;

  AppointmentSchedule({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.time,
    this.customersId,
    this.apartmentId,
    this.apartment_type,
    this.status,
    this.resident_phone,
    this.email,
    this.apartmentTypeId,
    this.date,
    this.hour,
    this.cancel_reason,
    this.cancel_note,
    this.s,
    this.r,
    this.a,
    this.c,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'time': time,
      'customersId': customersId,
      'apartmentId': apartmentId,
      'apartment_type': apartment_type,
      'status': status,
      'resident_phone': resident_phone,
      'email': email,
      'apartmentTypeId': apartmentTypeId,
      'date': date,
      'hour': hour,
      'cancel_reason': cancel_reason,
      'cancel_note': cancel_note,
    };
  }

  factory AppointmentSchedule.fromMap(Map<String, dynamic> map) {
    return AppointmentSchedule(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      customersId:
          map['customersId'] != null ? map['customersId'] as String : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      apartment_type: map['apartment_type'] != null
          ? map['apartment_type'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      resident_phone: map['resident_phone'] != null
          ? map['resident_phone'] as String
          : null,
      email: map['email'] != null ? map['email'] as String : null,
      apartmentTypeId: map['apartmentTypeId'] != null
          ? map['apartmentTypeId'] as String
          : null,
      date: map['date'] != null ? map['date'] as String : null,
      hour: map['hour'] != null ? map['hour'] as String : null,
      cancel_reason:
          map['cancel_reason'] != null ? map['cancel_reason'] as String : null,
      cancel_note:
          map['cancel_note'] != null ? map['cancel_note'] as String : null,
      s: map['s'] != null ? Status.fromJson(map['s']) : null,
      r: map['r'] != null ? Reason.fromJson(map['r']) : null,
      a: map['a'] != null ? Apartment.fromJson(map['a']) : null,
      c: map['c'] != null ? Customer.fromMap(map['c']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentSchedule.fromJson(String source) =>
      AppointmentSchedule.fromMap(json.decode(source) as Map<String, dynamic>);

  AppointmentSchedule copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? code,
    String? time,
    String? customersId,
    String? apartmentId,
    String? apartment_type,
    String? status,
    String? resident_phone,
    String? email,
    String? apartmentTypeId,
    String? date,
    String? hour,
    String? cancel_reason,
    String? cancel_note,
    Status? s,
    Reason? r,
    Apartment? a,
  }) {
    return AppointmentSchedule(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      code: code ?? this.code,
      time: time ?? this.time,
      customersId: customersId ?? this.customersId,
      apartmentId: apartmentId ?? this.apartmentId,
      apartment_type: apartment_type ?? this.apartment_type,
      status: status ?? this.status,
      resident_phone: resident_phone ?? this.resident_phone,
      email: email ?? this.email,
      apartmentTypeId: apartmentTypeId ?? this.apartmentTypeId,
      date: date ?? this.date,
      hour: hour ?? this.hour,
      cancel_reason: cancel_reason ?? this.cancel_reason,
      cancel_note: cancel_note ?? this.cancel_note,
      s: s ?? this.s,
      r: r ?? this.r,
      a: a ?? this.a,
    );
  }
}

class Customer {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? info_name;
  String? sex;
  String? date_birth;
  String? nationalId;
  String? phone_required;
  String? email;
  String? date_range;
  String? place_of_issue_required;
  String? identity_card_required;
  String? permanent_address;
  String? provinceId;
  String? districtId;
  String? wardsId;
  String? address;
  String? address_provinceId;
  String? address_districtId;
  String? address_wardsId;
  String? buyer_account_number;
  String? buyer_the_bank;
  Customer({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.info_name,
    this.sex,
    this.date_birth,
    this.nationalId,
    this.phone_required,
    this.email,
    this.date_range,
    this.place_of_issue_required,
    this.identity_card_required,
    this.permanent_address,
    this.provinceId,
    this.districtId,
    this.wardsId,
    this.address,
    this.address_provinceId,
    this.address_districtId,
    this.address_wardsId,
    this.buyer_account_number,
    this.buyer_the_bank,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'info_name': info_name,
      'sex': sex,
      'date_birth': date_birth,
      'nationalId': nationalId,
      'phone_required': phone_required,
      'email': email,
      'date_range': date_range,
      'place_of_issue_required': place_of_issue_required,
      'identity_card_required': identity_card_required,
      'permanent_address': permanent_address,
      'provinceId': provinceId,
      'districtId': districtId,
      'wardsId': wardsId,
      'address': address,
      'address_provinceId': address_provinceId,
      'address_districtId': address_districtId,
      'address_wardsId': address_wardsId,
      'buyer_account_number': buyer_account_number,
      'buyer_the_bank': buyer_the_bank,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      info_name: map['info_name'] != null ? map['info_name'] as String : null,
      sex: map['sex'] != null ? map['sex'] as String : null,
      date_birth:
          map['date_birth'] != null ? map['date_birth'] as String : null,
      nationalId:
          map['nationalId'] != null ? map['nationalId'] as String : null,
      phone_required: map['phone_required'] != null
          ? map['phone_required'] as String
          : null,
      email: map['email'] != null ? map['email'] as String : null,
      date_range:
          map['date_range'] != null ? map['date_range'] as String : null,
      place_of_issue_required: map['place_of_issue_required'] != null
          ? map['place_of_issue_required'] as String
          : null,
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
      address: map['address'] != null ? map['address'] as String : null,
      address_provinceId: map['address_provinceId'] != null
          ? map['address_provinceId'] as String
          : null,
      address_districtId: map['address_districtId'] != null
          ? map['address_districtId'] as String
          : null,
      address_wardsId: map['address_wardsId'] != null
          ? map['address_wardsId'] as String
          : null,
      buyer_account_number: map['buyer_account_number'] != null
          ? map['buyer_account_number'] as String
          : null,
      buyer_the_bank: map['buyer_the_bank'] != null
          ? map['buyer_the_bank'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AssetPosition {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? apartment_type;
  String? asset_postision;
  String? note;
  String? code;
  AssetPosition({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.apartment_type,
    this.asset_postision,
    this.note,
    this.code,
  });

  AssetPosition copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? apartment_type,
    String? asset_postision,
    String? note,
    String? code,
  }) {
    return AssetPosition(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      apartment_type: apartment_type ?? this.apartment_type,
      asset_postision: asset_postision ?? this.asset_postision,
      note: note ?? this.note,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'apartment_type': apartment_type,
      'asset_postision': asset_postision,
      'note': note,
      'code': code,
    };
  }

  factory AssetPosition.fromMap(Map<String, dynamic> map) {
    return AssetPosition(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      apartment_type: map['apartment_type'] != null
          ? map['apartment_type'] as String
          : null,
      asset_postision: map['asset_postision'] != null
          ? map['asset_postision'] as String
          : null,
      note: map['note'] != null ? map['note'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetPosition.fromJson(String source) =>
      AssetPosition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssetPossition(id: $id, createdTime: $createdTime, updatedTime: $updatedTime, apartment_type: $apartment_type, asset_postision: $asset_postision, note: $note, code: $code)';
  }

  @override
  bool operator ==(covariant AssetPosition other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdTime == createdTime &&
        other.updatedTime == updatedTime &&
        other.apartment_type == apartment_type &&
        other.asset_postision == asset_postision &&
        other.note == note &&
        other.code == code;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdTime.hashCode ^
        updatedTime.hashCode ^
        apartment_type.hashCode ^
        asset_postision.hashCode ^
        note.hashCode ^
        code.hashCode;
  }
}

class Unit {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? name;
  String? describe;
  Unit({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.name,
    this.describe,
  });

  Unit copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? code,
    String? name,
    String? describe,
  }) {
    return Unit(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      code: code ?? this.code,
      name: name ?? this.name,
      describe: describe ?? this.describe,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'name': name,
      'describe': describe,
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      describe: map['describe'] != null ? map['describe'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) =>
      Unit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Unit(_id: $id, createdTime: $createdTime, updatedTime: $updatedTime, code: $code, name: $name, describe: $describe)';
  }

  @override
  bool operator ==(covariant Unit other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdTime == createdTime &&
        other.updatedTime == updatedTime &&
        other.code == code &&
        other.name == name &&
        other.describe == describe;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdTime.hashCode ^
        updatedTime.hashCode ^
        code.hashCode ^
        name.hashCode ^
        describe.hashCode;
  }
}

class MaterialList {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? material_list;
  MaterialList({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.material_list,
  });

  MaterialList copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? code,
    String? material_list,
  }) {
    return MaterialList(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      code: code ?? this.code,
      material_list: material_list ?? this.material_list,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'material_list': material_list,
    };
  }

  factory MaterialList.fromMap(Map<String, dynamic> map) {
    return MaterialList(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      material_list:
          map['material_list'] != null ? map['material_list'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MaterialList.fromJson(String source) =>
      MaterialList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MaterialList(_id: $id, createdTime: $createdTime, updatedTime: $updatedTime, code: $code, material_list: $material_list)';
  }

  @override
  bool operator ==(covariant MaterialList other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdTime == createdTime &&
        other.updatedTime == updatedTime &&
        other.code == code &&
        other.material_list == material_list;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdTime.hashCode ^
        updatedTime.hashCode ^
        code.hashCode ^
        material_list.hashCode;
  }
}

class Defect {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? name;
  String? describe;
  String? date;
  Defect({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.name,
    this.describe,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'name': name,
      'describe': describe,
      'date': date,
    };
  }

  factory Defect.fromMap(Map<String, dynamic> map) {
    return Defect(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      describe: map['describe'] != null ? map['describe'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Defect.fromJson(String source) =>
      Defect.fromMap(json.decode(source) as Map<String, dynamic>);

  Defect copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? code,
    String? name,
    String? describe,
    String? date,
  }) {
    return Defect(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      code: code ?? this.code,
      name: name ?? this.name,
      describe: describe ?? this.describe,
      date: date ?? this.date,
    );
  }
}
