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
  Project({
    this.id,
    this.project_name,
    this.projectTypeId,
    this.investor,
    this.project_location,
    this.status,
    this.registrationId,
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
  }) {
    return Project(
      id: id ?? this.id,
      project_name: project_name ?? this.project_name,
      projectTypeId: projectTypeId ?? this.projectTypeId,
      investor: investor ?? this.investor,
      project_location: project_location ?? this.project_location,
      status: status ?? this.status,
      registrationId: registrationId ?? this.registrationId,
    );
  }
}
