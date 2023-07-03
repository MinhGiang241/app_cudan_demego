// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:app_cudan/models/file_upload.dart';

class AssetStorage {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? serial_lot;
  int? quantity;
  String? type;
  String? warehouseId;
  String? code;
  String? unit;
  String? supplierId;
  String? asset_type;
  dynamic file;
  List<FileUploadModel>? image_asset;
  String? receive_date;
  String? shelfLifeId;
  String? warranty_date;
  String? warranty_code;
  String? filter_warehouseId;
  AssetStorage({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.serial_lot,
    this.quantity,
    this.type,
    this.warehouseId,
    this.code,
    this.unit,
    this.supplierId,
    this.asset_type,
    required this.file,
    this.image_asset,
    this.receive_date,
    this.shelfLifeId,
    this.warranty_date,
    this.warranty_code,
    this.filter_warehouseId,
  });

  AssetStorage copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? serial_lot,
    int? quantity,
    String? type,
    String? warehouseId,
    String? code,
    String? unit,
    String? supplierId,
    String? asset_type,
    dynamic? file,
    List<FileUploadModel>? image_asset,
    String? receive_date,
    String? shelfLifeId,
    String? warranty_date,
    String? warranty_code,
    String? filter_warehouseId,
  }) {
    return AssetStorage(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      serial_lot: serial_lot ?? this.serial_lot,
      quantity: quantity ?? this.quantity,
      type: type ?? this.type,
      warehouseId: warehouseId ?? this.warehouseId,
      code: code ?? this.code,
      unit: unit ?? this.unit,
      supplierId: supplierId ?? this.supplierId,
      asset_type: asset_type ?? this.asset_type,
      file: file ?? this.file,
      image_asset: image_asset ?? this.image_asset,
      receive_date: receive_date ?? this.receive_date,
      shelfLifeId: shelfLifeId ?? this.shelfLifeId,
      warranty_date: warranty_date ?? this.warranty_date,
      warranty_code: warranty_code ?? this.warranty_code,
      filter_warehouseId: filter_warehouseId ?? this.filter_warehouseId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'serial_lot': serial_lot,
      'quantity': quantity,
      'type': type,
      'warehouseId': warehouseId,
      'code': code,
      'unit': unit,
      'supplierId': supplierId,
      'asset_type': asset_type,
      'file': file,
      'image_asset': image_asset?.map((x) => x.toMap()).toList(),
      'receive_date': receive_date,
      'shelfLifeId': shelfLifeId,
      'warranty_date': warranty_date,
      'warranty_code': warranty_code,
      'filter_warehouseId': filter_warehouseId,
    };
  }

  factory AssetStorage.fromMap(Map<String, dynamic> map) {
    return AssetStorage(
      id: map['id'] != null ? map['id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      serial_lot:
          map['serial_lot'] != null ? map['serial_lot'] as String : null,
      quantity: int.tryParse(map['quantity'].toString()) != null
          ? int.parse(map['quantity'].toString())
          : null,
      type: map['type'] != null ? map['type'] as String : null,
      warehouseId:
          map['warehouseId'] != null ? map['warehouseId'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      unit: map['unit'] != null ? map['unit'] as String : null,
      supplierId:
          map['supplierId'] != null ? map['supplierId'] as String : null,
      asset_type:
          map['asset_type'] != null ? map['asset_type'] as String : null,
      file: map['file'] as dynamic,
      image_asset: map['image_asset'] != null
          ? List<FileUploadModel>.from(
              (map['image_asset'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      receive_date:
          map['receive_date'] != null ? map['receive_date'] as String : null,
      shelfLifeId:
          map['shelfLifeId'] != null ? map['shelfLifeId'] as String : null,
      warranty_date:
          map['warranty_date'] != null ? map['warranty_date'] as String : null,
      warranty_code:
          map['warranty_code'] != null ? map['warranty_code'] as String : null,
      filter_warehouseId: map['filter_warehouseId'] != null
          ? map['filter_warehouseId'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetStorage.fromJson(String source) =>
      AssetStorage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssetStorage(id: $id, createdTime: $createdTime, updatedTime: $updatedTime, serial_lot: $serial_lot, quantity: $quantity, type: $type, warehouseId: $warehouseId, code: $code, unit: $unit, supplierId: $supplierId, asset_type: $asset_type, file: $file, image_asset: $image_asset, receive_date: $receive_date, shelfLifeId: $shelfLifeId, warranty_date: $warranty_date, warranty_code: $warranty_code, filter_warehouseId: $filter_warehouseId)';
  }

  @override
  bool operator ==(covariant AssetStorage other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdTime == createdTime &&
        other.updatedTime == updatedTime &&
        other.serial_lot == serial_lot &&
        other.quantity == quantity &&
        other.type == type &&
        other.warehouseId == warehouseId &&
        other.code == code &&
        other.unit == unit &&
        other.supplierId == supplierId &&
        other.asset_type == asset_type &&
        other.file == file &&
        listEquals(other.image_asset, image_asset) &&
        other.receive_date == receive_date &&
        other.shelfLifeId == shelfLifeId &&
        other.warranty_date == warranty_date &&
        other.warranty_code == warranty_code &&
        other.filter_warehouseId == filter_warehouseId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdTime.hashCode ^
        updatedTime.hashCode ^
        serial_lot.hashCode ^
        quantity.hashCode ^
        type.hashCode ^
        warehouseId.hashCode ^
        code.hashCode ^
        unit.hashCode ^
        supplierId.hashCode ^
        asset_type.hashCode ^
        file.hashCode ^
        image_asset.hashCode ^
        receive_date.hashCode ^
        shelfLifeId.hashCode ^
        warranty_date.hashCode ^
        warranty_code.hashCode ^
        filter_warehouseId.hashCode;
  }
}
