import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Project {
  String? id;
  String? project_name;
  String? projectTypeId;
  String? investor;
  String? project_location;
  String? status;
  String? registrationId;
  String? domain;
  String? project_code;
  String? apiEndpoint;
  String? regcode;
  Project({
    this.id,
    this.project_name,
    this.projectTypeId,
    this.investor,
    this.project_location,
    this.status,
    this.registrationId,
    this.domain,
    this.project_code,
    this.apiEndpoint,
    this.regcode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'project_name': project_name,
      'projectTypeId': projectTypeId,
      'investor': investor,
      'project_location': project_location,
      'status': status,
      'registrationId': registrationId,
      'domain': domain,
      'project_code': project_code,
      'apiEndpoint': apiEndpoint,
      'regcode': regcode,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['_id'] != null ? map['_id'] as String : null,
      project_name:
          map['project_name'] != null ? map['project_name'] as String : null,
      apiEndpoint:
          map['apiEndpoint'] != null ? map['apiEndpoint'] as String : null,
      projectTypeId:
          map['projectTypeId'] != null ? map['projectTypeId'] as String : null,
      investor: map['investor'] != null ? map['investor'] as String : null,
      project_location: map['project_location'] != null
          ? map['project_location'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      domain: map['domain'] != null ? map['domain'] as String : null,
      regcode: map['regcode'] != null ? map['regcode'] as String : null,
      project_code:
          map['project_code'] != null ? map['project_code'] as String : null,
      registrationId: map['registrationId'] != null
          ? map['registrationId'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source) as Map<String, dynamic>);

  Project copyWith({
    String? id,
    String? project_name,
    String? projectTypeId,
    String? investor,
    String? project_location,
    String? status,
    String? registrationId,
    String? apiEndpoint,
    String? regcode,
  }) {
    return Project(
      id: id ?? this.id,
      project_name: project_name ?? this.project_name,
      projectTypeId: projectTypeId ?? this.projectTypeId,
      investor: investor ?? this.investor,
      project_location: project_location ?? this.project_location,
      status: status ?? this.status,
      registrationId: registrationId ?? this.registrationId,
      apiEndpoint: apiEndpoint ?? this.apiEndpoint,
      regcode: regcode ?? this.regcode,
    );
  }
}

class ResidentResitration {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? tenantId;
  String? guestId;
  String? registrationId;
  String? apartmentCode;
  String? relationship;
  String? contractCode;
  String? status;
  String? note;
  Project? project;
  GuestAccount? guestaccount;
  ResidentResitration({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.tenantId,
    this.guestId,
    this.registrationId,
    this.apartmentCode,
    this.relationship,
    this.contractCode,
    this.project,
    this.guestaccount,
    this.status,
    this.note,
  });

  ResidentResitration copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? tenantId,
    String? guestId,
    String? registrationId,
    String? apartmentCode,
    String? relationship,
    String? contractCode,
    Project? project,
    GuestAccount? guestaccount,
    String? status,
    String? note,
  }) {
    return ResidentResitration(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      tenantId: tenantId ?? this.tenantId,
      guestId: guestId ?? this.guestId,
      registrationId: registrationId ?? this.registrationId,
      apartmentCode: apartmentCode ?? this.apartmentCode,
      relationship: relationship ?? this.relationship,
      contractCode: contractCode ?? this.contractCode,
      project: project ?? this.project,
      guestaccount: guestaccount ?? this.guestaccount,
      status: status ?? this.status,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'tenantId': tenantId,
      'guestId': guestId,
      'registrationId': registrationId,
      'apartmentCode': apartmentCode,
      'relationship': relationship,
      'contractCode': contractCode,
      'status': status,
      'note': note,
      'project': project?.toMap(),
      'guestaccount': guestaccount?.toMap(),
    };
  }

  factory ResidentResitration.fromMap(Map<String, dynamic> map) {
    return ResidentResitration(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      tenantId: map['tenantId'] != null ? map['tenantId'] as String : null,
      guestId: map['guestId'] != null ? map['guestId'] as String : null,
      registrationId: map['registrationId'] != null
          ? map['registrationId'] as String
          : null,
      apartmentCode:
          map['apartmentCode'] != null ? map['apartmentCode'] as String : null,
      relationship:
          map['relationship'] != null ? map['relationship'] as String : null,
      contractCode:
          map['contractCode'] != null ? map['contractCode'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      project: map['project'] != null
          ? Project.fromMap(map['project'] as Map<String, dynamic>)
          : null,
      guestaccount: map['guestaccount'] != null
          ? GuestAccount.fromMap(map['guestaccount'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResidentResitration.fromJson(String source) =>
      ResidentResitration.fromMap(json.decode(source) as Map<String, dynamic>);
}

class GuestAccount {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? userName;
  String? password;
  String? email;
  String? phone;
  String? passwordHash;
  bool? isActive;
  GuestAccount({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.userName,
    this.password,
    this.email,
    this.phone,
    this.passwordHash,
    this.isActive,
  });

  GuestAccount copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? userName,
    String? password,
    String? email,
    String? phone,
    String? passwordHash,
    bool? isActive,
  }) {
    return GuestAccount(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      passwordHash: passwordHash ?? this.passwordHash,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'userName': userName,
      'password': password,
      'email': email,
      'phone': phone,
      'passwordHash': passwordHash,
      'isActive': isActive,
    };
  }

  factory GuestAccount.fromMap(Map<String, dynamic> map) {
    return GuestAccount(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      passwordHash:
          map['passwordHash'] != null ? map['passwordHash'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GuestAccount.fromJson(String source) =>
      GuestAccount.fromMap(json.decode(source) as Map<String, dynamic>);
}
