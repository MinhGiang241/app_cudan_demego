// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationType {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? icon;
  String? code;
  String? name;
  String? targetType;
  String? description;
  NotificationType({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.icon,
    this.code,
    this.name,
    this.targetType,
    this.description,
  });

  NotificationType copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? icon,
    String? code,
    String? name,
    String? targetType,
    String? description,
  }) =>
      NotificationType(
        id: id ?? this.id,
        createdTime: createdTime ?? this.createdTime,
        updatedTime: updatedTime ?? this.updatedTime,
        icon: icon ?? this.icon,
        code: code ?? this.code,
        name: name ?? this.name,
        targetType: targetType ?? this.targetType,
        description: description ?? this.description,
      );

  factory NotificationType.fromMap(Map<String, dynamic> json) =>
      NotificationType(
        id: json["_id"],
        createdTime: json["createdTime"],
        updatedTime: json["updatedTime"],
        icon: json["icon"],
        code: json["code"],
        name: json["name"],
        targetType: json["targetType"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "createdTime": createdTime,
        "updatedTime": updatedTime,
        "icon": icon,
        "code": code,
        "name": name,
        "targetType": targetType,
        "description": description,
      };
}

class Notification {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? title;
  String? body;
  NotificationData? data;
  int? failure;
  int? success;
  bool? sent;
  bool? read;
  Notification({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.title,
    this.body,
    this.failure,
    this.success,
    this.sent,
    this.read,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'title': title,
      'body': body,
      'failure': failure,
      'success': success,
      'sent': sent,
      'read': read,
      'data': data?.toMap()
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      failure: int.tryParse(map['failure'].toString()) != null
          ? int.parse(map['failure'].toString())
          : null,
      success: int.tryParse(map['success'].toString()) != null
          ? int.parse(map['success'].toString())
          : null,
      sent: map['sent'] != null ? map['sent'] as bool : null,
      read: map['read'] != null ? map['read'] as bool : null,
      data: map['data'] != null ? NotificationData.fromMap(map['read']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source) as Map<String, dynamic>);

  Notification copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? title,
    String? body,
    int? failure,
    int? success,
    bool? sent,
    bool? read,
    NotificationData? data,
  }) {
    return Notification(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      title: title ?? this.title,
      body: body ?? this.body,
      failure: failure ?? this.failure,
      success: success ?? this.success,
      sent: sent ?? this.sent,
      read: read ?? this.read,
      data: data ?? this.data,
    );
  }

  @override
  String toString() {
    return 'Notification(id: $id, createdTime: $createdTime, updatedTime: $updatedTime, title: $title, body: $body, failure: $failure, success: $success, sent: $sent, read: $read)';
  }

  @override
  bool operator ==(covariant Notification other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdTime == createdTime &&
        other.updatedTime == updatedTime &&
        other.title == title &&
        other.body == body &&
        other.failure == failure &&
        other.success == success &&
        other.sent == sent &&
        other.read == read;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdTime.hashCode ^
        updatedTime.hashCode ^
        title.hashCode ^
        body.hashCode ^
        failure.hashCode ^
        success.hashCode ^
        sent.hashCode ^
        read.hashCode;
  }
}

class NotificationData {
  String? url;
  String? userName;
  bool? isRead;
  NotificationData({
    this.url,
    this.userName,
    this.isRead,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'userName': userName,
      'isRead': isRead,
    };
  }

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      url: map['url'] != null ? map['url'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      isRead: map['isRead'] != null ? map['isRead'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationData.fromJson(String source) =>
      NotificationData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class NotificationAccessor {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? targetType;
  String? notifyId;
  String? receiverId;
  bool? isRead;

  NotifyMessage? message;
  NotificationAccessor({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.targetType,
    this.notifyId,
    this.receiverId,
    this.isRead,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'targetType': targetType,
      'notifyId': notifyId,
      'receiverId': receiverId,
      'isRead': isRead,
      'message': message?.toMap(),
    };
  }

  factory NotificationAccessor.fromMap(Map<String, dynamic> map) {
    return NotificationAccessor(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      targetType:
          map['targetType'] != null ? map['targetType'] as String : null,
      notifyId: map['notifyId'] != null ? map['notifyId'] as String : null,
      receiverId:
          map['receiverId'] != null ? map['receiverId'] as String : null,
      isRead: map['isRead'] != null ? map['isRead'] as bool : null,
      message: map['message'] != null
          ? NotifyMessage.fromMap(map['message'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationAccessor.fromJson(String source) =>
      NotificationAccessor.fromMap(json.decode(source) as Map<String, dynamic>);

  NotificationAccessor copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? targetType,
    String? notifyId,
    String? receiverId,
    bool? isRead,
    NotifyMessage? message,
  }) {
    return NotificationAccessor(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      targetType: targetType ?? this.targetType,
      notifyId: notifyId ?? this.notifyId,
      receiverId: receiverId ?? this.receiverId,
      isRead: isRead ?? this.isRead,
      message: message ?? this.message,
    );
  }
}

class NotifyMessage {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? subject;
  String? content;
  String? templateId;
  String? typeId;
  String? actionType;
  NotifyMessage({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.subject,
    this.content,
    this.templateId,
    this.typeId,
    this.actionType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'subject': subject,
      'content': content,
      'templateId': templateId,
      'typeId': typeId,
      'actionType': actionType,
    };
  }

  factory NotifyMessage.fromMap(Map<String, dynamic> map) {
    return NotifyMessage(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      subject: map['subject'] != null ? map['subject'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      templateId:
          map['templateId'] != null ? map['templateId'] as String : null,
      typeId: map['typeId'] != null ? map['typeId'] as String : null,
      actionType:
          map['actionType'] != null ? map['actionType'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotifyMessage.fromJson(String source) =>
      NotifyMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  NotifyMessage copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? subject,
    String? content,
    String? templateId,
    String? typeId,
    String? actionType,
  }) {
    return NotifyMessage(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      subject: subject ?? this.subject,
      content: content ?? this.content,
      templateId: templateId ?? this.templateId,
      typeId: typeId ?? this.typeId,
      actionType: actionType ?? this.actionType,
    );
  }
}

class UnReadCount {
  String? id;
  int? total;
  UnReadCount({
    this.id,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'total': total,
    };
  }

  factory UnReadCount.fromMap(Map<String, dynamic> map) {
    return UnReadCount(
      id: map['id'] != null ? map['id'] as String : null,
      total: int.tryParse(map['total'].toString()) != null
          ? int.parse(map['total'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UnReadCount.fromJson(String source) =>
      UnReadCount.fromMap(json.decode(source) as Map<String, dynamic>);
}
