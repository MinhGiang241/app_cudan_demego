class QuestChat {
  String? id;
  String? name;
  List<EmailChat>? emails;
  String? status;
  String? statusConnection;
  String? username;
  double? utcOffset;
  bool? active;
  List<String>? roles;
  String? avatarUrl;
  Map<String, String>? customFields;
  bool? success;
}

class EmailChat {
  String? address;
  bool? verified;
}
