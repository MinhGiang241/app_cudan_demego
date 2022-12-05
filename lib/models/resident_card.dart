// ignore_for_file: non_constant_identifier_names

import 'reason.dart';
import 'resident_info.dart';
import 'response_resident_own.dart';

class ResidentCard {
  ResidentCard(
      {this.apartmentId,
      this.card_status,
      this.code,
      this.createdTime,
      this.id,
      this.identity_image_back,
      this.identity_image_front,
      this.note_reason,
      this.other_image,
      this.reasons,
      this.residentId,
      this.ticket_status,
      this.updatedTime,
      this.resident_image,
      this.cancel_reason,
      this.isMobile,
      this.apartment});
  String? id;
  String? createdTime;
  String? updatedTime;
  String? apartmentId;
  String? residentId;
  String? identity_image_front;
  String? identity_image_back;
  String? other_image;
  String? code;
  String? card_status;
  String? ticket_status;
  String? reasons;
  String? note_reason;
  String? resident_image;
  bool? isMobile;
  Apartment? apartment;
  Building? building;
  Floor? floor;
  ResponseResidentInfo? resident;
  Reason? cancel_reason;

  ResidentCard.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    apartmentId = json['apartmentId'];
    residentId = json['residentId'];
    identity_image_front = json['identity_image_front'];
    identity_image_back = json['identity_image_back'];
    other_image = json['other_image'];
    code = json['code'];
    card_status = json['card_status'];
    ticket_status = json['ticket_status'];
    reasons = json['reasons'];
    resident_image = json['resident_image'];
    note_reason = json['note_reason'];
    isMobile = json['isMobile'];
    apartment = Apartment.fromJson(json['apartment']);
    building = Building.fromJson(json['building']);
    floor = Floor.fromJson(json['floor']);
    resident = json['resident'] != null
        ? ResponseResidentInfo.fromJson(json['resident'])
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
    data['residentId'] = residentId;
    data['apartmentId'] = apartmentId;
    data['code'] = code;
    data['reasons'] = reasons;
    data['note_reason'] = note_reason;
    data['identity_image_front'] = identity_image_front;
    data['identity_image_back'] = identity_image_back;
    data['other_image'] = other_image;
    data['card_status'] = card_status;
    data['ticket_status'] = ticket_status;
    data['resident_image'] = resident_image;
    data['isMobile'] = isMobile;

    return data;
  }
}
