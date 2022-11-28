// ignore_for_file: non_constant_identifier_names

import 'package:app_cudan/models/reason.dart';

class TransportationCard {
  TransportationCard(
      {this.apartmentId,
      this.card_status,
      this.card_type,
      this.code,
      this.createdTime,
      this.id,
      this.isDraft,
      this.isLocked,
      this.number_plate,
      this.registration_image_back,
      this.registration_image_front,
      this.registration_number,
      this.residentId,
      this.ticket_status,
      this.type,
      this.updatedTime,
      this.vehicleTypeId,
      this.other_image,
      this.cancel_reason,
      this.reasons,
      this.vehicleType});
  String? id;
  String? createdTime;
  String? updatedTime;
  bool? isLocked;
  bool? isDraft;
  String? card_type;
  String? apartmentId;
  String? residentId;
  String? vehicleTypeId;
  String? registration_number;
  String? number_plate;
  String? registration_image_front;
  String? registration_image_back;
  String? type;
  String? ticket_status;
  String? code;
  String? card_status;
  VehicleType? vehicleType;
  List<OtherImage>? other_image;
  Reason? cancel_reason;
  String? note_reason;
  String? reasons;

  TransportationCard.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    isLocked = json['isLocked'];
    isDraft = json['isDraft'];
    card_type = json['card_type'];
    apartmentId = json['apartmentId'];
    residentId = json['residentId'];
    vehicleTypeId = json['vehicleTypeId'];
    registration_number = json['registration_number'];
    number_plate = json['number_plate'];
    registration_image_front = json['registration_image_front'];
    registration_image_back = json['registration_image_back'];
    type = json['type'];
    ticket_status = json['ticket_status'];
    code = json['code'];
    card_status = json['card_status'];
    note_reason = json['note_reason'];
    reasons = json['reasons'];
    // ignore: prefer_null_aware_operators
    other_image = json['other_image'] != null
        ? json['other_image'].length != 0
            ? json['other_image']
                .map<OtherImage>((e) => OtherImage.fromJson(e))
                .toList()
            : null
        : null;
    vehicleType = json['vehicleType'] != null
        ? VehicleType.fromJson(json['vehicleType'])
        : null;
    cancel_reason = json['cancel_reason'] != null
        ? json['cancel_reason'].isNotEmpty
            ? Reason.fromJson(json['cancel_reason'][0])
            : null
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    // data['isLocked'] = isLocked ?? false;
    data['isDraft'] = isDraft ?? false;
    data['card_type'] = card_type;
    data['apartmentId'] = apartmentId;
    data['residentId'] = residentId;
    data['vehicleTypeId'] = vehicleTypeId;
    data['registration_number'] = registration_number;
    data['number_plate'] = number_plate;
    data['registration_image_front'] = registration_image_front;
    data['registration_image_back'] = registration_image_back;
    data['type'] = type;
    data['ticket_status'] = ticket_status;
    data['code'] = code;
    data['reasons'] = reasons;
    data['card_status'] = card_status;
    data['other_image'] =
        other_image != null ? [...other_image!.map((e) => e.toJson())] : null;
    // data['vehicleType'] = vehicleType != null ? vehicleType!.toJson() : null;
    return data;
  }
}

class VehicleType {
  VehicleType({
    this.code,
    this.createdTime,
    this.id,
    this.isDraft,
    this.name,
    this.updatedTime,
  });

  String? id;
  String? createdTime;
  String? updatedTime;
  bool? isDraft;
  String? code;
  String? name;

  VehicleType.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    isDraft = json['isDraft'];
    code = json['code'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['isDraft'] = isDraft;
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}

class OtherImage {
  String? id;
  String? name;

  OtherImage({this.id, this.name});
  OtherImage.fromJson(Map<String, dynamic> json) {
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
