// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_cudan/models/file_upload.dart';

class WorkArising {
  String? id;
  String? createdTime;
  String? updatedTime;
  List<TodoResults>? to_do_list_result;
  WorkArising({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.to_do_list_result,
  });

  WorkArising copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    List<TodoResults>? to_do_list_result,
  }) {
    return WorkArising(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      to_do_list_result: to_do_list_result ?? this.to_do_list_result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'to_do_list_result': to_do_list_result?.map((x) => x.toMap()).toList(),
    };
  }

  factory WorkArising.fromMap(Map<String, dynamic> map) {
    return WorkArising(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      to_do_list_result: map['to_do_list_result'] != null
          ? List<TodoResults>.from(
              (map['to_do_list_result'] as List<dynamic>).map<TodoResults?>(
                (x) => TodoResults.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkArising.fromJson(String source) =>
      WorkArising.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TodoResults {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? start_work;
  String? work_content;
  String? result;
  List<FileUploadModel>? file;
  TodoResults({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.start_work,
    this.work_content,
    this.result,
    this.file,
  });

  TodoResults copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? start_work,
    String? work_content,
    String? result,
    List<FileUploadModel>? file,
  }) {
    return TodoResults(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      start_work: start_work ?? this.start_work,
      work_content: work_content ?? this.work_content,
      result: result ?? this.result,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'start_work': start_work,
      'work_content': work_content,
      'result': result,
      'file': file?.map((x) => x.toMap()).toList(),
    };
  }

  factory TodoResults.fromMap(Map<String, dynamic> map) {
    return TodoResults(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      start_work:
          map['start_work'] != null ? map['start_work'] as String : null,
      work_content:
          map['work_content'] != null ? map['work_content'] as String : null,
      result: map['result'] != null ? map['result'] as String : null,
      file: map['file'] != null
          ? List<FileUploadModel>.from(
              (map['file'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoResults.fromJson(String source) =>
      TodoResults.fromMap(json.decode(source) as Map<String, dynamic>);
}
