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
}

class Product {
  String? image;
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
      image: map['image'] != null ? map['image'] as String : null,
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
    String? image,
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
