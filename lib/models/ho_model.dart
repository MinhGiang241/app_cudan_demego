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
  Registration? registration;
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
    this.registration,
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
      'registration': registration?.toMap(),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['_id'] != null ? map['_id'] as String : null,
      project_name:
          map['project_name'] != null ? map['project_name'] as String : null,
      projectTypeId:
          map['projectTypeId'] != null ? map['projectTypeId'] as String : null,
      investor: map['investor'] != null ? map['investor'] as String : null,
      project_location: map['project_location'] != null
          ? map['project_location'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      registrationId: map['registrationId'] != null
          ? map['registrationId'] as String
          : null,
      domain: map['domain'] != null ? map['domain'] as String : null,
      project_code:
          map['project_code'] != null ? map['project_code'] as String : null,
      apiEndpoint:
          map['apiEndpoint'] != null ? map['apiEndpoint'] as String : null,
      regcode: map['regcode'] != null ? map['regcode'] as String : null,
      registration: map['registration'] != null
          ? Registration.fromMap(map['registration'] as Map<String, dynamic>)
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
    String? domain,
    String? project_code,
    String? apiEndpoint,
    String? regcode,
    Registration? registration,
  }) {
    return Project(
      id: id ?? this.id,
      project_name: project_name ?? this.project_name,
      projectTypeId: projectTypeId ?? this.projectTypeId,
      investor: investor ?? this.investor,
      project_location: project_location ?? this.project_location,
      status: status ?? this.status,
      registrationId: registrationId ?? this.registrationId,
      domain: domain ?? this.domain,
      project_code: project_code ?? this.project_code,
      apiEndpoint: apiEndpoint ?? this.apiEndpoint,
      regcode: regcode ?? this.regcode,
      registration: registration ?? this.registration,
    );
  }

  @override
  String toString() {
    return 'Project(id: $id, project_name: $project_name, projectTypeId: $projectTypeId, investor: $investor, project_location: $project_location, status: $status, registrationId: $registrationId, domain: $domain, project_code: $project_code, apiEndpoint: $apiEndpoint, regcode: $regcode, registration: $registration)';
  }

  @override
  bool operator ==(covariant Project other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.project_name == project_name &&
        other.projectTypeId == projectTypeId &&
        other.investor == investor &&
        other.project_location == project_location &&
        other.status == status &&
        other.registrationId == registrationId &&
        other.domain == domain &&
        other.project_code == project_code &&
        other.apiEndpoint == apiEndpoint &&
        other.regcode == regcode &&
        other.registration == registration;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        project_name.hashCode ^
        projectTypeId.hashCode ^
        investor.hashCode ^
        project_location.hashCode ^
        status.hashCode ^
        registrationId.hashCode ^
        domain.hashCode ^
        project_code.hashCode ^
        apiEndpoint.hashCode ^
        regcode.hashCode ^
        registration.hashCode;
  }
}

class TenantInfo {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? name;
  String? code;
  String? logoId;
  String? description;
  String? domain;
  bool? isShareAuth;
  String? color;
  TenantInfo({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.name,
    this.code,
    this.logoId,
    this.description,
    this.domain,
    this.isShareAuth,
    this.color,
  });

  TenantInfo copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? name,
    String? code,
    String? logoId,
    String? description,
    String? domain,
    bool? isShareAuth,
    String? color,
  }) {
    return TenantInfo(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      name: name ?? this.name,
      code: code ?? this.code,
      logoId: logoId ?? this.logoId,
      description: description ?? this.description,
      domain: domain ?? this.domain,
      isShareAuth: isShareAuth ?? this.isShareAuth,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'name': name,
      'code': code,
      'logoId': logoId,
      'description': description,
      'domain': domain,
      'isShareAuth': isShareAuth,
      'color': color,
    };
  }

  factory TenantInfo.fromMap(Map<String, dynamic> map) {
    return TenantInfo(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      logoId: map['logoId'] != null ? map['logoId'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      domain: map['domain'] != null ? map['domain'] as String : null,
      isShareAuth:
          map['isShareAuth'] != null ? map['isShareAuth'] as bool : null,
      color: map['color'] != null ? map['color'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TenantInfo.fromJson(String source) =>
      TenantInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TenantInfo(id: $id, createdTime: $createdTime, updatedTime: $updatedTime, name: $name, code: $code, logoId: $logoId, description: $description, domain: $domain, isShareAuth: $isShareAuth, color: $color)';
  }

  @override
  bool operator ==(covariant TenantInfo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdTime == createdTime &&
        other.updatedTime == updatedTime &&
        other.name == name &&
        other.code == code &&
        other.logoId == logoId &&
        other.description == description &&
        other.domain == domain &&
        other.isShareAuth == isShareAuth &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdTime.hashCode ^
        updatedTime.hashCode ^
        name.hashCode ^
        code.hashCode ^
        logoId.hashCode ^
        description.hashCode ^
        domain.hashCode ^
        isShareAuth.hashCode ^
        color.hashCode;
  }
}

class Registration {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? tenantId;
  String? deploymentId;
  bool? active;
  bool? sandbox;
  String? description;
  String? code;
  String? appVersionId;
  String? dbName;
  String? token;
  int? dbPort;
  Registration({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.tenantId,
    this.deploymentId,
    this.active,
    this.sandbox,
    this.description,
    this.code,
    this.appVersionId,
    this.dbName,
    this.token,
    this.dbPort,
  });

  Registration copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? tenantId,
    String? deploymentId,
    bool? active,
    bool? sandbox,
    String? description,
    String? code,
    String? appVersionId,
    String? dbName,
    String? token,
    int? dbPort,
  }) {
    return Registration(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      tenantId: tenantId ?? this.tenantId,
      deploymentId: deploymentId ?? this.deploymentId,
      active: active ?? this.active,
      sandbox: sandbox ?? this.sandbox,
      description: description ?? this.description,
      code: code ?? this.code,
      appVersionId: appVersionId ?? this.appVersionId,
      dbName: dbName ?? this.dbName,
      token: token ?? this.token,
      dbPort: dbPort ?? this.dbPort,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'tenantId': tenantId,
      'deploymentId': deploymentId,
      'active': active,
      'sandbox': sandbox,
      'description': description,
      'code': code,
      'appVersionId': appVersionId,
      'dbName': dbName,
      'token': token,
      'dbPort': dbPort,
    };
  }

  factory Registration.fromMap(Map<String, dynamic> map) {
    return Registration(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      tenantId: map['tenantId'] != null ? map['tenantId'] as String : null,
      deploymentId:
          map['deploymentId'] != null ? map['deploymentId'] as String : null,
      active: map['active'] != null ? map['active'] as bool : null,
      sandbox: map['sandbox'] != null ? map['sandbox'] as bool : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      appVersionId:
          map['appVersionId'] != null ? map['appVersionId'] as String : null,
      dbName: map['dbName'] != null ? map['dbName'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      dbPort: int.tryParse(map['dbPort'].toString()) != null
          ? int.parse(map['dbPort'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Registration.fromJson(String source) =>
      Registration.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Registration(id: $id, createdTime: $createdTime, updatedTime: $updatedTime, tenantId: $tenantId, deploymentId: $deploymentId, active: $active, sandbox: $sandbox, description: $description, code: $code, appVersionId: $appVersionId, dbName: $dbName, token: $token, dbPort: $dbPort)';
  }

  @override
  bool operator ==(covariant Registration other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdTime == createdTime &&
        other.updatedTime == updatedTime &&
        other.tenantId == tenantId &&
        other.deploymentId == deploymentId &&
        other.active == active &&
        other.sandbox == sandbox &&
        other.description == description &&
        other.code == code &&
        other.appVersionId == appVersionId &&
        other.dbName == dbName &&
        other.token == token &&
        other.dbPort == dbPort;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdTime.hashCode ^
        updatedTime.hashCode ^
        tenantId.hashCode ^
        deploymentId.hashCode ^
        active.hashCode ^
        sandbox.hashCode ^
        description.hashCode ^
        code.hashCode ^
        appVersionId.hashCode ^
        dbName.hashCode ^
        token.hashCode ^
        dbPort.hashCode;
  }
}

class RegistrationProjectList {
  Project? project;
  Deployment? deployment;
  RegistrationProjectList({
    this.project,
    this.deployment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'project': project?.toMap(),
      'deployment': deployment?.toMap(),
    };
  }

  factory RegistrationProjectList.fromMap(Map<String, dynamic> map) {
    return RegistrationProjectList(
      project: map['project'] != null
          ? Project.fromMap(map['project'] as Map<String, dynamic>)
          : null,
      deployment: map['deployment'] != null
          ? Deployment.fromMap(map['deployment'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationProjectList.fromJson(String source) =>
      RegistrationProjectList.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

class Deployment {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? appId;
  String? serverId;
  String? domain;
  String? apiEndpoint;
  String? tokenEndpoint;
  Deployment({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.appId,
    this.serverId,
    this.domain,
    this.apiEndpoint,
    this.tokenEndpoint,
  });

  Deployment copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? appId,
    String? serverId,
    String? domain,
    String? apiEndpoint,
    String? tokenEndpoint,
  }) {
    return Deployment(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      appId: appId ?? this.appId,
      serverId: serverId ?? this.serverId,
      domain: domain ?? this.domain,
      apiEndpoint: apiEndpoint ?? this.apiEndpoint,
      tokenEndpoint: tokenEndpoint ?? this.tokenEndpoint,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'appId': appId,
      'serverId': serverId,
      'domain': domain,
      'apiEndpoint': apiEndpoint,
      'tokenEndpoint': tokenEndpoint,
    };
  }

  factory Deployment.fromMap(Map<String, dynamic> map) {
    return Deployment(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      appId: map['appId'] != null ? map['appId'] as String : null,
      serverId: map['serverId'] != null ? map['serverId'] as String : null,
      domain: map['domain'] != null ? map['domain'] as String : null,
      apiEndpoint:
          map['apiEndpoint'] != null ? map['apiEndpoint'] as String : null,
      tokenEndpoint:
          map['tokenEndpoint'] != null ? map['tokenEndpoint'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Deployment.fromJson(String source) =>
      Deployment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Deployment(id: $id, createdTime: $createdTime, updatedTime: $updatedTime, appId: $appId, serverId: $serverId, domain: $domain, apiEndpoint: $apiEndpoint, tokenEndpoint: $tokenEndpoint)';
  }

  @override
  bool operator ==(covariant Deployment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdTime == createdTime &&
        other.updatedTime == updatedTime &&
        other.appId == appId &&
        other.serverId == serverId &&
        other.domain == domain &&
        other.apiEndpoint == apiEndpoint &&
        other.tokenEndpoint == tokenEndpoint;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdTime.hashCode ^
        updatedTime.hashCode ^
        appId.hashCode ^
        serverId.hashCode ^
        domain.hashCode ^
        apiEndpoint.hashCode ^
        tokenEndpoint.hashCode;
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
  String? accountType;
  Project? project;
  TenantInfo? tenantInfo;
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
    this.tenantInfo,
    this.accountType,
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
    String? accountType,
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
      accountType: note ?? this.accountType,
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
      'accountType': accountType,
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
      accountType:
          map['accountType'] != null ? map['accountType'] as String : null,
      project: map['project'] != null
          ? Project.fromMap(map['project'] as Map<String, dynamic>)
          : null,
      tenantInfo: map['tenantinfo'] != null
          ? TenantInfo.fromMap(map['tenantinfo'] as Map<String, dynamic>)
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
