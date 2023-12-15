// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_cudan/models/file_upload.dart';

class LinkingService {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? name;
  String? supplierId;
  String? industryId;
  String? link;
  String? time_start;
  String? time_end;
  String? address;
  String? image;
  String? describe;
  List<Product>? list_products;
  String? referral_code;
  String? status;
  List<FileUploadModel>? list_products_image_view;
  String? list_products_describe_view;
  Industry? i;
  LinkingService({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.name,
    this.supplierId,
    this.industryId,
    this.link,
    this.time_start,
    this.time_end,
    this.address,
    this.image,
    this.describe,
    this.list_products,
    this.referral_code,
    this.status,
    this.list_products_image_view,
    this.list_products_describe_view,
    this.i,
  });

  LinkingService copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? code,
    String? name,
    String? supplierId,
    String? industryId,
    String? link,
    String? time_start,
    String? time_end,
    String? address,
    String? image,
    String? describe,
    List<Product>? list_products,
    String? referral_code,
    String? status,
    List<FileUploadModel>? list_products_image_view,
    String? list_products_describe_view,
  }) {
    return LinkingService(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      code: code ?? this.code,
      name: name ?? this.name,
      supplierId: supplierId ?? this.supplierId,
      industryId: industryId ?? this.industryId,
      link: link ?? this.link,
      time_start: time_start ?? this.time_start,
      time_end: time_end ?? this.time_end,
      address: address ?? this.address,
      image: image ?? this.image,
      describe: describe ?? this.describe,
      list_products: list_products ?? this.list_products,
      referral_code: referral_code ?? this.referral_code,
      status: status ?? this.status,
      list_products_image_view:
          list_products_image_view ?? this.list_products_image_view,
      list_products_describe_view:
          list_products_describe_view ?? this.list_products_describe_view,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'name': name,
      'supplierId': supplierId,
      'industryId': industryId,
      'link': link,
      'time_start': time_start,
      'time_end': time_end,
      'address': address,
      'image': image,
      'describe': describe,
      'list_products': list_products?.map((x) => x.toMap()).toList(),
      'referral_code': referral_code,
      'status': status,
      'list_products_image_view':
          list_products_image_view?.map((x) => x.toMap()).toList(),
      'list_products_describe_view': list_products_describe_view,
    };
  }

  factory LinkingService.fromMap(Map<String, dynamic> map) {
    return LinkingService(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      supplierId:
          map['supplierId'] != null ? map['supplierId'] as String : null,
      industryId:
          map['industryId'] != null ? map['industryId'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      time_start:
          map['time_start'] != null ? map['time_start'] as String : null,
      time_end: map['time_end'] != null ? map['time_end'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      describe: map['describe'] != null ? map['describe'] as String : null,
      list_products: map['list_products'] != null
          ? List<Product>.from(
              (map['list_products'] as List<dynamic>).map<Product?>(
                (x) => Product.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      referral_code:
          map['referral_code'] != null ? map['referral_code'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      list_products_image_view: map['list_products_image_view'] != null
          ? List<FileUploadModel>.from(
              (map['list_products_image_view'] as List<int>)
                  .map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      list_products_describe_view: map['list_products_describe_view'] != null
          ? map['list_products_describe_view'] as String
          : null,
      i: map['i'] != null ? Industry.fromMap(map['i']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LinkingService.fromJson(String source) =>
      LinkingService.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Product {
  List<FileUploadModel>? image;
  List<FileUploadModel>? image2;
  String? name;
  double? listed_price;
  double? promotional_price;
  String? link;
  String? describe;
  Product({
    this.image,
    this.image2,
    this.name,
    this.listed_price,
    this.promotional_price,
    this.link,
    this.describe,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'image2': image2?.map((x) => x.toMap()).toList(),
      'name': name,
      'listed_price': listed_price,
      'promotional_price': promotional_price,
      'link': link,
      'describe': describe,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      image: map['image2'] != null
          ? List<FileUploadModel>.from(
              (map['image2'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      image2: map['image2'] != null
          ? List<FileUploadModel>.from(
              (map['image2'] as List<dynamic>).map<FileUploadModel?>(
                (x) => FileUploadModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      listed_price:
          map['listed_price'] != null ? map['listed_price'].toDouble() : null,
      promotional_price: map['promotional_price'] != null
          ? (map['promotional_price'].toDouble())
          : null,
      link: map['link'] != null ? map['link'] as String : null,
      describe: map['describe'] != null ? map['describe'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  Product copyWith({
    List<FileUploadModel>? image,
    List<FileUploadModel>? image2,
    String? name,
    double? listed_price,
    double? promotional_price,
    String? link,
    String? describe,
  }) {
    return Product(
      image: image ?? this.image,
      image2: image2 ?? this.image2,
      name: name ?? this.name,
      listed_price: listed_price ?? this.listed_price,
      promotional_price: promotional_price ?? this.promotional_price,
      link: link ?? this.link,
      describe: describe ?? this.describe,
    );
  }
}

class Industry {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? name;
  String? code;
  Industry({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.name,
    this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'name': name,
      'code': code,
    };
  }

  factory Industry.fromMap(Map<String, dynamic> map) {
    return Industry(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Industry.fromJson(String source) =>
      Industry.fromMap(json.decode(source) as Map<String, dynamic>);

  Industry copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? name,
    String? code,
  }) {
    return Industry(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }
}
