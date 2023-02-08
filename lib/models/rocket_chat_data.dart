import 'package:app_cudan/screens/chat/widget/message.dart';

class RocketChatData {
  String? msg;
  String? id;
  ResultData? result;
  RocketChatData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    id = json['id'];
    result =
        json['result'] != null ? ResultData.fromJson(json['result']) : null;
  }
}

class ResultData {
  List<MessageChat>? messages;
  int? unreadNotLoaded;
  ResultData.fromJson(Map<String, dynamic> json) {
    unreadNotLoaded = json['unreadNotLoaded'];
    messages = json['messages'] != null
        ? json['messages'].isNotEmpty
            ? json['messages']
                .map<MessageChat>((e) => MessageChat.fromJson(e))
                .toList()
            : []
        : [];
  }
}

class MessageChat {
  String? id;
  String? rid;
  String? msg;
  U? u;
  List<Md>? md;
  Ts? ts;
  UpdatedAt? updatedAt;
  MessageChat.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    rid = json['rid'];
    msg = json['msg'];
    u = json['u'] != null ? U.fromJson(json['u']) : null;
    md = json['md'] != null
        ? json['md'].isNotEmpty
            ? json['md'].map<Md>((e) => Md.fromJson(e)).toList()
            : []
        : [];
    ts = json['ts'] != null ? Ts.fromJson(json['ts']) : null;
    updatedAt = json['_updatedAt'] != null
        ? UpdatedAt.fromJson(json['_updatedAt'])
        : null;
  }
}

class U {
  String? id;
  String? username;
  String? name;
  U.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    name = json['name'];
  }
}

class UpdatedAt {
  int? $date;
  UpdatedAt.fromJson(Map<String, dynamic> json) {
    $date = json[r"$date"];
  }
}

class Md {
  String? type;
  List<Value>? value;
  Md.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    // value = json['value'] != null
    //     ? json['value'].isNotEmpty
    //         ? json['value'].map<Value>((e) => Value.fromJson(e)).toList()
    //         : []
    //     : [];
  }
}

class Value {
  String? type;
  String? value;
  Value.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    type = json['type'];
  }
}

class Ts {
  int? $date;
  Ts.fromJson(Map<String, dynamic> json) {
    $date = json[r'$date'];
  }
}
