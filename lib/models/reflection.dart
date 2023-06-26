import 'dart:convert';

import 'package:app_cudan/models/reason.dart';

import 'status.dart';
import 'workarising.dart';

// ignore_for_file: non_constant_identifier_names

class Reflection {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? ticket_type;
  String? result_note;
  String? date;
  String? apartmentId;
  String? residentId;
  String? phoneNumber;
  String? opinionContributeId;
  String? status;
  String? code;
  String? opinion_note;
  String? description;
  String? staff_create;
  String? type_handle;
  bool? isMobile;
  String? department_asignment;
  String? department_division;
  String? employee_asignment;
  String? employee_division;
  String? resident_code;
  String? employee_division_form;
  String? employee_division_userName;
  String? position_asignment;
  String? position_division;
  String? position_division_form;
  String? employee_handle;
  String? employee_handle_userName;
  String? position_handle;
  String? process_content;
  String? priority_level;
  String? complaintReasonId;
  List<dynamic>? areaIds;
  List<dynamic>? floorIds;
  String? areaType;
  String? cancel_reason;
  Reason? r;
  ComplainReason? complainReason;
  Status? s;
  OpinionContribute? opinionContribute;
  List<FileTicket>? files;
  List<FileTicket>? document;

  WorkArising? result;
  Reflection({
    this.id,
    this.r,
    this.result,
    this.result_note,
    this.description,
    this.opinion_note,
    this.cancel_reason,
    this.areaIds,
    this.floorIds,
    this.areaType,
    this.complainReason,
    this.complaintReasonId,
    this.createdTime,
    this.updatedTime,
    this.ticket_type,
    this.date,
    this.apartmentId,
    this.residentId,
    this.phoneNumber,
    this.opinionContributeId,
    this.status,
    this.code,
    this.staff_create,
    this.type_handle,
    this.isMobile,
    this.department_asignment,
    this.department_division,
    this.employee_asignment,
    this.employee_division,
    this.resident_code,
    this.employee_division_form,
    this.employee_division_userName,
    this.position_asignment,
    this.position_division,
    this.position_division_form,
    this.employee_handle,
    this.employee_handle_userName,
    this.position_handle,
    this.process_content,
    this.s,
    this.opinionContribute,
    this.files,
    this.document,
    this.priority_level,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'ticket_type': ticket_type,
      'date': date,
      'result_note': result_note,
      'apartmentId': apartmentId,
      'residentId': residentId,
      'phoneNumber': phoneNumber,
      'opinionContributeId': opinionContributeId,
      'status': status,
      'code': code,
      'staff_create': staff_create,
      'type_handle': type_handle,
      'isMobile': isMobile,
      'department_asignment': department_asignment,
      'department_division': department_division,
      'employee_asignment': employee_asignment,
      'employee_division': employee_division,
      'resident_code': resident_code,
      'employee_division_form': employee_division_form,
      'employee_division_userName': employee_division_userName,
      'position_asignment': position_asignment,
      'position_division': position_division,
      'position_division_form': position_division_form,
      'employee_handle': employee_handle,
      'employee_handle_userName': employee_handle_userName,
      'position_handle': position_handle,
      'process_content': process_content,
      'priority_level': priority_level,
      'areaIds': areaIds,
      'floorIds': floorIds,
      'areaType': areaType,
      'cancel_reason': cancel_reason,
      'opinion_note': opinion_note,
      'description': description,
      'complaintReasonId': complaintReasonId,
      'files': files != null ? files!.map((x) => x.toMap()).toList() : [],
      'document':
          document != null ? document!.map((x) => x.toMap()).toList() : [],
    };
  }

  factory Reflection.fromMap(Map<String, dynamic> map) {
    return Reflection(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      ticket_type:
          map['ticket_type'] != null ? map['ticket_type'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      opinionContributeId: map['opinionContributeId'] != null
          ? map['opinionContributeId'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      staff_create:
          map['staff_create'] != null ? map['staff_create'] as String : null,
      type_handle:
          map['type_handle'] != null ? map['type_handle'] as String : null,
      isMobile: map['isMobile'] != null ? map['isMobile'] as bool : null,
      department_asignment: map['department_asignment'] != null
          ? map['department_asignment'] as String
          : null,
      department_division: map['department_division'] != null
          ? map['department_division'] as String
          : null,
      employee_asignment: map['employee_asignment'] != null
          ? map['employee_asignment'] as String
          : null,
      employee_division: map['employee_division'] != null
          ? map['employee_division'] as String
          : null,
      resident_code:
          map['resident_code'] != null ? map['resident_code'] as String : null,
      employee_division_form: map['employee_division_form'] != null
          ? map['employee_division_form'] as String
          : null,
      employee_division_userName: map['employee_division_userName'] != null
          ? map['employee_division_userName'] as String
          : null,
      position_asignment: map['position_asignment'] != null
          ? map['position_asignment'] as String
          : null,
      position_division: map['position_division'] != null
          ? map['position_division'] as String
          : null,
      position_division_form: map['position_division_form'] != null
          ? map['position_division_form'] as String
          : null,
      employee_handle: map['employee_handle'] != null
          ? map['employee_handle'] as String
          : null,
      employee_handle_userName: map['employee_handle_userName'] != null
          ? map['employee_handle_userName'] as String
          : null,
      position_handle: map['position_handle'] != null
          ? map['position_handle'] as String
          : null,
      process_content: map['process_content'] != null
          ? map['process_content'] as String
          : null,
      priority_level: map['priority_level'] != null
          ? map['priority_level'] as String
          : null,
      result_note:
          map['result_note'] != null ? map['result_note'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      areaIds: map['areaIds'] != null ? map['areaIds'] as List<dynamic> : null,
      floorIds:
          map['floorIds'] != null ? map['floorIds'] as List<dynamic> : null,
      areaType: map['areaType'] != null ? map['areaType'] as String : null,
      cancel_reason:
          map['cancel_reason'] != null ? map['cancel_reason'] as String : null,
      r: map['r'] != null ? Reason.fromJson(map['r']) : null,
      opinionContribute: map['opinionContribute'] != null
          ? OpinionContribute.fromMap(
              map['opinionContribute'] as Map<String, dynamic>,
            )
          : null,
      complainReason: map['complainReason'] != null
          ? ComplainReason.fromMap(
              map['complainReason'] as Map<String, dynamic>,
            )
          : null,
      files: map['files'] != null
          ? map['files'].map<FileTicket>((i) => FileTicket.fromMap(i)).toList()
          : [],
      document: map['document'] != null
          ? map['document']
              .map<FileTicket>((i) => FileTicket.fromMap(i))
              .toList()
          : [],
      s: map['s'] != null ? Status.fromJson(map['s']) : null,
      result: map['result'] != null ? WorkArising.fromMap(map['result']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reflection.fromJson(Map<String, dynamic> source) =>
      Reflection.fromMap(source);
}

class OpinionContribute {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? description;
  String? content;
  String? code;
  OpinionContribute({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.description,
    this.content,
    this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'description': description,
      'content': content,
      'code': code,
    };
  }

  factory OpinionContribute.fromMap(Map<String, dynamic> map) {
    return OpinionContribute(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OpinionContribute.fromJson(String source) =>
      OpinionContribute.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FileTicket {
  String? id;
  String? name;
  FileTicket({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file_id': id,
      'name': name,
    };
  }

  factory FileTicket.fromMap(Map<String, dynamic> map) {
    return FileTicket(
      id: map['file_id'] != null ? map['file_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileTicket.fromJson(String source) =>
      FileTicket.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ComplainReason {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? content;
  String? description;
  String? code;
  String? display_name;
  ComplainReason({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.content,
    this.description,
    this.code,
    this.display_name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'content': content,
      'description': description,
      'code': code,
      'display_name': display_name,
    };
  }

  factory ComplainReason.fromMap(Map<String, dynamic> map) {
    return ComplainReason(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      display_name:
          map['display_name'] != null ? map['display_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplainReason.fromJson(Map<String, dynamic> source) =>
      ComplainReason.fromMap(source);
}
