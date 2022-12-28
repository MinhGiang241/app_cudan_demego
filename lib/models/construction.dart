// ignore_for_file: non_constant_identifier_names

import 'status.dart';

class ConstructionRegistration {
  ConstructionRegistration({
    this.createdTime,
    this.apartmentId,
    this.cancel_reason,
    this.code,
    this.confirm,
    this.constructionTypeId,
    this.construction_cost,
    this.construction_type_name,
    this.contruction_add,
    this.contruction_email,
    this.contruction_unit,
    this.create_date,
    this.current_draw,
    this.deposit_fee,
    this.deputy,
    this.deputy_identity,
    this.deputy_phone,
    this.description,
    this.history_code,
    this.id,
    this.isConstructionCost,
    this.isDepositFee,
    this.isMobile,
    this.reason_description,
    this.renovation_draw,
    this.residentId,
    this.resident_code,
    this.resident_identity,
    this.resident_name,
    this.resident_phone,
    this.resident_relationship,
    this.status,
    this.time_end,
    this.time_start,
    this.updatedTime,
    this.worker_num,
    this.working_day,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? apartmentId;
  String? residentId;
  String? resident_code;
  String? resident_phone;
  String? resident_identity;
  String? resident_relationship;
  String? status;
  String? contruction_unit;
  String? contruction_add;
  String? contruction_email;
  String? deputy;
  String? deputy_phone;
  String? deputy_identity;
  int? worker_num;
  String? constructionTypeId;
  String? time_start;
  String? time_end;
  String? description;
  double? construction_cost;
  double? deposit_fee;
  int? working_day;
  bool? isConstructionCost;
  bool? isDepositFee;
  bool? confirm;
  String? cancel_reason;
  String? reason_description;
  String? history_code;
  String? resident_name;
  String? construction_type_name;
  String? create_date;
  bool? isMobile;
  Status? s;
  ConstructionType? constructionType;
  List<ConstructionFile>? current_draw;
  List<ConstructionFile>? renovation_draw;

  ConstructionRegistration.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    apartmentId = json['apartmentId'];
    residentId = json['residentId'];
    resident_code = json['resident_code'];
    resident_phone = json['resident_phone'];
    resident_identity = json['resident_identity'];
    resident_relationship = json['resident_relationship'];
    status = json['status'];
    contruction_unit = json['contruction_unit'];
    contruction_add = json['contruction_add'];
    contruction_email = json['contruction_email'];
    deputy = json['deputy'];
    deputy_phone = json['deputy_phone'];
    deputy_identity = json['deputy_identity'];
    worker_num = json['worker_num'];
    constructionTypeId = json['constructionTypeId'];
    time_start = json['time_start'];
    time_end = json['time_end'];
    description = json['description'];
    s = json['status'] != null ? Status.fromJson(json['s']) : null;
    constructionType = json['constructionType'] != null
        ? ConstructionType.fromJson(json['constructionType'])
        : null;
    construction_cost =
        double.tryParse(json['construction_cost'].toString()) != null
            ? double.parse(json['construction_cost'].toString())
            : null;
    deposit_fee = double.tryParse(json['deposit_fee'].toString()) != null
        ? double.parse(json['deposit_fee'].toString())
        : null;
    working_day = json['working_day'];
    isConstructionCost = json['isConstructionCost'];
    isDepositFee = json['isDepositFee'];
    confirm = json['confirm'];
    cancel_reason = json['cancel_reason'];
    reason_description = json['reason_description'];
    history_code = json['history_code'];
    resident_name = json['resident_name'];
    construction_type_name = json['construction_type_name'];
    create_date = json['create_date'];
    isMobile = json['isMobile'];
    current_draw = json['current_draw'] != null
        ? json['current_draw'].isNotEmpty
            ? json['current_draw']
                .map<ConstructionFile>((e) => ConstructionFile.fromJson(e))
                .toList()
            : []
        : [];
    renovation_draw = json['renovation_draw'] != null
        ? json['renovation_draw'].isNotEmpty
            ? json['renovation_draw']
                .map<ConstructionFile>((e) => ConstructionFile.fromJson(e))
                .toList()
            : []
        : [];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['code'] = code;
    data['apartmentId'] = apartmentId;
    data['residentId'] = residentId;
    data['resident_code'] = resident_code;
    data['resident_phone'] = resident_phone;
    data['resident_identity'] = resident_identity;
    data['resident_relationship'] = resident_relationship;
    data['status'] = status;
    data['contruction_unit'] = contruction_unit;
    data['contruction_add'] = contruction_add;
    data['contruction_email'] = contruction_email;
    data['deputy'] = deputy;
    data['deputy_phone'] = deputy_phone;
    data['deputy_identity'] = deputy_identity;
    data['worker_num'] = worker_num;
    data['constructionTypeId'] = constructionTypeId;
    data['time_start'] = time_start;
    data['time_end'] = time_end;
    data['description'] = description;
    data['construction_cost'] = construction_cost;
    data['deposit_fee'] = deposit_fee;
    data['working_day'] = working_day;
    data['isConstructionCost'] = isConstructionCost;
    data['isDepositFee'] = isDepositFee;
    data['confirm'] = confirm;
    data['cancel_reason'] = cancel_reason;
    data['reason_description'] = reason_description;
    data['history_code'] = history_code;
    data['resident_name'] = resident_name;
    data['construction_type_name'] = construction_type_name;
    data['create_date'] = create_date;
    data['isMobile'] = isMobile;
    data['_id'] = id;
    data['current_draw'] = current_draw != null
        ? current_draw!.map((e) {
            return e.toJson();
          }).toList()
        : [];
    data['renovation_draw'] = renovation_draw != null
        ? renovation_draw!.map((e) {
            return e.toJson();
          }).toList()
        : [];
    return data;
  }
}

class ConstructionFile {
  ConstructionFile({this.id, this.name});
  String? id;
  String? name;
  ConstructionFile.fromJson(Map<String, dynamic> json) {
    id = json['file_id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_id'] = id;
    data['name'] = name;
    return data;
  }
}

class ConstructionType {
  ConstructionType({
    this.id,
    this.name,
    this.code,
    this.createdTime,
    this.describe,
    this.updatedTime,
  });
  String? id;
  String? name;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? describe;
  ConstructionType.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    describe = json['describe'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['code'] = code;
    data['describe'] = describe;
    return data;
  }
}

class ConstructionDocument {
  ConstructionDocument({
    this.apartmentId,
    this.confirm,
    this.constructionRegistrationId,
    this.construction_cost,
    this.contructionTypeId,
    this.contruction_add,
    this.contruction_email,
    this.contruction_unit,
    this.createdTime,
    this.current_draw,
    this.deposit_fee,
    this.deputy,
    this.deputy_identity,
    this.deputy_phone,
    this.description,
    this.id,
    this.isConstructionCost,
    this.isDepositFee,
    this.isRecord,
    this.off_day,
    this.registration_code,
    this.renovation_draw,
    this.residentId,
    this.resident_code,
    this.resident_identity,
    this.resident_phone,
    this.resident_relationship,
    this.status,
    this.time_end,
    this.time_start,
    this.updatedTime,
    this.worker_num,
    this.working_day,
    this.code,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? apartmentId;
  String? residentId;
  String? status;
  String? constructionRegistrationId;
  String? registration_code;
  String? resident_code;
  String? resident_phone;
  String? resident_identity;
  String? resident_relationship;
  String? contructionTypeId;
  String? contruction_unit;
  String? contruction_add;
  String? contruction_email;
  String? deputy;
  String? deputy_phone;
  String? deputy_identity;
  int? worker_num;
  String? time_start;
  String? time_end;
  String? description;
  List<ConstructionFile>? current_draw;
  List<ConstructionFile>? renovation_draw;
  double? construction_cost;
  double? deposit_fee;
  int? working_day;
  int? off_day;
  bool? isConstructionCost;
  bool? isDepositFee;
  bool? confirm;
  Status? s;
  String? reg_date;
  ConstructionType? constructionType;
  String? isRecord;
  ConstructionDocument.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    apartmentId = json['apartmentId'];
    residentId = json['residentId'];
    code = json['code'];
    status = json['status'];
    constructionRegistrationId = json['constructionRegistrationId'];
    registration_code = json['registration_code'];
    resident_code = json['resident_code'];
    resident_phone = json['resident_phone'];
    resident_identity = json['resident_identity'];
    resident_relationship = json['resident_relationship'];
    contructionTypeId = json['contructionTypeId'];
    contruction_unit = json['contruction_unit'];
    contruction_add = json['contruction_add'];
    contruction_email = json['contruction_email'];
    deputy = json['deputy'];
    deputy_phone = json['deputy_phone'];
    deputy_identity = json['deputy_identity'];
    worker_num = json['worker_num'];
    time_start = json['time_start'];
    time_end = json['time_end'];
    description = json['description'];
    working_day = json['working_day'];
    off_day = json['off_day'];
    isConstructionCost = json['isConstructionCost'];
    isDepositFee = json['isDepositFee'];
    confirm = json['confirm'];
    s = json['s'] != null ? Status.fromJson(json['s']) : null;
    reg_date = json['reg_date'];
    constructionType = json['constructionType'] != null
        ? ConstructionType.fromJson(json['constructionType'])
        : null;
    construction_cost =
        double.tryParse(json['construction_cost'].toString()) != null
            ? double.parse(json['construction_cost'].toString())
            : null;
    deposit_fee = double.tryParse(json['deposit_fee'].toString()) != null
        ? double.parse(json['deposit_fee'].toString())
        : null;
    current_draw = json['current_draw'] != null
        ? json['current_draw'].isNotEmpty
            ? json['current_draw']
                .map<ConstructionFile>((e) => ConstructionFile.fromJson(e))
                .toList()
            : []
        : [];
    renovation_draw = json['renovation_draw'] != null
        ? json['renovation_draw'].isNotEmpty
            ? json['renovation_draw']
                .map<ConstructionFile>((e) => ConstructionFile.fromJson(e))
                .toList()
            : []
        : [];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['apartmentId'] = apartmentId;
    data['residentId'] = residentId;
    data['status'] = status;
    data['constructionRegistrationId'] = constructionRegistrationId;
    data['registration_code'] = registration_code;
    data['resident_code'] = resident_code;
    data['resident_phone'] = resident_phone;
    data['resident_identity'] = resident_identity;
    data['resident_relationship'] = resident_relationship;
    data['contructionTypeId'] = contructionTypeId;
    data['contruction_unit'] = contruction_unit;
    data['contruction_add'] = contruction_add;
    data['contruction_email'] = contruction_email;
    data['deputy'] = deputy;
    data['deputy_phone'] = deputy_phone;
    data['deputy_identity'] = deputy_identity;
    data['worker_num'] = worker_num;
    data['time_start'] = time_start;
    data['time_end'] = time_end;
    data['description'] = description;
    data['working_day'] = working_day;
    data['off_day'] = off_day;
    data['code'] = code;
    data['isConstructionCost'] = isConstructionCost;
    data['isDepositFee'] = isDepositFee;
    data['confirm'] = confirm;
    data['construction_cost'] = construction_cost;
    data['deposit_fee'] = deposit_fee;
    data['current_draw'] = current_draw != null
        ? current_draw!.map((e) {
            return e.toJson();
          }).toList()
        : [];
    data['renovation_draw'] = renovation_draw != null
        ? renovation_draw!.map((e) {
            return e.toJson();
          }).toList()
        : [];
    return data;
  }
}
