// ignore_for_file: non_constant_identifier_names

import 'reason.dart';
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
    this.construction_add,
    this.construction_email,
    this.construction_unit,
    this.create_date,
    this.current_draw,
    this.deposit_fee,
    this.deputy,
    this.deputy_identity,
    this.deputy_phone,
    this.description,
    this.history_code,
    this.id,
    this.isContructionCost = false,
    this.isDepositFee = false,
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
    this.off_day,
    this.working_day,
    this.file_cancel,
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
  String? construction_unit;
  String? construction_add;
  String? construction_email;
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
  int? off_day;
  bool? isContructionCost;
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
  Reason? r;
  ConstructionType? constructionType;
  List<ConstructionFile>? current_draw;
  List<ConstructionFile>? renovation_draw;
  List<ConstructionFile>? file_cancel;

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
    construction_unit = json['construction_unit'];
    construction_add = json['construction_add'];
    construction_email = json['construction_email'];
    deputy = json['deputy'];
    deputy_phone = json['deputy_phone'];
    deputy_identity = json['deputy_identity'];
    worker_num = json['worker_num'];
    constructionTypeId = json['constructionTypeId'];
    time_start = json['time_start'];
    time_end = json['time_end'];
    description = json['description'];
    s = json['s'] != null ? Status.fromJson(json['s']) : null;
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
    off_day = json['off_day'];
    isContructionCost = json['isContructionCost'];
    isDepositFee = json['isDepositFee'];
    confirm = json['confirm'];
    cancel_reason = json['cancel_reason'];
    reason_description = json['reason_description'];
    history_code = json['history_code'];
    resident_name = json['resident_name'];

    construction_type_name = json['construction_type_name'];
    create_date = json['create_date'];
    isMobile = json['isMobile'];
    r = json['r'] != null
        ? json['r'].isNotEmpty
            ? Reason.fromJson(json['r'][0])
            : null
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
    file_cancel = json['file_cancel'] != null
        ? json['file_cancel'].isNotEmpty
            ? json['file_cancel']
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
    data['construction_unit'] = construction_unit;
    data['construction_add'] = construction_add;
    data['construction_email'] = construction_email;
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
    data['isContructionCost'] = isContructionCost;
    data['isDepositFee'] = isDepositFee;
    data['confirm'] = confirm;
    data['cancel_reason'] = cancel_reason;
    data['reason_description'] = reason_description;
    data['history_code'] = history_code;
    data['resident_name'] = resident_name;
    data['construction_type_name'] = construction_type_name;
    data['create_date'] = create_date;
    data['isMobile'] = isMobile;
    data['off_day'] = off_day;
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
    data['file_cancel'] = file_cancel != null
        ? file_cancel!.map((e) {
            return e.toJson();
          }).toList()
        : null;
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
  ConstructionType(
      {this.id,
      this.name,
      this.code,
      this.createdTime,
      this.describe,
      this.updatedTime,
      this.c});
  String? id;
  String? name;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? describe;
  ConstructionCost? c;
  DayOff? dayOff;
  ConstructionType.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    describe = json['describe'];
    name = json['name'];
    c = json['c'] != null ? ConstructionCost.fromJson(json['c']) : null;
    dayOff = json['dayOff'] != null ? DayOff.fromJson(json['dayOff']) : null;
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
    this.constructionTypeId,
    this.construction_add,
    this.construction_email,
    this.construction_unit,
    this.createdTime,
    this.current_draw,
    this.deposit_fee,
    this.deputy,
    this.deputy_identity,
    this.deputy_phone,
    this.description,
    this.id,
    this.isContructionCost,
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
  String? constructionTypeId;
  String? construction_unit;
  String? construction_add;
  String? construction_email;
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
  bool? isContructionCost;
  bool? isDepositFee;
  bool? confirm;
  Status? s;
  List<ViolationRecord>? v;
  String? reg_date;
  ConstructionType? constructionType;
  ConstructionRegistration? c;
  bool? isRecord;
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
    constructionTypeId = json['constructionTypeId'];
    construction_unit = json['construction_unit'];
    construction_add = json['construction_add'];
    construction_email = json['construction_email'];
    deputy = json['deputy'];
    deputy_phone = json['deputy_phone'];
    deputy_identity = json['deputy_identity'];
    worker_num = json['worker_num'];
    time_start = json['time_start'];
    time_end = json['time_end'];
    description = json['description'];
    working_day = json['working_day'];
    off_day = json['off_day'];
    isContructionCost = json['isContructionCost'];
    isDepositFee = json['isDepositFee'];
    isRecord = json['isRecord'] ?? false;
    confirm = json['confirm'];
    s = json['s'] != null ? Status.fromJson(json['s']) : null;
    c = json['c'] != null ? ConstructionRegistration.fromJson(json['c']) : null;
    v = json['v'] != null
        ? json['v'].isNotEmpty
            ? json['v']
                .map<ViolationRecord>((e) => ViolationRecord.fromJson(e))
                .toList()
            : []
        : [];
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
    data['constructionTypeId'] = constructionTypeId;
    data['construction_unit'] = construction_unit;
    data['construction_add'] = construction_add;
    data['construction_email'] = construction_email;
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
    data['isContructionCost'] = isContructionCost;
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

class ConstructionHistory {
  ConstructionHistory({
    this.cancel_reason,
    this.constructionregistrationId,
    this.createdTime,
    this.date,
    this.employeeId,
    this.id,
    this.person,
    this.residentId,
    this.status,
    this.updatedTime,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? status;
  String? person;
  String? date;
  String? cancel_reason;
  String? residentId;
  String? employeeId;
  String? constructionregistrationId;
  Status? s;
  ConstructionHistory.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    status = json['status'];
    person = json['person'];
    date = json['date'];
    cancel_reason = json['cancel_reason'];
    residentId = json['residentId'];
    employeeId = json['employeeId'];
    constructionregistrationId = json['constructionregistrationId'];
    s = json['s'] != null ? Status.fromJson(json['s']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['status'] = status;
    data['person'] = person;
    data['date'] = date;
    data['cancel_reason'] = cancel_reason;
    data['residentId'] = residentId;
    data['employeeId'] = employeeId;
    data['constructionregistrationId'] = constructionregistrationId;
    return data;
  }
}

class ConstructionCost {
  ConstructionCost({
    this.chargeFormCost,
    this.chargeFormDeposit,
    this.cost,
    this.createdTime,
    this.depositFee,
    this.id,
    this.updatedTime,
    this.constructiontypeId,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? constructiontypeId;
  double? cost;
  String? chargeFormCost;
  double? depositFee;
  String? chargeFormDeposit;
  ConstructionCost.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    constructiontypeId = json['constructiontypeId'];
    cost = double.tryParse(json['cost'].toString()) != null
        ? double.parse(json['cost'].toString())
        : 0;
    chargeFormCost = json['chargeFormCost'];
    depositFee = double.tryParse(json['depositFee'].toString()) != null
        ? double.parse(json['depositFee'].toString())
        : null;
    chargeFormDeposit = json['chargeFormDeposit'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['constructiontypeId'] = constructiontypeId;
    data['cost'] = cost;
    data['chargeFormCost'] = chargeFormCost;
    data['depositFee'] = depositFee;
    data['chargeFormDeposit'] = chargeFormDeposit;

    return data;
  }
}

class DayOff {
  String? id;
  String? createdTime;
  String? updatedTime;
  bool? d_0;
  bool? d_1;
  bool? d_2;
  bool? d_3;
  bool? d_4;
  bool? d_5;
  bool? d_6;
  DayOff.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    d_0 = json['d_0'] ?? false;
    d_1 = json['d_1'] ?? false;
    d_2 = json['d_2'] ?? false;
    d_3 = json['d_3'] ?? false;
    d_4 = json['d_4'] ?? false;
    d_5 = json['d_5'] ?? false;
    d_6 = json['d_6'] ?? false;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['d_0'] = d_0;
    data['d_1'] = d_1;
    data['d_2'] = d_2;
    data['d_3'] = d_3;
    data['d_4'] = d_4;
    data['d_5'] = d_5;
    data['d_6'] = d_6;

    return data;
  }
}

class ViolationRecord {
  ViolationRecord({
    this.createdTime,
    this.code,
    this.constructionAcceptanceId,
    this.constructionDocumentId,
    this.describe,
    this.id,
    this.image,
    this.name,
    this.record_creator,
    this.result,
    this.time_end,
    this.time_start,
    this.updatedTime,
    this.violation_list,
    this.witness,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? name;
  String? witness;
  String? time_start;
  String? time_end;
  String? describe;
  String? result;
  List<ConstructionFile>? image;
  List<ViolationList>? violation_list;
  String? constructionAcceptanceId;
  String? constructionDocumentId;
  String? code;
  String? record_creator;
  ViolationRecord.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    name = json['name'];
    witness = json['witness'];
    time_start = json['time_start'];
    time_end = json['time_end'];
    describe = json['describe'];
    result = json['result'];
    constructionAcceptanceId = json['constructionAcceptanceId'];
    constructionDocumentId = json['constructionDocumentId'];
    code = json['code'];
    record_creator = json['record_creator'];

    violation_list = json['violation_list'] != null
        ? json['violation_list'].isNotEmpty
            ? json['violation_list']
                .map<ViolationList>((e) => ViolationList.fromJson(e))
                .toList()
            : []
        : [];
    image = json['image'] != null
        ? json['image'].isNotEmpty
            ? json['image']
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
    data['name'] = name;
    data['witness'] = witness;
    data['time_start'] = time_start;
    data['time_end'] = time_end;
    data['result'] = result;
    data['constructionAcceptanceId'] = constructionAcceptanceId;
    data['constructionDocumentId'] = constructionDocumentId;
    data['code'] = code;
    data['record_creator'] = record_creator;
    data['violation_list'] = violation_list != null
        ? violation_list!.map((e) {
            return e.toJson();
          }).toList()
        : [];

    data['image'] = image != null
        ? image!.map((e) {
            return e.toJson();
          }).toList()
        : [];
    return data;
  }
}

class ViolationList {
  ViolationList({
    this.createdTime,
    this.defectId,
    this.order,
    this.sanctionsManagementId,
    this.times,
    this.updatedTime,
  });
  String? defectId;
  String? createdTime;
  String? updatedTime;
  int? times;
  String? sanctionsManagementId;
  int? order;
  ViolationList.fromJson(Map<String, dynamic> json) {
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    defectId = json['defectId'];
    times = int.tryParse(json['times'].toString()) != null
        ? int.parse(json['times'].toString())
        : 0;
    sanctionsManagementId = json['sanctionsManagementId'];
    order = int.tryParse(json['order'].toString()) != null
        ? int.parse(json['order'].toString())
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['defectId'] = defectId;
    data['times'] = times;
    data['sanctionsManagementId'] = sanctionsManagementId;
    data['order'] = order;
    return data;
  }
}
