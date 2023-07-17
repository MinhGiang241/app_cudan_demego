import 'dart:convert';

// ignore_for_file: file_names, non_constant_identifier_names

class WaterFee {
  String? id;
  String? createdTime;
  String? updatedTime;
  double? fixed_price;
  String? message;
  List<WaterFeeDetail>? water_fee;
  WaterFee({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.fixed_price,
    this.message,
    this.water_fee,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'fixed_price': fixed_price,
      'message': message,
      'electric_fee': water_fee?.map((x) => x.toMap()).toList(),
    };
  }

  factory WaterFee.fromMap(Map<String, dynamic> map) {
    return WaterFee(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      fixed_price: double.tryParse(map['fixed_price'].toString()) != null
          ? double.parse(map['fixed_price'].toString())
          : null,
      message: map['message'] != null ? map['message'] as String : null,
      water_fee: map['water_fee'].runtimeType.toString() ==
              "_InternalLinkedHashMap<String, dynamic>"
          ? map['water_fee']['_v'] != null
              ? List<WaterFeeDetail>.from(
                  (map['water_fee']['_v'] as List<dynamic>)
                      .map<WaterFeeDetail?>(
                    (x) => WaterFeeDetail.fromMap(x as Map<String, dynamic>),
                  ),
                )
              : map['water_fee'] != null
                  ? List<WaterFeeDetail>.from(
                      (map['water_fee'] as List<dynamic>).map<WaterFeeDetail?>(
                        (x) =>
                            WaterFeeDetail.fromMap(x as Map<String, dynamic>),
                      ),
                    )
                  : null
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WaterFee.fromJson(String source) =>
      WaterFee.fromMap(json.decode(source) as Map<String, dynamic>);
}

class WaterFeeDetail {
  String? createdTime;
  String? updatedTime;
  double? from;
  double? to;
  double? price;
  WaterFeeDetail({
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

  factory WaterFeeDetail.fromMap(Map<String, dynamic> map) {
    return WaterFeeDetail(
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

  factory WaterFeeDetail.fromJson(String source) =>
      WaterFeeDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
