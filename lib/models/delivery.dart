// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'reason.dart';
import 'resident_info.dart';
import 'response_resident_own.dart';
import 'status.dart';

class Delivery {
  Delivery({
    this.id,
    this.apartmentId,
    this.code,
    this.createdTime,
    this.end_time,
    this.help_check,
    this.item_added_list,
    this.note_reason,
    this.phone_number,
    this.reasons,
    this.residentId,
    this.start_time,
    this.status,
    this.type_transfer,
    this.updatedTime,
    this.image,
    this.end_hour,
    this.elevator,
    this.isMobile,
    this.s,
    this.start_hour,
    this.re,
    this.describe,
    this.a,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? apartmentId;
  String? residentId;
  String? phone_number;
  String? type_transfer;
  String? start_time;
  String? end_time;
  String? start_hour;
  String? end_hour;
  String? code;
  String? reasons;
  String? note_reason;
  String? describe;
  String? status;
  Status? s;
  bool? help_check;
  bool? elevator;
  bool? isMobile;
  ResponseResidentInfo? re;
  Reason? r;
  Apartment? a;
  List<ItemDeliver>? item_added_list;
  List<ImageDelivery>? image;
  Delivery.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    apartmentId = json['apartmentId'];
    residentId = json['residentId'];
    phone_number = json['phone_number'];
    describe = json['describe'];
    type_transfer = json['type_transfer'];
    start_time = json['start_time'];
    end_time = json['end_time'];
    start_hour = json['start_hour'];
    end_hour = json['end_hour'];
    code = json['code'];
    s = json['s'] != null ? Status.fromJson(json['s']) : null;
    reasons = json['reasons'];
    note_reason = json['note_reason'];
    status = json['status'];
    help_check = json['help_check'];
    elevator = json['elevator'];
    isMobile = json['isMobile'] ?? false;
    image = json['image'] != null
        ? json['image'].length != 0
            ? json['image']
                .map<ImageDelivery>((e) => ImageDelivery.fromJson(e))
                .toList()
            : []
        : [];
    item_added_list = json['item_added_list'] != null
        ? json['item_added_list'].length != 0
            ? json['item_added_list']
                .map<ItemDeliver>((e) => ItemDeliver.fromJson(e))
                .toList()
            : []
        : [];
    re = json['re'] != null ? ResponseResidentInfo.fromJson(json['re']) : null;
    r = json['r'] != null ? Reason.fromJson(json['r']) : null;
    a = json['a'] != null ? Apartment.fromJson(json['a']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['residentId'] = residentId;
    data['apartmentId'] = apartmentId;
    data['phone_number'] = phone_number;
    data['type_transfer'] = type_transfer;
    data['start_time'] = start_time;
    data['start_hour'] = start_hour;
    data['end_hour'] = end_hour;
    data['describe'] = describe;
    data['end_time'] = end_time;
    data['code'] = code;
    data['reasons'] = reasons;
    data['note_reason'] = note_reason;
    data['status'] = status;
    data['isMobile'] = isMobile;
    data['help_check'] = help_check;
    data['elevator'] = elevator;
    data['image'] = image != null ? [...image!.map((e) => e.toJson())] : [];
    data['item_added_list'] = item_added_list != null
        ? [...item_added_list!.map((e) => e.toJson())]
        : [];
    return data;
  }

  Delivery copyWith({
    String? id,
    String? name,
    String? apartmentId,
    String? createdTime,
    String? updatedTime,
    String? residentId,
    String? phone_number,
    String? type_transfer,
    String? start_time,
    String? end_time,
    String? start_hour,
    String? end_hour,
    String? code,
    String? reasons,
    String? note_reason,
    String? describe,
    String? status,
    Status? s,
    bool? help_check,
    bool? elevator,
    bool? isMobile,
    List<ItemDeliver>? item_added_list,
    List<ImageDelivery>? image,
  }) {
    return Delivery(
      id: id ?? this.id,
      apartmentId: apartmentId ?? this.apartmentId,
      code: code ?? this.code,
      createdTime: createdTime ?? this.createdTime,
      end_time: end_time ?? this.end_time,
      help_check: help_check ?? this.help_check,
      item_added_list: item_added_list ?? this.item_added_list,
      note_reason: note_reason ?? this.note_reason,
      phone_number: phone_number ?? this.phone_number,
      reasons: reasons ?? this.reasons,
      residentId: residentId ?? this.residentId,
      start_time: start_time ?? this.start_time,
      status: status ?? this.status,
      type_transfer: type_transfer ?? this.type_transfer,
      updatedTime: updatedTime ?? this.updatedTime,
      image: image ?? this.image,
      end_hour: end_hour ?? this.end_hour,
      elevator: elevator ?? this.elevator,
      isMobile: isMobile ?? this.isMobile,
      start_hour: start_hour ?? this.start_hour,
      describe: describe ?? this.describe,
    );
  }
}

class ItemDeliver {
  ItemDeliver({
    this.createdTime,
    this.dimension,
    this.item_name,
    this.updatedTime,
    this.weight,
    this.color,
    this.amount,
    this.describe,
  });
  String? createdTime;
  String? updatedTime;
  String? item_name;
  String? dimension;
  double? weight;
  String? describe;
  String? color;
  int? amount;
  ItemDeliver.fromJson(Map<String, dynamic> json) {
    createdTime = json['createdTime'];
    dimension = json['dimension'];
    item_name = json['item_name'];
    updatedTime = json['updatedTime'];
    color = json['color'];
    describe = json['describe'];

    weight = double.tryParse(json['weight'].toString()) != null
        ? double.parse(json['weight'].toString())
        : null;
    amount = int.tryParse(json['amount'].toString()) != null
        ? int.parse(json['amount'].toString())
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdTime'] = createdTime;
    data['dimension'] = dimension;
    data['item_name'] = item_name;
    data['updatedTime'] = updatedTime;
    data['weight'] = weight;
    data['amount'] = amount;
    data['color'] = color;
    data['describe'] = describe;

    return data;
  }
}

class ImageDelivery {
  String? id;
  String? name;

  ImageDelivery({this.id, this.name});
  ImageDelivery.fromJson(Map<String, dynamic> json) {
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
