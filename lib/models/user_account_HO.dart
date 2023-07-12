// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'account.dart';
import 'resident_info.dart';

class UserAccountHO {
  String? id;
  String? createdTime;
  String? updatedTime;
  ResponseResidentInfo? resident;
  Account? user;
  String? host;
  String? type;
  bool? isSystem;
  String? tenantId;
  String? deploymentId;
  String? registrationId;
  String? regCode;
  String? api;
  String? sessionId;
  UserAccountHO({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.resident,
    this.user,
    this.host,
    this.type,
    this.isSystem,
    this.tenantId,
    this.deploymentId,
    this.registrationId,
    this.regCode,
    this.api,
    this.sessionId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'resident': resident?.toJson(),
      'user': user?.toJson(),
      'host': host,
      'type': type,
      'isSystem': isSystem,
      'tenantId': tenantId,
      'deploymentId': deploymentId,
      'registrationId': registrationId,
      'regCode': regCode,
      'api': api,
      'sessionId': sessionId,
    };
  }

  factory UserAccountHO.fromMap(Map<String, dynamic> map) {
    return UserAccountHO(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      resident: map['resident'] != null
          ? ResponseResidentInfo.fromJson(
              map['resident'] as Map<String, dynamic>)
          : null,
      user: map['user'] != null
          ? Account.fromJson(map['user'] as Map<String, dynamic>)
          : null,
      host: map['host'] != null ? map['host'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      isSystem: map['isSystem'] != null ? map['isSystem'] as bool : null,
      tenantId: map['tenantId'] != null ? map['tenantId'] as String : null,
      deploymentId:
          map['deploymentId'] != null ? map['deploymentId'] as String : null,
      registrationId: map['registrationId'] != null
          ? map['registrationId'] as String
          : null,
      regCode: map['regCode'] != null ? map['regCode'] as String : null,
      api: map['api'] != null ? map['api'] as String : null,
      sessionId: map['sessionId'] != null ? map['sessionId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAccountHO.fromJson(String source) =>
      UserAccountHO.fromMap(json.decode(source) as Map<String, dynamic>);

  UserAccountHO copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    ResponseResidentInfo? resident,
    Account? user,
    String? host,
    String? type,
    bool? isSystem,
    String? tenantId,
    String? deploymentId,
    String? registrationId,
    String? regCode,
    String? api,
    String? sessionId,
  }) {
    return UserAccountHO(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      resident: resident ?? this.resident,
      user: user ?? this.user,
      host: host ?? this.host,
      type: type ?? this.type,
      isSystem: isSystem ?? this.isSystem,
      tenantId: tenantId ?? this.tenantId,
      deploymentId: deploymentId ?? this.deploymentId,
      registrationId: registrationId ?? this.registrationId,
      regCode: regCode ?? this.regCode,
      api: api ?? this.api,
      sessionId: sessionId ?? this.sessionId,
    );
  }
}
