import 'dart:convert';

class FileUploadModel {
  String? id;
  String? name;
  FileUploadModel({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file_id': id,
      'name': name,
    };
  }

  factory FileUploadModel.fromMap(Map<String, dynamic> map) {
    return FileUploadModel(
      id: map['file_id'] != null ? map['file_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileUploadModel.fromJson(String source) =>
      FileUploadModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
