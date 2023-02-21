import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file= public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names
// ignore_for_file= non_constant_identifier_names

class HandOver {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? residentId;
  String? buildingId;
  String? apartmentId;
  String? delivery_time;
  String? handover_code;
  bool? checkbox;
  String? status;
  String? note;
  String? reason;
  String? employeeId;
  String? result;
  String? apartment_construction_reality;
  String? apartment_area_reality;
  String? apartment_construction;
  String? appointment_time;
  String? name;
  String? phone;
  String? permanent_address;
  String? contract_name;
  String? apartment_type;
  String? identity;
  HandOverStatus? s;
  List<Category>? category_list;
  List<Category>? category_list_ver2;
  List<Category>? category_list_clone;
  FileHandOver? img;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'residentId': residentId,
      'buildingId': buildingId,
      'apartmentId': apartmentId,
      'delivery_time': delivery_time,
      'handover_code': handover_code,
      'checkbox': checkbox,
      'status': status,
      'note': note,
      'reason': reason,
      'employeeId': employeeId,
      'result': result,
      'apartment_construction_reality': apartment_construction_reality,
      'apartment_area_reality': apartment_area_reality,
      'apartment_construction': apartment_construction,
      'appointment_time': appointment_time,
      'name': name,
      'phone': phone,
      'permanent_address': permanent_address,
      'contract_name': contract_name,
      'apartment_type': apartment_type,
      'identity': identity,
      'category_list': category_list!.map((x) => x.toJson()).toList(),
      'category_list_ver2': category_list_ver2!.map((x) => x.toJson()).toList(),
      'category_list_clone':
          category_list_clone!.map((x) => x.toJson()).toList(),
      'img': img?.toJson(),
    };
  }

  HandOver.fromJson(Map<String, dynamic> map) {
    id = map['_id'];
    createdTime = map['createdTime'];
    updatedTime = map['updatedTime'];
    residentId = map['residentId'];
    buildingId = map['buildingId'];
    apartmentId = map['apartmentId'];
    delivery_time = map['delivery_time'];
    handover_code = map['handover_code'];
    checkbox = map['checkbox'];
    status = map['status'];
    note = map['note'];
    reason = map['reason'];
    employeeId = map['employeeId'];
    result = map['result'];
    apartment_construction_reality = map['apartment_construction_reality'];
    apartment_area_reality = map['apartment_area_reality'];
    apartment_construction = map['apartment_construction'];
    appointment_time = map['appointment_time'];
    name = map['name'];
    phone = map['phone'];
    permanent_address = map['permanent_address'];
    contract_name = map['contract_name'];
    apartment_type = map['apartment_type'];
    identity = map['identity'];
    s = map['s'] != null ? HandOverStatus.fromJson(map['s']) : null;
    category_list = map['category_list'] != null
        ? map['category_list'].isNotEmpty
            ? map['category_list']
                .map<Category>((e) => Category.fromJson(e))
                .toList()
            : []
        : [];
    category_list_ver2 = map['category_list_ver2'] != null
        ? map['category_list_ver2'].isNotEmpty
            ? map['category_list_ver2']
                .map<Category>((e) => Category.fromJson(e))
                .toList()
            : []
        : [];
    category_list_clone = map['category_list_clone'] != null
        ? map['category_list_clone'].isNotEmpty
            ? map['category_list_clone']
                .map<Category>((e) => Category.fromJson(e))
                .toList()
            : []
        : [];
    img = map['img'] != null
        ? FileHandOver.fromJson(map['img'] as Map<String, dynamic>)
        : null;
  }
}

class FileHandOver {
  String? id;
  String? name;
  FileHandOver.fromJson(Map<String, dynamic> json) {
    id = json['file_id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_id'] = id;
    data['name'] = name;
    return data;
  }
}

class Category {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? name;
  String? placement;
  String? material;
  String? quantity;
  String? note;
  int? actual_amount;
  FileHandOver? image;
  bool? achieve;
  bool? not_achieve;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'name': name,
      'placement': placement,
      'material': material,
      'quantity': quantity,
      'note': note,
      'actual_amount': actual_amount,
      'image': image?.toJson(),
      'achieve': achieve,
      'not_achieve': not_achieve,
    };
  }

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    name = json['name'];
    placement = json['placement'];
    material = json['material'];
    quantity = json['quantity'];
    note = json['note'];
    actual_amount = json['actual_amount'];
    image = json['image'] != null
        ? FileHandOver.fromJson(json['image'] as Map<String, dynamic>)
        : null;
    achieve = json['achieve'];
    not_achieve = json['not_achieve'];
  }
}

class HandOverStatus {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? name;
  String? code;
  int? order;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'name': name,
      'code': code,
      'order': order,
    };
  }

  HandOverStatus.fromJson(Map<String, dynamic> map) {
    id = map['_id'];
    createdTime = map['createdTime'];
    updatedTime = map['updatedTime'];
    name = map['name'];
    code = map['code'];
    order = int.tryParse(map['order'].toString()) != null
        ? int.parse(map['order'].toString())
        : null;
  }
}
