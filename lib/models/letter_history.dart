// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'status.dart';

class LetterHistory {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? action;
  String? employeeId;
  String? perform_date;
  String? content;
  String? person;
  String? type;
  String? refId;
  String? new_status;
  String? old_status;
// new status
  Status? os;
  Status? ns;
  LetterHistory({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.action,
    this.employeeId,
    this.perform_date,
    this.content,
    this.person,
    this.type,
    this.refId,
    this.new_status,
    this.old_status,
    this.os,
    this.ns,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'action': action,
      'employeeId': employeeId,
      'perform_date': perform_date,
      'content': content,
      'person': person,
      'type': type,
      'refId': refId,
      'new_status': new_status,
      'old_status': old_status,
      'os': os?.toJson(),
      'ns': ns?.toJson(),
    };
  }

  factory LetterHistory.fromMap(Map<String, dynamic> map) {
    return LetterHistory(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      action: map['action'] != null ? map['action'] as String : null,
      employeeId:
          map['employeeId'] != null ? map['employeeId'] as String : null,
      perform_date:
          map['perform_date'] != null ? map['perform_date'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      person: map['person'] != null ? map['person'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      refId: map['refId'] != null ? map['refId'] as String : null,
      new_status:
          map['new_status'] != null ? map['new_status'] as String : null,
      old_status:
          map['old_status'] != null ? map['old_status'] as String : null,
      os: map['os'] != null
          ? Status.fromJson(map['os'] as Map<String, dynamic>)
          : null,
      ns: map['ns'] != null
          ? Status.fromJson(map['ns'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LetterHistory.fromJson(String source) =>
      LetterHistory.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CardHistory {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? action;
  String? employeeId;
  String? perform_date;
  String? content;
  String? person;
  String? manageCardId;
  String? status;
  String? residentId;
  String? name;
  Status? s;
  CardHistory({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.action,
    this.employeeId,
    this.perform_date,
    this.content,
    this.person,
    this.manageCardId,
    this.status,
    this.residentId,
    this.name,
    this.s,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'action': action,
      'employeeId': employeeId,
      'perform_date': perform_date,
      'content': content,
      'person': person,
      'manageCardId': manageCardId,
      'residentId': residentId,
      'status': status,
      'name': name,
    };
  }

  factory CardHistory.fromMap(Map<String, dynamic> map) {
    return CardHistory(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      action: map['action'] != null ? map['action'] as String : null,
      employeeId:
          map['employeeId'] != null ? map['employeeId'] as String : null,
      perform_date:
          map['perform_date'] != null ? map['perform_date'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      person: map['person'] != null ? map['person'] as String : null,
      manageCardId:
          map['manageCardId'] != null ? map['manageCardId'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      s: map['s'] != null ? Status.fromJson(map['s']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CardHistory.fromJson(String source) =>
      CardHistory.fromMap(json.decode(source) as Map<String, dynamic>);
}
