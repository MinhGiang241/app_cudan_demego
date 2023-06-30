import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Employee {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? name;
  String? code;
  String? status;
  String? avatar;
  String? date_of_birth;
  String? sex;
  String? phone_number;
  String? residence_address;
  String? permanent_address;
  String? identity;
  String? issued_by;
  String? date_range;
  String? education;
  String? school;
  String? specializes;
  String? graduation_year;
  String? sarital_status;
  String? tax_code;
  String? email;
  String? account_number;
  String? bank;
  String? departmentId;
  String? positionId;
  String? date_start;
  String? date_end;
  String? leader;
  String? direct_management;
  int? level;
  Employee({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.name,
    this.code,
    this.status,
    this.avatar,
    this.date_of_birth,
    this.sex,
    this.phone_number,
    this.residence_address,
    this.permanent_address,
    this.identity,
    this.issued_by,
    this.date_range,
    this.education,
    this.school,
    this.specializes,
    this.graduation_year,
    this.sarital_status,
    this.tax_code,
    this.email,
    this.account_number,
    this.bank,
    this.departmentId,
    this.positionId,
    this.date_start,
    this.date_end,
    this.leader,
    this.direct_management,
    this.level,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'name': name,
      'code': code,
      'status': status,
      'avatar': avatar,
      'date_of_birth': date_of_birth,
      'sex': sex,
      'phone_number': phone_number,
      'residence_address': residence_address,
      'permanent_address': permanent_address,
      'identity': identity,
      'issued_by': issued_by,
      'date_range': date_range,
      'education': education,
      'school': school,
      'specializes': specializes,
      'graduation_year': graduation_year,
      'sarital_status': sarital_status,
      'tax_code': tax_code,
      'email': email,
      'account_number': account_number,
      'bank': bank,
      'departmentId': departmentId,
      'positionId': positionId,
      'date_start': date_start,
      'date_end': date_end,
      'leader': leader,
      'direct_management': direct_management,
      'level': level,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      date_of_birth:
          map['date_of_birth'] != null ? map['date_of_birth'] as String : null,
      sex: map['sex'] != null ? map['sex'] as String : null,
      phone_number:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      residence_address: map['residence_address'] != null
          ? map['residence_address'] as String
          : null,
      permanent_address: map['permanent_address'] != null
          ? map['permanent_address'] as String
          : null,
      identity: map['identity'] != null ? map['identity'] as String : null,
      issued_by: map['issued_by'] != null ? map['issued_by'] as String : null,
      date_range:
          map['date_range'] != null ? map['date_range'] as String : null,
      education: map['education'] != null ? map['education'] as String : null,
      school: map['school'] != null ? map['school'] as String : null,
      specializes:
          map['specializes'] != null ? map['specializes'] as String : null,
      graduation_year: map['graduation_year'] != null
          ? map['graduation_year'] as String
          : null,
      sarital_status: map['sarital_status'] != null
          ? map['sarital_status'] as String
          : null,
      tax_code: map['tax_code'] != null ? map['tax_code'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      account_number: map['account_number'] != null
          ? map['account_number'] as String
          : null,
      bank: map['bank'] != null ? map['bank'] as String : null,
      departmentId:
          map['departmentId'] != null ? map['departmentId'] as String : null,
      positionId:
          map['positionId'] != null ? map['positionId'] as String : null,
      date_start:
          map['date_start'] != null ? map['date_start'] as String : null,
      date_end: map['date_end'] != null ? map['date_end'] as String : null,
      leader: map['leader'] != null ? map['leader'] as String : null,
      direct_management: map['direct_management'] != null
          ? map['direct_management'] as String
          : null,
      level: int.tryParse(map['level'].toString()) != null
          ? int.parse(map['level'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source) as Map<String, dynamic>);

  Employee copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? name,
    String? code,
    String? status,
    String? avatar,
    String? date_of_birth,
    String? sex,
    String? phone_number,
    String? residence_address,
    String? permanent_address,
    String? identity,
    String? issued_by,
    String? date_range,
    String? education,
    String? school,
    String? specializes,
    String? graduation_year,
    String? sarital_status,
    String? tax_code,
    String? email,
    String? account_number,
    String? bank,
    String? departmentId,
    String? positionId,
    String? date_start,
    String? date_end,
    String? leader,
    String? direct_management,
    int? level,
  }) {
    return Employee(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      name: name ?? this.name,
      code: code ?? this.code,
      status: status ?? this.status,
      avatar: avatar ?? this.avatar,
      date_of_birth: date_of_birth ?? this.date_of_birth,
      sex: sex ?? this.sex,
      phone_number: phone_number ?? this.phone_number,
      residence_address: residence_address ?? this.residence_address,
      permanent_address: permanent_address ?? this.permanent_address,
      identity: identity ?? this.identity,
      issued_by: issued_by ?? this.issued_by,
      date_range: date_range ?? this.date_range,
      education: education ?? this.education,
      school: school ?? this.school,
      specializes: specializes ?? this.specializes,
      graduation_year: graduation_year ?? this.graduation_year,
      sarital_status: sarital_status ?? this.sarital_status,
      tax_code: tax_code ?? this.tax_code,
      email: email ?? this.email,
      account_number: account_number ?? this.account_number,
      bank: bank ?? this.bank,
      departmentId: departmentId ?? this.departmentId,
      positionId: positionId ?? this.positionId,
      date_start: date_start ?? this.date_start,
      date_end: date_end ?? this.date_end,
      leader: leader ?? this.leader,
      direct_management: direct_management ?? this.direct_management,
      level: level ?? this.level,
    );
  }
}
