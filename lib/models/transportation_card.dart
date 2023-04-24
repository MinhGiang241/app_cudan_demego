// ignore_for_file: public_member_api_docs, sort_constructors_first, require_trailing_commas
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:app_cudan/models/reason.dart';
import 'package:app_cudan/models/resident_card.dart';
import 'package:app_cudan/models/response_resident_own.dart';

import 'file_upload.dart';
import 'resident_info.dart';
import 'status.dart';

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
      this.isMobile,
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
  bool? isMobile;

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
    isMobile = json['isMobile'];
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
    data['isMobile'] = isMobile;
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

// TransportCard update

class TransportCard {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? residentId;
  String? name_resident;
  List<TransportItem>? transports_list;
  bool? isMobile;
  String? registration_date;
  bool? integrated;
  String? residentCardId;
  bool? confirmation;
  String? registration_date_filter;
  String? rules;
  String? code;
  String? name;
  String? apartmentId;
  String? address_apartment;
  String? ticket_status;
  String? reasons;
  String? address;
  String? phone_number;
  String? identity;
  String? note_reason;
  String? card_type;
  // More
  Reason? r;
  Status? s;
  Apartment? a;
  ResponseResidentInfo? re;

  TransportCard({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.residentId,
    this.name_resident,
    this.transports_list,
    this.isMobile,
    this.registration_date,
    this.integrated,
    this.residentCardId,
    this.confirmation,
    this.registration_date_filter,
    this.rules,
    this.code,
    this.name,
    this.apartmentId,
    this.address_apartment,
    this.ticket_status,
    this.reasons,
    this.address,
    this.phone_number,
    this.identity,
    this.note_reason,
    this.card_type,
    this.r,
    this.s,
    this.a,
    this.re,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'residentId': residentId,
      'name_resident': name_resident,
      'transports_list': transports_list?.map((x) => x.toMap()).toList(),
      'isMobile': isMobile,
      'registration_date': registration_date,
      'integrated': integrated,
      'residentCardId': residentCardId,
      'confirmation': confirmation,
      'registration_date_filter': registration_date_filter,
      'rules': rules,
      'code': code,
      'name': name,
      'apartmentId': apartmentId,
      'address_apartment': address_apartment,
      'ticket_status': ticket_status,
      'reasons': reasons,
      'address': address,
      'phone_number': phone_number,
      'identity': identity,
      'note_reason': note_reason,
      'card_type': card_type,
    };
  }

  factory TransportCard.fromMap(Map<String, dynamic> map) {
    return TransportCard(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      name_resident:
          map['name_resident'] != null ? map['name_resident'] as String : null,
      transports_list: map['transports_list'] != null
          ? List<TransportItem>.from(
              (map['transports_list'] as List<dynamic>).map<TransportItem?>(
                (x) => TransportItem.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      isMobile: map['isMobile'] != null ? map['isMobile'] as bool : null,
      registration_date: map['registration_date'] != null
          ? map['registration_date'] as String
          : null,
      integrated: map['integrated'] != null ? map['integrated'] as bool : null,
      residentCardId: map['residentCardId'] != null
          ? map['residentCardId'] as String
          : null,
      confirmation:
          map['confirmation'] != null ? map['confirmation'] as bool : null,
      registration_date_filter: map['registration_date_filter'] != null
          ? map['registration_date_filter'] as String
          : null,
      rules: map['rules'] != null ? map['rules'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      address_apartment: map['address_apartment'] != null
          ? map['address_apartment'] as String
          : null,
      ticket_status:
          map['ticket_status'] != null ? map['ticket_status'] as String : null,
      reasons: map['reasons'] != null ? map['reasons'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      phone_number:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      identity: map['identity'] != null ? map['identity'] as String : null,
      note_reason:
          map['note_reason'] != null ? map['note_reason'] as String : null,
      card_type: map['card_type'] != null ? map['card_type'] as String : null,
      r: map['r'] != null
          ? Reason.fromJson(map['r'] as Map<String, dynamic>)
          : null,
      s: map['s'] != null
          ? Status.fromJson(map['s'] as Map<String, dynamic>)
          : null,
      a: map['a'] != null
          ? Apartment.fromJson(map['a'] as Map<String, dynamic>)
          : null,
      re: map['re'] != null ? ResponseResidentInfo.fromJson(map['re']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransportCard.fromJson(String source) =>
      TransportCard.fromMap(json.decode(source) as Map<String, dynamic>);

  TransportCard copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? residentId,
    String? name_resident,
    List<TransportItem>? transports_list,
    bool? isMobile,
    String? registration_date,
    bool? integrated,
    String? residentCardId,
    bool? confirmation,
    String? registration_date_filter,
    String? rules,
    String? code,
    String? name,
    String? apartmentId,
    String? address_apartment,
    String? ticket_status,
    String? reasons,
    String? address,
    String? phone_number,
    String? identity,
    String? note_reason,
    String? card_type,
  }) {
    return TransportCard(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      residentId: residentId ?? this.residentId,
      name_resident: name_resident ?? this.name_resident,
      transports_list: transports_list ?? this.transports_list,
      isMobile: isMobile ?? this.isMobile,
      registration_date: registration_date ?? this.registration_date,
      integrated: integrated ?? this.integrated,
      residentCardId: residentCardId ?? this.residentCardId,
      confirmation: confirmation ?? this.confirmation,
      registration_date_filter:
          registration_date_filter ?? this.registration_date_filter,
      rules: rules ?? this.rules,
      code: code ?? this.code,
      name: name ?? this.name,
      apartmentId: apartmentId ?? this.apartmentId,
      address_apartment: address_apartment ?? this.address_apartment,
      ticket_status: ticket_status ?? this.ticket_status,
      reasons: reasons ?? this.reasons,
      address: address ?? this.address,
      phone_number: phone_number ?? this.phone_number,
      identity: identity ?? this.identity,
      note_reason: note_reason ?? this.note_reason,
      card_type: card_type ?? this.card_type,
    );
  }
}

class TransportItem {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? picture;
  String? status;
  String? expire_date;
  String? residentId;
  String? manageCardId;
  String? code_seri;
  double? cost;
  int? vehicle_amount;
  int? seats;
  String? apartmentId;
  String? identity;
  String? vehicleTypeId;
  String? number_plate;
  String? registration_number;
  String? shelfLifeId;
  String? type;
  List<FileUploadModel>? registration_image;
  List<FileUploadModel>? vehicle_image;
  List<FileUploadModel>? identity_image;
  // More
  VehicleType? vehicleType;
  ShelfLife? shelfLife;
  TransportItem({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.picture,
    this.status,
    this.expire_date,
    this.residentId,
    this.manageCardId,
    this.code_seri,
    this.cost,
    this.vehicle_amount,
    this.apartmentId,
    this.identity,
    this.vehicleTypeId,
    this.number_plate,
    this.registration_number,
    this.shelfLifeId,
    this.type,
    this.registration_image,
    this.vehicle_image,
    this.identity_image,
    this.vehicleType,
    this.shelfLife,
    this.seats,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'picture': picture,
      'status': status,
      'expire_date': expire_date,
      'residentId': residentId,
      'manageCardId': manageCardId,
      'code_seri': code_seri,
      'cost': cost,
      'vehicle_amount': vehicle_amount,
      'apartmentId': apartmentId,
      'identity': identity,
      'vehicleTypeId': vehicleTypeId,
      'number_plate': number_plate,
      'registration_number': registration_number,
      'shelfLifeId': shelfLifeId,
      'type': type,
      'seats': seats,
      'registration_image': registration_image?.map((x) => x.toMap()).toList(),
      'vehicle_image': vehicle_image?.map((x) => x.toMap()).toList(),
      'identity_image': identity_image?.map((x) => x.toMap()).toList(),
    };
  }

  factory TransportItem.fromMap(Map<String, dynamic> map) {
    return TransportItem(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      picture: map['picture'] != null ? map['picture'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      expire_date:
          map['expire_date'] != null ? map['expire_date'] as String : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      manageCardId:
          map['manageCardId'] != null ? map['manageCardId'] as String : null,
      code_seri: map['code_seri'] != null ? map['code_seri'] as String : null,
      cost: map['cost'] != null ? map['cost'] as double : null,
      vehicle_amount: int.tryParse(map['vehicle_amount'].toString()) != null
          ? int.parse(map['vehicle_amount'].toString())
          : null,
      seats: int.tryParse(map['seats'].toString()) != null
          ? int.parse(map['seats'].toString())
          : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      identity: map['identity'] != null ? map['identity'] as String : null,
      vehicleTypeId:
          map['vehicleTypeId'] != null ? map['vehicleTypeId'] as String : null,
      number_plate:
          map['number_plate'] != null ? map['number_plate'] as String : null,
      registration_number: map['registration_number'] != null
          ? map['registration_number'] as String
          : null,
      shelfLifeId:
          map['shelfLifeId'] != null ? (map['shelfLifeId']) as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      registration_image: map['registration_image'] != null
          ? List<FileUploadModel>.from(
              (map['registration_image'] as List<dynamic>)
                  .map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      vehicle_image: map['vehicle_image'] != null
          ? List<FileUploadModel>.from(
              (map['vehicle_image'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      identity_image: map['identity_image'] != null
          ? List<FileUploadModel>.from(
              (map['identity_image'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      vehicleType: map['vehicleType'] != null
          ? VehicleType.fromJson(map['vehicleType'] as Map<String, dynamic>)
          : null,
      shelfLife: map['shelflife'] != null
          ? ShelfLife.fromMap(map['shelflife'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransportItem.fromJson(String source) =>
      TransportItem.fromMap(json.decode(source) as Map<String, dynamic>);

  TransportItem copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? picture,
    String? status,
    String? expire_date,
    String? residentId,
    String? manageCardId,
    String? code_seri,
    double? cost,
    int? vehicle_amount,
    int? seats,
    String? apartmentId,
    String? identity,
    String? vehicleTypeId,
    String? number_plate,
    String? registration_number,
    String? shelfLifeId,
    String? type,
    List<FileUploadModel>? registration_image,
    List<FileUploadModel>? vehicle_image,
    List<FileUploadModel>? identity_image,
    VehicleType? vehicleType,
    ShelfLife? shelfLife,
  }) {
    return TransportItem(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      picture: picture ?? this.picture,
      status: status ?? this.status,
      expire_date: expire_date ?? this.expire_date,
      residentId: residentId ?? this.residentId,
      manageCardId: manageCardId ?? this.manageCardId,
      code_seri: code_seri ?? this.code_seri,
      cost: cost ?? this.cost,
      vehicle_amount: vehicle_amount ?? this.vehicle_amount,
      seats: seats ?? this.seats,
      apartmentId: apartmentId ?? this.apartmentId,
      identity: identity ?? this.identity,
      vehicleTypeId: vehicleTypeId ?? this.vehicleTypeId,
      number_plate: number_plate ?? this.number_plate,
      registration_number: registration_number ?? this.registration_number,
      shelfLifeId: shelfLifeId ?? this.shelfLifeId,
      type: type ?? this.type,
      registration_image: registration_image ?? this.registration_image,
      vehicle_image: vehicle_image ?? this.vehicle_image,
      identity_image: identity_image ?? this.identity_image,
      vehicleType: vehicleType ?? this.vehicleType,
      shelfLife: shelfLife ?? this.shelfLife,
    );
  }
}

class ShelfLife {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  int? use_time;
  String? describe;
  String? type_time;
  String? time;
  int? order;
  ShelfLife({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.use_time,
    this.describe,
    this.type_time,
    this.time,
    this.order,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'use_time': use_time,
      'describe': describe,
      'type_time': type_time,
      'time': time,
      'order': order,
    };
  }

  factory ShelfLife.fromMap(Map<String, dynamic> map) {
    return ShelfLife(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      use_time: int.tryParse(map['use_time'].toString()) != null
          ? int.parse(map['use_time'].toString())
          : null,
      describe: map['describe'] != null ? map['describe'] as String : null,
      type_time: map['type_time'] != null ? map['type_time'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      order: int.tryParse(map['order'].toString()) != null
          ? int.parse(map['order'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShelfLife.fromJson(String source) =>
      ShelfLife.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FormRenewalTransport {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? shelfLifeId;
  String? expire_date;
  String? renewal_date;
  String? expire_date_old;
  List<TransportItem>? transports_list;
  String? listTransportId;
  FormRenewalTransport({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.shelfLifeId,
    this.expire_date,
    this.renewal_date,
    this.expire_date_old,
    this.transports_list,
    this.listTransportId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'shelfLifeId': shelfLifeId,
      'expire_date': expire_date,
      'renewal_date': renewal_date,
      'expire_date_old': expire_date_old,
      'transports_list': transports_list?.map((x) => x.toMap()).toList(),
      'listTransportId': listTransportId,
    };
  }

  factory FormRenewalTransport.fromMap(Map<String, dynamic> map) {
    return FormRenewalTransport(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      shelfLifeId:
          map['shelfLifeId'] != null ? map['shelfLifeId'] as String : null,
      expire_date:
          map['expire_date'] != null ? map['expire_date'] as String : null,
      renewal_date:
          map['renewal_date'] != null ? map['renewal_date'] as String : null,
      expire_date_old: map['expire_date_old'] != null
          ? map['expire_date_old'] as String
          : null,
      transports_list: map['transports_list'] != null
          ? List<TransportItem>.from(
              (map['transports_list'] as List<dynamic>).map<TransportItem?>(
                (x) => TransportItem.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      listTransportId: map['listTransportId'] != null
          ? map['listTransportId'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormRenewalTransport.fromJson(String source) =>
      FormRenewalTransport.fromMap(json.decode(source) as Map<String, dynamic>);
}
