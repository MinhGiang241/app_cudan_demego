// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:app_cudan/models/file_upload.dart';
import 'package:app_cudan/models/status.dart';
import 'package:app_cudan/models/transportation_card.dart';

class ListTransport {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? vehicleTypeId;
  int? seats;
  String? number_plate;
  String? registration_number;
  String? shelfLifeId;
  String? type;
  List<FileUploadModel>? registration_image;
  List<FileUploadModel>? vehicle_image;
  List<FileUploadModel>? identity_image;
  String? picture;
  String? status;
  String? expire_date;
  String? residentId;
  String? manageCardId;
  String? code_seri;
  double? cost;
  int? vehicle_amount;
  String? apartmentId;
  String? identity;

  //

  VehicleType? v;
  ShelfLife? sh;
  Status? s;
  ListTransport({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.vehicleTypeId,
    this.seats,
    this.number_plate,
    this.registration_number,
    this.shelfLifeId,
    this.type,
    this.registration_image,
    this.vehicle_image,
    this.identity_image,
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
    this.s,
    this.sh,
    this.v,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'vehicleTypeId': vehicleTypeId,
      'seats': seats,
      'number_plate': number_plate,
      'registration_number': registration_number,
      'shelfLifeId': shelfLifeId,
      'type': type,
      'registration_image': registration_image?.map((x) => x.toMap()).toList(),
      'vehicle_image': vehicle_image?.map((x) => x.toMap()).toList(),
      'identity_image': identity_image?.map((x) => x.toMap()).toList(),
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
    };
  }

  factory ListTransport.fromMap(Map<String, dynamic> map) {
    return ListTransport(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      vehicleTypeId:
          map['vehicleTypeId'] != null ? map['vehicleTypeId'] as String : null,
      seats: int.tryParse(map['seats'].toString()) != null
          ? int.parse(map['seats'].toString())
          : null,
      number_plate:
          map['number_plate'] != null ? map['number_plate'] as String : null,
      registration_number: map['registration_number'] != null
          ? map['registration_number'] as String
          : null,
      shelfLifeId:
          map['shelfLifeId'] != null ? map['shelfLifeId'] as String : null,
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
      picture: map['picture'] != null ? map['picture'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      expire_date:
          map['expire_date'] != null ? map['expire_date'] as String : null,
      residentId:
          map['residentId'] != null ? map['residentId'] as String : null,
      manageCardId:
          map['manageCardId'] != null ? map['manageCardId'] as String : null,
      code_seri: map['code_seri'] != null ? map['code_seri'] as String : null,
      cost: double.tryParse(map['cost'].toString()) != null
          ? double.parse(map['cost'].toString())
          : null,
      vehicle_amount: int.tryParse(map['vehicle_amount'].toString()) != null
          ? int.parse(map['vehicle_amount'].toString())
          : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      identity: map['identity'] != null ? map['identity'] as String : null,
      s: map['s'] != null ? Status.fromJson(map['s']) : null,
      sh: map['sh'] != null ? ShelfLife.fromMap(map['sh']) : null,
      v: map['v'] != null ? VehicleType.fromJson(map['v']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListTransport.fromJson(String source) =>
      ListTransport.fromMap(json.decode(source) as Map<String, dynamic>);
}
