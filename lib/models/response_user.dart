import 'account.dart';

class ResponseUser {
  String? userId;
  String? phone;
  String? email;
  String? userName;
  String? congTy;
  String? avatarLink;
  String? birthday;
  String? sex;
  String? cmnd;
  String? national;
  dynamic status;
  String? message;
  Account? account;

  ResponseUser(
      {this.userId,
      this.phone,
      this.email,
      this.userName,
      this.congTy,
      this.avatarLink,
      this.birthday,
      this.sex,
      this.account,
      this.cmnd,
      this.national});

  ResponseUser.fromJson(Map<String, dynamic> json) {
    account = Account.fromJson(json['account']);
    userId = json["userId"];
    phone = json["phone"];
    email = json["email"];
    userName = json["userName"];
    congTy = json["congTy"];
    avatarLink = json["avatarLink"];
    birthday = json["birthday"];
    sex = json["sex"];
    cmnd = json["cmnd"];
    national = json["national"];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userId"] = userId;
    data["phone"] = phone;
    data["email"] = email;
    data["userName"] = userName;
    data["congTy"] = congTy;
    data["avatarLink"] = avatarLink;
    data["birthday"] = birthday;
    data["sex"] = sex;
    data["cmnd"] = cmnd;
    data["national"] = national;
    data["account"] = account != null ? account!.toJson() : null;
    return data;
  }
}
