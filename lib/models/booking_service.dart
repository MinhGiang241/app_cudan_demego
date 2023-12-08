// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_cudan/models/file_upload.dart';
import 'package:app_cudan/models/transportation_card.dart';

import 'area.dart';

class BookingService {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? status;
  String? name;
  String? registration_type;
  String? object;
  String? service_charge;
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
  String? note;
  BookingService({
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
    this.service_charge,
    this.note,
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
      'service_charge': service_charge,
      'note': note,
    };
  }

  factory BookingService.fromMap(Map<String, dynamic> map) {
    return BookingService(
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
      note: map['note'] != null ? map['note'] as String : null,
      service_charge: map['service_charge'] != null
          ? map['service_charge'] as String
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

  factory BookingService.fromJson(String source) =>
      BookingService.fromMap(json.decode(source) as Map<String, dynamic>);
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
  ShelfLife? shelfLife;
  FeeByMonth({
    this.shelfLifeId,
    this.price_resident,
    this.price_guest,
    this.shelfLife,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shelfLifeId': shelfLifeId,
      'price_resident': price_resident,
      'price_guest': price_guest,
      'shelfLife': shelfLife?.toMap(),
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
      shelfLife: map['shelfLife'] != null
          ? ShelfLife.fromMap(map['shelfLife'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeeByMonth.fromJson(String source) =>
      FeeByMonth.fromMap(json.decode(source) as Map<String, dynamic>);
}

class RegisterBookingService {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? apartmentId;
  String? code;
  String? residentId;
  String? phone_number;
  String? address;
  String? person;
  String? serviceConfigurationId;
  String? use_date;
  String? time_slot;
  List<BookingInfo>? booking_info;
  bool? agree_to_terms_of_service;
  String? note;
  String? object;
  String? registration_type;
  String? ticket_type;
  String? status;
  String? payment_status;
  bool? confirm_use;
  String? fee;
  List<FileUploadModel>? rules;
  List<FileUploadModel>? terms_of_service;
  String? shelfLifeId;
  String? end_date;
  double? total_price;
  String? reason_refused_to_cancel;
  int? total_num_ticket;
  String? filter_fee;
  String? areaId;
  String? receipts_code;
  Area? a;
  ShelfLife? sh;
  BookingService? se;

  RegisterBookingService({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.apartmentId,
    this.code,
    this.residentId,
    this.phone_number,
    this.address,
    this.person,
    this.serviceConfigurationId,
    this.use_date,
    this.time_slot,
    this.booking_info,
    this.agree_to_terms_of_service,
    this.note,
    this.object,
    this.registration_type,
    this.ticket_type,
    this.status,
    this.payment_status,
    this.confirm_use,
    this.fee,
    this.rules,
    this.terms_of_service,
    this.shelfLifeId,
    this.end_date,
    this.areaId,
    this.total_price,
    this.reason_refused_to_cancel,
    this.total_num_ticket,
    this.filter_fee,
    this.receipts_code,
    this.se,
    this.sh,
    this.a,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'apartmentId': apartmentId,
      'code': code,
      'residentId': residentId,
      'phone_number': phone_number,
      'address': address,
      'person': person,
      'serviceConfigurationId': serviceConfigurationId,
      'use_date': use_date,
      'time_slot': time_slot,
      'booking_info': booking_info?.map((c) => c.toMap()).toList(),
      'agree_to_terms_of_service': agree_to_terms_of_service,
      'note': note,
      'object': object,
      'registration_type': registration_type,
      'ticket_type': ticket_type,
      'status': status,
      'payment_status': payment_status,
      'confirm_use': confirm_use,
      'fee': fee,
      'rules': rules?.map((x) => x.toMap()).toList(),
      'terms_of_service': terms_of_service?.map((x) => x.toMap()).toList(),
      'shelfLifeId': shelfLifeId,
      'end_date': end_date,
      'total_price': total_price,
      'reason_refused_to_cancel': reason_refused_to_cancel,
      'total_num_ticket': total_num_ticket,
      'filter_fee': filter_fee,
      'receipts_code': receipts_code,
      'areaId': areaId,
    };
  }

  factory RegisterBookingService.fromMap(Map<String, dynamic> map) {
    return RegisterBookingService(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      phone_number:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      person: map['person'] != null ? map['person'] as String : null,
      serviceConfigurationId: map['serviceConfigurationId'] != null
          ? map['serviceConfigurationId'] as String
          : null,
      use_date: map['use_date'] != null ? map['use_date'] as String : null,
      time_slot: map['time_slot'] != null ? map['time_slot'] as String : null,
      booking_info: map['booking_info'] != null
          ? List<BookingInfo>.from(
              (map['booking_info'] as List<dynamic>).map<BookingInfo?>(
                (x) => BookingInfo.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      agree_to_terms_of_service: map['agree_to_terms_of_service'] != null
          ? map['agree_to_terms_of_service'] as bool
          : null,
      note: map['note'] != null ? map['note'] as String : null,
      object: map['object'] != null ? map['object'] as String : null,
      registration_type: map['registration_type'] != null
          ? map['registration_type'] as String
          : null,
      ticket_type:
          map['ticket_type'] != null ? map['ticket_type'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      payment_status: map['payment_status'] != null
          ? map['payment_status'] as String
          : null,
      confirm_use:
          map['confirm_use'] != null ? map['confirm_use'] as bool : null,
      fee: map['fee'] != null ? map['fee'] as String : null,
      rules: map['rules'] != null
          ? List<FileUploadModel>.from(
              (map['rules'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      terms_of_service: map['terms_of_service'] != null
          ? List<FileUploadModel>.from(
              (map['terms_of_service'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      shelfLifeId:
          map['shelfLifeId'] != null ? map['shelfLifeId'] as String : null,
      end_date: map['end_date'] != null ? map['end_date'] as String : null,
      total_price: double.tryParse(map['total_price'].toString()) != null
          ? double.parse(map['total_price'].toString())
          : null,
      reason_refused_to_cancel: map['reason_refused_to_cancel'] != null
          ? map['reason_refused_to_cancel'] as String
          : null,
      total_num_ticket: int.tryParse(map['total_num_ticket'].toString()) != null
          ? int.parse(map['total_num_ticket'].toString())
          : null,
      filter_fee:
          map['filter_fee'] != null ? map['filter_fee'] as String : null,
      areaId: map['areaId'] != null ? map['areaId'] as String : null,
      receipts_code:
          map['receipts_code'] != null ? map['receipts_code'] as String : null,
      a: map['a'] != null ? Area.fromMap(map['a']) : null,
      sh: map['sh'] != null ? ShelfLife.fromMap(map['sh']) : null,
      se: map['se'] != null ? BookingService.fromMap(map['se']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterBookingService.fromJson(String source) =>
      RegisterBookingService.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  RegisterBookingService copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? apartmentId,
    String? code,
    String? residentId,
    String? phone_number,
    String? address,
    String? person,
    String? serviceConfigurationId,
    String? use_date,
    String? time_slot,
    List<BookingInfo>? booking_info,
    bool? agree_to_terms_of_servicereaId,
    String? note,
    String? object,
    String? registration_type,
    String? ticket_type,
    String? status,
    String? payment_status,
    bool? confirm_use,
    String? fee,
    List<FileUploadModel>? rules,
    List<FileUploadModel>? terms_of_service,
    String? shelfLifeId,
    String? end_date,
    double? total_price,
    String? reason_refused_to_cancel,
    int? total_num_ticket,
    String? filter_fee,
    String? receipts_code,
    String? areaId,
  }) {
    return RegisterBookingService(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      apartmentId: apartmentId ?? this.apartmentId,
      code: code ?? this.code,
      residentId: residentId ?? this.residentId,
      phone_number: phone_number ?? this.phone_number,
      address: address ?? this.address,
      person: person ?? this.person,
      serviceConfigurationId:
          serviceConfigurationId ?? this.serviceConfigurationId,
      use_date: use_date ?? this.use_date,
      time_slot: time_slot ?? this.time_slot,
      booking_info: booking_info ?? this.booking_info,
      agree_to_terms_of_service:
          agree_to_terms_of_servicereaId ?? this.agree_to_terms_of_service,
      note: note ?? this.note,
      object: object ?? this.object,
      registration_type: registration_type ?? this.registration_type,
      ticket_type: ticket_type ?? this.ticket_type,
      status: status ?? this.status,
      payment_status: payment_status ?? this.payment_status,
      confirm_use: confirm_use ?? this.confirm_use,
      fee: fee ?? this.fee,
      rules: rules ?? this.rules,
      terms_of_service: terms_of_service ?? this.terms_of_service,
      shelfLifeId: shelfLifeId ?? this.shelfLifeId,
      end_date: end_date ?? this.end_date,
      total_price: total_price ?? this.total_price,
      reason_refused_to_cancel:
          reason_refused_to_cancel ?? this.reason_refused_to_cancel,
      total_num_ticket: total_num_ticket ?? this.total_num_ticket,
      filter_fee: filter_fee ?? this.filter_fee,
      receipts_code: receipts_code ?? this.receipts_code,
      areaId: areaId ?? this.areaId,
    );
  }
}

class BookingInfo {
  String? object;
  double? price;
  double? price_child;
  double? price_adult;
  int? num;
  int? num_child;
  int? num_adult;
  double? fee;
  BookingInfo({
    this.object,
    this.price,
    this.price_child,
    this.price_adult,
    this.num,
    this.num_child,
    this.num_adult,
    this.fee,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'price': price,
      'price_child': price_child,
      'price_adult': price_adult,
      'num': num,
      'num_child': num_child,
      'num_adult': num_adult,
      'fee': fee,
    };
  }

  factory BookingInfo.fromMap(Map<String, dynamic> map) {
    return BookingInfo(
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
      num: int.tryParse(map['num'].toString()) != null
          ? int.parse(map['num'].toString())
          : null,
      num_child: int.tryParse(map['num_child'].toString()) != null
          ? int.parse(map['num_child'].toString())
          : null,
      num_adult: int.tryParse(map['num_adult'].toString()) != null
          ? int.parse(map['num_adult'].toString())
          : null,
      fee: double.tryParse(map['fee'].toString()) != null
          ? double.parse(map['fee'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingInfo.fromJson(String source) =>
      BookingInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  BookingInfo copyWith({
    String? object,
    double? price,
    double? price_child,
    double? price_adult,
    int? num,
    int? num_child,
    int? num_adult,
    double? fee,
  }) {
    return BookingInfo(
      object: object ?? this.object,
      price: price ?? this.price,
      price_child: price_child ?? this.price_child,
      price_adult: price_adult ?? this.price_adult,
      num: num ?? this.num,
      num_child: num_child ?? this.num_child,
      num_adult: num_adult ?? this.num_adult,
      fee: fee ?? this.fee,
    );
  }
}
