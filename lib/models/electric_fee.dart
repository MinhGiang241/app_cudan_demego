import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class ElectricFee {
  String? id;
  String? createdTime;
  String? updatedTime;
  double? fixed_price;
  String? message;
  List<ElectricFeeDetail>? electric_fee;
  ElectricFee({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.fixed_price,
    this.message,
    this.electric_fee,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'fixed_price': fixed_price,
      'message': message,
      'electric_fee': electric_fee?.map((x) => x.toMap()).toList(),
    };
  }

  factory ElectricFee.fromMap(Map<String, dynamic> map) {
    return ElectricFee(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      fixed_price: double.tryParse(map['fixed_price'].toString()) != null
          ? double.parse(map['fixed_price'].toString())
          : null,
      message: map['message'] != null ? map['message'] as String : null,
      electric_fee: map['electric_fee'] != null
          ? List<ElectricFeeDetail>.from(
              (map['electric_fee'] as List<dynamic>).map<ElectricFeeDetail?>(
                (x) => ElectricFeeDetail.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ElectricFee.fromJson(String source) =>
      ElectricFee.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ElectricFeeDetail {
  String? createdTime;
  String? updatedTime;
  double? from;
  double? to;
  double? price;
  ElectricFeeDetail({
    this.createdTime,
    this.updatedTime,
    this.from,
    this.to,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'from': from,
      'to': to,
      'price': price,
    };
  }

  factory ElectricFeeDetail.fromMap(Map<String, dynamic> map) {
    return ElectricFeeDetail(
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      from: double.tryParse(map['from'].toString()) != null
          ? double.parse(map['from'].toString())
          : null,
      to: double.tryParse(map['to'].toString()) != null
          ? double.parse(map['to'].toString())
          : null,
      price: double.tryParse(map['price'].toString()) != null
          ? double.parse(map['price'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ElectricFeeDetail.fromJson(String source) =>
      ElectricFeeDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
