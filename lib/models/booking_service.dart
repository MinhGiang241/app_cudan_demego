// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_cudan/models/file_upload.dart';

class BoookingService {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? status;
  String? name;
  String? registration_type;
  String? object;
  bool? isLimitedDaysRegistration;
  int? limited_days_registration_num;
  bool? isCancelInAdvance;
  int? cancel_in_advance_num;
  String? ticket_type;
  String? reminder_in_advance;
  List<FileUploadModel>? terms_of_service;
  List<FileUploadModel>? rules;
  List<ServiceArea>? list_of_service_areas;
  List<HourOperationPerDay>? list_hours_of_operation_per_day;
  List<FeeByTurn>? list_of_fees_by_turn;
  List<FeeByMonth>? list_of_fees_by_month;
  bool? confirm_use;
  String? icon;
  BoookingService({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.status,
    this.name,
    this.registration_type,
    this.object,
    this.isLimitedDaysRegistration,
    this.limited_days_registration_num,
    this.isCancelInAdvance,
    this.cancel_in_advance_num,
    this.ticket_type,
    this.reminder_in_advance,
    this.terms_of_service,
    this.rules,
    this.list_of_service_areas,
    this.list_hours_of_operation_per_day,
    this.list_of_fees_by_turn,
    this.list_of_fees_by_month,
    this.confirm_use,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'status': status,
      'name': name,
      'registration_type': registration_type,
      'object': object,
      'isLimitedDaysRegistration': isLimitedDaysRegistration,
      'limited_days_registration_num': limited_days_registration_num,
      'isCancelInAdvance': isCancelInAdvance,
      'cancel_in_advance_num': cancel_in_advance_num,
      'ticket_type': ticket_type,
      'reminder_in_advance': reminder_in_advance,
      'terms_of_service': terms_of_service?.map((x) => x.toMap()).toList(),
      'rules': rules?.map((x) => x.toMap()).toList(),
      'list_of_service_areas':
          list_of_service_areas?.map((x) => x.toMap()).toList(),
      'list_hours_of_operation_per_day':
          list_hours_of_operation_per_day?.map((x) => x.toMap()).toList(),
      'list_of_fees_by_turn':
          list_of_fees_by_turn?.map((x) => x.toMap()).toList(),
      'list_of_fees_by_month':
          list_of_fees_by_month?.map((x) => x.toMap()).toList(),
      'confirm_use': confirm_use,
      'icon': icon,
    };
  }

  factory BoookingService.fromMap(Map<String, dynamic> map) {
    return BoookingService(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      registration_type: map['registration_type'] != null
          ? map['registration_type'] as String
          : null,
      object: map['object'] != null ? map['object'] as String : null,
      isLimitedDaysRegistration: map['isLimitedDaysRegistration'] != null
          ? map['isLimitedDaysRegistration'] as bool
          : null,
      limited_days_registration_num:
          map['limited_days_registration_num'] != null
              ? map['limited_days_registration_num'] as int
              : null,
      isCancelInAdvance: map['isCancelInAdvance'] != null
          ? map['isCancelInAdvance'] as bool
          : null,
      cancel_in_advance_num: map['cancel_in_advance_num'] != null
          ? map['cancel_in_advance_num'] as int
          : null,
      ticket_type:
          map['ticket_type'] != null ? map['ticket_type'] as String : null,
      reminder_in_advance: map['reminder_in_advance'] != null
          ? map['reminder_in_advance'] as String
          : null,
      terms_of_service: map['terms_of_service'] != null
          ? List<FileUploadModel>.from(
              (map['terms_of_service'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      rules: map['rules'] != null
          ? List<FileUploadModel>.from(
              (map['rules'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      list_of_service_areas: map['list_of_service_areas'] != null
          ? List<ServiceArea>.from(
              (map['list_of_service_areas'] as List<dynamic>).map<ServiceArea?>(
                (x) => ServiceArea.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      list_hours_of_operation_per_day: map['list_hours_of_operation_per_day'] !=
              null
          ? List<HourOperationPerDay>.from(
              (map['list_hours_of_operation_per_day'] as List<dynamic>)
                  .map<HourOperationPerDay?>(
                (x) => HourOperationPerDay.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      list_of_fees_by_turn: map['list_of_fees_by_turn'] != null
          ? List<FeeByTurn>.from(
              (map['list_of_fees_by_turn'] as List<dynamic>).map<FeeByTurn?>(
                (x) => FeeByTurn.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      list_of_fees_by_month: map['list_of_fees_by_month'] != null
          ? List<FeeByMonth>.from(
              (map['list_of_fees_by_month'] as List<dynamic>).map<FeeByMonth?>(
                (x) => FeeByMonth.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
      confirm_use:
          map['confirm_use'] != null ? map['confirm_use'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BoookingService.fromJson(String source) =>
      BoookingService.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ServiceArea {
  String? areaId;
  int? ticket_per_hour;
  int? ticket_person_per_hour;
  ServiceArea({
    this.areaId,
    this.ticket_per_hour,
    this.ticket_person_per_hour,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'areaId': areaId,
      'ticket_per_hour': ticket_per_hour,
      'ticket_person_per_hour': ticket_person_per_hour,
    };
  }

  factory ServiceArea.fromMap(Map<String, dynamic> map) {
    return ServiceArea(
      areaId: map['areaId'] != null ? map['areaId'] as String : null,
      ticket_per_hour: int.tryParse(map['ticket_per_hour'].toString()) != null
          ? int.parse(map['ticket_per_hour'].toString())
          : null,
      ticket_person_per_hour:
          int.tryParse(map['ticket_person_per_hour'].toString()) != null
              ? int.parse(map['ticket_person_per_hour'].toString())
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceArea.fromJson(String source) =>
      ServiceArea.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HourOperationPerDay {
  String? time_start;
  String? time_end;
  String? time_view;
  double? time_num;
  HourOperationPerDay({
    this.time_start,
    this.time_end,
    this.time_view,
    this.time_num,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time_start': time_start,
      'time_end': time_end,
      'time_view': time_view,
      'time_num': time_num,
    };
  }

  factory HourOperationPerDay.fromMap(Map<String, dynamic> map) {
    return HourOperationPerDay(
      time_start:
          map['time_start'] != null ? map['time_start'] as String : null,
      time_end: map['time_end'] != null ? map['time_end'] as String : null,
      time_view: map['time_view'] != null ? map['time_view'] as String : null,
      time_num: double.tryParse(map['time_num'].toString()) != null
          ? double.parse(map['time_num'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HourOperationPerDay.fromJson(String source) =>
      HourOperationPerDay.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FeeByTurn {
  String? object;
  double? price;
  double? price_child;
  double? price_adult;
  double? price_weekend;
  double? price_child_weekend;
  double? price_adult_weekend;
  FeeByTurn({
    this.object,
    this.price,
    this.price_child,
    this.price_adult,
    this.price_weekend,
    this.price_child_weekend,
    this.price_adult_weekend,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'price': price,
      'price_child': price_child,
      'price_adult': price_adult,
      'price_weekend': price_weekend,
      'price_child_weekend': price_child_weekend,
      'price_adult_weekend': price_adult_weekend,
    };
  }

  factory FeeByTurn.fromMap(Map<String, dynamic> map) {
    return FeeByTurn(
      object: map['object'] != null ? map['object'] as String : null,
      price: double.tryParse(map['price'].toString()) != null
          ? double.parse(map['price'].toString())
          : null,
      price_child: double.tryParse(map['price_child'].toString()) != null
          ? double.parse(map['price_child'].toString())
          : null,
      price_adult: double.tryParse(map['price_adult'].toString()) != null
          ? double.parse(map['price_adult'].toString())
          : null,
      price_weekend: double.tryParse(map['price_weekend'].toString()) != null
          ? double.parse(map['price_weekend'].toString())
          : null,
      price_child_weekend:
          double.tryParse(map['price_child_weekend'].toString()) != null
              ? double.parse(map['price_child_weekend'].toString())
              : null,
      price_adult_weekend:
          double.tryParse(map['price_adult_weekend'].toString()) != null
              ? double.parse(map['price_adult_weekend'].toString())
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeeByTurn.fromJson(String source) =>
      FeeByTurn.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FeeByMonth {
  String? shelfLifeId;
  double? price_resident;
  double? price_guest;
  FeeByMonth({
    this.shelfLifeId,
    this.price_resident,
    this.price_guest,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shelfLifeId': shelfLifeId,
      'price_resident': price_resident,
      'price_guest': price_guest,
    };
  }

  factory FeeByMonth.fromMap(Map<String, dynamic> map) {
    return FeeByMonth(
      shelfLifeId:
          map['shelfLifeId'] != null ? map['shelfLifeId'] as String : null,
      price_resident: double.tryParse(map['price_resident'].toString()) != null
          ? double.parse(map['price_resident'].toString())
          : null,
      price_guest: double.tryParse(map['price_guest'].toString()) != null
          ? double.parse(map['price_guest'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeeByMonth.fromJson(String source) =>
      FeeByMonth.fromMap(json.decode(source) as Map<String, dynamic>);
}
