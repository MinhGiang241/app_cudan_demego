import 'dart:convert';

import 'package:app_cudan/models/file_upload.dart';

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
  List<Material>? material_list;
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
  HandOver({
    this.id,
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
  });

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
          ? List<Material>.from(
              (map['material_list'] as List<dynamic>).map<Material?>(
                (x) => Material.fromMap(x as Map<String, dynamic>),
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
    );
  }

  String toJson() => json.encode(toMap());

  factory HandOver.fromJson(String source) =>
      HandOver.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Material {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? assetPositionId;
  String? materialListId;
  String? material_specification;
  String? trademark;
  String? note;
  List<FileUploadModel>? img;
  Material({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.assetPositionId,
    this.materialListId,
    this.material_specification,
    this.trademark,
    this.note,
    this.img,
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
      'img': img?.map((x) => x.toMap()).toList(),
    };
  }

  factory Material.fromMap(Map<String, dynamic> map) {
    return Material(
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
      img: map['img'] != null
          ? List<FileUploadModel>.from(
              (map['img'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Material.fromJson(String source) =>
      Material.fromMap(json.decode(source) as Map<String, dynamic>);
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
