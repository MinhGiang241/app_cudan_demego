// ignore_for_file: non_constant_identifier_names

class Account {
  String? id;
  String? createdTime;
  String? updatedTime;
  bool? isLocked;
  bool? isDraft;
  bool? isRoot;
  bool? isActive;
  String? userName;
  String? password;
  String? email;
  String? type;
  String? code;
  String? residentId;
  String? phone;
  String? fullName;
  String? avatar;
  String? passwordHash;
  String? tenantId;

  Account({
    this.code,
    this.createdTime,
    this.email,
    this.id,
    this.isActive,
    this.isDraft,
    this.isLocked,
    this.isRoot,
    this.password,
    this.phone,
    this.residentId,
    this.type,
    this.updatedTime,
    this.userName,
    this.fullName,
    this.avatar,
    this.tenantId,
    this.passwordHash,
  });
  Account.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    isLocked = json['isLocked'];
    isRoot = json['isRoot'];
    isDraft = json['isDraft'];
    isActive = json['isActive'];
    residentId = json['residentId'];
    userName = json['userName'];
    password = json['password'];
    email = json['email'];
    code = json['code'];
    type = json['type'];
    phone = json['phone'];
    fullName = json['fullName'];
    avatar = json['avatar'];
    passwordHash = json['passwordHash'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['residentId'] = residentId;
    data['isRoot'] = isRoot;
    data['userName'] = userName;
    data['password'] = password;
    data['passwordHash'] = passwordHash;
    data['email'] = email;
    data['phone'] = phone;
    data['type'] = type;
    data['code'] = code;
    data['fullName'] = fullName;
    data['avatar'] = avatar;
    data['tenantId'] = tenantId;
    return data;
  }
}
