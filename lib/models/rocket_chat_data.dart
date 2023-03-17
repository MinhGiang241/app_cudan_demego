// ignore_for_file: non_constant_identifier_names, prefer_null_aware_operators

class RocketChatData {
  String? msg;
  String? id;
  String? collection;
  ResultData? result;
  MessageChat? result_chat;
  Fields? fields;
  RocketChatData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    id = json['id'];
    collection = json['collection'];

    result = json['result'] != null && json['result']['messages'] != null
        ? ResultData.fromJson(json['result'])
        : null;
    result_chat = json['result'] != null && json['result']['msg'] != null
        ? MessageChat.fromJson(json['result'])
        : null;
    fields = json['fields'] != null ? Fields.fromJson(json['fields']) : null;
  }
}

class Fields {
  String? eventName;
  List<MessageChat>? args;
  Fields.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    args = json['args'] != null
        ? json['args'].isNotEmpty
            ? json['args']
                .map<MessageChat>((e) => MessageChat.fromJson(e))
                .toList()
            : []
        : [];
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

class UserEmoji {}

class MessageChat {
  String? id;
  String? rid;
  String? msg;
  bool? groupable;
  U? u;
  List<Md>? md;
  Ts? ts;
  FileChat? file;
  List<FileChat>? files;
  UpdatedAt? updatedAt;
  List<Attachments>? attachments;
  Map<String, dynamic>? reactions;
  MessageChat.fromJson(Map<String, dynamic> json) {
    groupable = json['groupable'];
    id = json['_id'];
    rid = json['rid'];
    msg = json['msg'];
    reactions = json['reactions'] ?? {};
    file = json['file'] != null ? FileChat.fromJson(json['file']) : null;
    u = json['u'] != null ? U.fromJson(json['u']) : null;
    files = json['files'] != null
        ? json['files'].isNotEmpty
            ? json['files'].map<FileChat>((e) => FileChat.fromJson(e)).toList()
            : []
        : [];
    md = json['md'] != null
        ? json['md'].isNotEmpty
            ? json['md'].map<Md>((e) => Md.fromJson(e)).toList()
            : []
        : [];
    // ts = json['ts'] != null ? Ts.fromJson(json['ts']) : null;
    // updatedAt = json['_updatedAt'] != null
    //     ? UpdatedAt.fromJson(json['_updatedAt'])
    //     : null;
    attachments = json['attachments'] != null
        ? json['attachments'].isNotEmpty
            ? json['attachments']
                .map<Attachments>((e) => Attachments.fromJson(e))
                .toList()
            : []
        : [];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['rid'] = rid;
    data['msg'] = msg;
    data['reactions'] = reactions;
    data['files'] = files != null
        ? files!.map((e) {
            return e.toJson();
          }).toList()
        : null;
    data['attachments'] = attachments != null
        ? attachments!.map((e) {
            return e.toJson();
          }).toList()
        : null;

    data['ts'] = ts != null ? ts?.toJson() : null;
    data['u'] = u != null ? u?.toJson() : null;
    return data;
  }
}

class Attachments {
  String? ts;
  String? title;
  String? title_link;
  bool? title_link_download;
  String? image_preview;
  String? image_url;
  String? image_type;
  String? description;
  int? image_size;
  String? file;
  ImageDimention? image_dimensions;
  Attachments.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    title = json['title'];
    title_link = json['title_link'];
    title_link_download = json['title_link_download'] ?? true;
    image_preview = json['image_preview'];
    image_url = json['image_url'];
    image_type = json['image_type'];
    file = json['file'];
    description = json['description'];
    image_size = json['image_size'];
    image_dimensions = json['image_dimensions'] != null
        ? ImageDimention.fromJson(json['image_dimensions'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ts'] = ts;
    data['title'] = title;
    data['title_link'] = title_link;
    data['title_link_download'] = title_link_download;
    data['image_preview'] = image_preview;
    data['title_link'] = title_link;
    data['image_url'] = image_url;
    data['image_type'] = image_type;
    data['file'] = file;
    data['image_size'] = image_size;
    data['image_dimensions'] =
        image_dimensions != null ? image_dimensions?.toJson() : null;
    return data;
  }
}

class ImageDimention {
  int? width;
  int? height;
  ImageDimention.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class FileChat {
  String? id;
  String? name;
  String? type;
  FileChat.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    type = json['type'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['username'] = username;
    return data;
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[r'$date'] = $date;
    return data;
  }
}
