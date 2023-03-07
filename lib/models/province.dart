import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class Province {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? display_name;
  String? name;
  String? name_with_type;
  String? region;
  String? slug;
  String? type;
  String? vnp_code;
  Province({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.display_name,
    this.name,
    this.name_with_type,
    this.region,
    this.slug,
    this.type,
    this.vnp_code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'display_name': display_name,
      'name': name,
      'name_with_type': name_with_type,
      'region': region,
      'slug': slug,
      'type': type,
      'vnp_code': vnp_code,
    };
  }

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      display_name:
          map['display_name'] != null ? map['display_name'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      name_with_type: map['name_with_type'] != null
          ? map['name_with_type'] as String
          : null,
      region: map['region'] != null ? map['region'] as String : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      vnp_code: map['vnp_code'] != null ? map['vnp_code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Province.fromJson(String source) =>
      Province.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Distric {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? display_name;
  String? name;
  String? hola_code;
  String? parent_code;
  String? path_unsign;
  String? path;
  String? path_with_type;
  String? short_name;
  String? slug;
  String? type;
  String? vnp_code;
  Distric({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.display_name,
    this.name,
    this.hola_code,
    this.parent_code,
    this.path_unsign,
    this.path,
    this.path_with_type,
    this.short_name,
    this.slug,
    this.type,
    this.vnp_code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'display_name': display_name,
      'name': name,
      'hola_code': hola_code,
      'parent_code': parent_code,
      'path_unsign': path_unsign,
      'path': path,
      'path_with_type': path_with_type,
      'short_name': short_name,
      'slug': slug,
      'type': type,
      'vnp_code': vnp_code,
    };
  }

  factory Distric.fromMap(Map<String, dynamic> map) {
    return Distric(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      display_name:
          map['display_name'] != null ? map['display_name'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      hola_code: map['hola_code'] != null ? map['hola_code'] as String : null,
      parent_code:
          map['parent_code'] != null ? map['parent_code'] as String : null,
      path_unsign:
          map['path_unsign'] != null ? map['path_unsign'] as String : null,
      path: map['path'] != null ? map['path'] as String : null,
      path_with_type: map['path_with_type'] != null
          ? map['path_with_type'] as String
          : null,
      short_name:
          map['short_name'] != null ? map['short_name'] as String : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      vnp_code: map['vnp_code'] != null ? map['vnp_code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Distric.fromJson(String source) =>
      Distric.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Ward {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? abbr;
  String? hola_code;
  String? name;
  String? name_with_type;
  String? parent_code;
  String? path;
  String? path_unsign;
  String? path_with_type;
  String? postal_code;
  String? short_name;
  String? slug;
  String? type;
  String? vnp_code;
  Ward({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.abbr,
    this.hola_code,
    this.name,
    this.name_with_type,
    this.parent_code,
    this.path,
    this.path_unsign,
    this.path_with_type,
    this.postal_code,
    this.short_name,
    this.slug,
    this.type,
    this.vnp_code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'abbr': abbr,
      'hola_code': hola_code,
      'name': name,
      'name_with_type': name_with_type,
      'parent_code': parent_code,
      'path': path,
      'path_unsign': path_unsign,
      'path_with_type': path_with_type,
      'postal_code': postal_code,
      'short_name': short_name,
      'slug': slug,
      'type': type,
      'vnp_code': vnp_code,
    };
  }

  factory Ward.fromMap(Map<String, dynamic> map) {
    return Ward(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      abbr: map['abbr'] != null ? map['abbr'] as String : null,
      hola_code: map['hola_code'] != null ? map['hola_code'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      name_with_type: map['name_with_type'] != null
          ? map['name_with_type'] as String
          : null,
      parent_code:
          map['parent_code'] != null ? map['parent_code'] as String : null,
      path: map['path'] != null ? map['path'] as String : null,
      path_unsign:
          map['path_unsign'] != null ? map['path_unsign'] as String : null,
      path_with_type: map['path_with_type'] != null
          ? map['path_with_type'] as String
          : null,
      postal_code:
          map['postal_code'] != null ? map['postal_code'] as String : null,
      short_name:
          map['short_name'] != null ? map['short_name'] as String : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      vnp_code: map['vnp_code'] != null ? map['vnp_code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ward.fromJson(String source) =>
      Ward.fromMap(json.decode(source) as Map<String, dynamic>);
}
