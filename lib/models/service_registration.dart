// ignore_for_file: non_constant_identifier_names

import 'extra_service.dart';
import 'reason.dart';
import 'resident_info.dart';
import 'response_resident_own.dart';

class ServiceRegistration {
  ServiceRegistration({
    this.apartmentId,
    this.arisingServiceId,
    this.code,
    this.createdTime,
    this.expiration_date,
    this.id,
    this.paymentCycle,
    this.people,
    this.phoneNumber,
    this.registration_date,
    this.residentId,
    this.status,
    this.updatedTime,
    this.pay,
    this.floor,
    this.building,
    this.isMobile,
    this.cancel_note,
    this.apartment,
    this.cancel_reason,
    this.resident,
    this.cancel_reasons,
    this.maximum_day,
    this.note,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? people;
  String? apartmentId;
  String? residentId;
  String? phoneNumber;
  String? arisingServiceId;
  String? paymentCycle;
  String? registration_date;
  String? expiration_date;
  String? status;
  String? code;
  String? note;
  String? cancel_note;
  String? cancel_reason;
  Reason? cancel_reasons;
  Pay? pay;
  bool? isMobile;
  Apartment? apartment;
  Floor? floor;
  int? maximum_day;
  Building? building;
  ResponseResidentInfo? resident;

  ServiceRegistration.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    people = json['people'];
    apartmentId = json['apartmentId'];
    residentId = json['residentId'];
    phoneNumber = json['phoneNumber'];
    arisingServiceId = json['arisingServiceId'];
    paymentCycle = json['paymentCycle'];
    registration_date = json['registration_date'];
    expiration_date = json['expiration_date'];
    status = json['status'];
    note = json['note'];
    isMobile = json['isMobile'];
    maximum_day = json['maximum_day'];
    cancel_note = json['cancel_note'];
    cancel_reason = json['cancel_reason'];
    cancel_reasons = json['cancel_reasons'] != null
        ? json['cancel_reasons'].isNotEmpty
            ? Reason.fromJson(json['cancel_reasons'][0])
            : null
        : null;
    building =
        json['building'] != null ? Building.fromJson(json['building']) : null;
    floor = json['floor'] != null ? Floor.fromJson(json['floor']) : null;
    resident = json['resident'] != null
        ? ResponseResidentInfo.fromJson(json['resident'])
        : null;
    apartment = json['apartment'] != null
        ? Apartment.fromJson(json['apartment'])
        : null;
    pay = Pay.fromJson(json['pay']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['code'] = code;
    data['people'] = people;
    data['apartmentId'] = apartmentId;
    data['residentId'] = residentId;
    data['phoneNumber'] = phoneNumber;
    data['arisingServiceId'] = arisingServiceId;
    data['paymentCycle'] = paymentCycle;
    data['registration_date'] = registration_date;
    data['expiration_date'] = expiration_date;
    data['status'] = status;
    data['isMobile'] = isMobile;
    data['maximum_day'] = maximum_day;
    data['cancel_note'] = cancel_note;
    data['note'] = note;
    data['cancel_reason'] = cancel_reason;
    // data['pay'] = pay != null ? pay!.toJson() : null;
    return data;
  }
}
