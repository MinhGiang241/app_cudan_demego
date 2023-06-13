import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SessionChatSubject {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? sessionId;
  String? subjectId;
  SessionChatSubject({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.sessionId,
    this.subjectId,
  });

  SessionChatSubject copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? sessionId,
    String? subjectId,
  }) {
    return SessionChatSubject(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      sessionId: sessionId ?? this.sessionId,
      subjectId: subjectId ?? this.subjectId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'sessionId': sessionId,
      'subjectId': subjectId,
    };
  }

  factory SessionChatSubject.fromMap(Map<String, dynamic> map) {
    return SessionChatSubject(
      id: map['_id'] != null ? map['id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      sessionId: map['sessionId'] != null ? map['sessionId'] as String : null,
      subjectId: map['subjectId'] != null ? map['subjectId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionChatSubject.fromJson(String source) =>
      SessionChatSubject.fromMap(json.decode(source) as Map<String, dynamic>);
}
