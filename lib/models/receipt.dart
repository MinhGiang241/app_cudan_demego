// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'indicator.dart';

class Receipt {
  Receipt({
    this.apartmentId,
    this.check,
    this.createdTime,
    this.customer_type,
    this.date,
    this.employeeId,
    this.id,
    this.payer,
    this.payer_phone,
    this.payment,
    this.payment_status,
    this.phone,
    this.receipts_status,
    this.residentId,
    this.type,
    this.updatedTime,
    this.address,
    this.amount_due,
    this.content,
    this.discount_money,
    this.amount,
    this.discount_percent,
    this.discount_type,
    this.full_name,
    this.guest_name,
    this.reason,
    this.vat,
    this.expiration_date,
    this.code,
    this.refId,
    this.refSchema,
    this.transactions = const [],
    this.fee_config,
    this.month_indicator,
    this.year_indicator,
    this.indicator,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? date;
  String? employeeId;
  String? phone;
  String? apartmentId;
  String? residentId;
  String? payment_status;
  String? receipts_status;
  String? customer_type;
  String? expiration_date;
  bool? check;
  String? payer;
  String? payer_phone;
  int? payment;
  String? type;
  String? reason;
  String? content;
  String? address;
  String? guest_name;
  String? full_name;
  String? code;
  double? vat;
  double? discount_money;
  double? amount;
  double? discount_percent;
  double? amount_due;
  String? discount_type;
  late List<TransactionHistory> transactions;
  late bool isSelected;
  String? refSchema;
  String? refId;
  int? month_indicator;
  int? year_indicator;
  dynamic fee_config;
  Indicator? indicator;

  Receipt.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    date = json['date'];
    code = json['code'];
    employeeId = json['employeeId'];
    phone = json['phone'];
    apartmentId = json['apartmentId'];
    residentId = json['residentId'];
    payment_status = json['payment_status'];
    receipts_status = json['receipts_status'];
    customer_type = json['customer_type'];
    check = json['check'];
    payer = json['payer'];
    payer_phone = json['payer_phone'];
    discount_type = json['discount_type'];
    payment = json['payment'];
    type = json['type'];
    reason = json['reason'];
    content = json['content'];
    address = json['address'];
    guest_name = json['guest_name'];
    full_name = json['full_name'];
    refSchema = json['refSchema'];
    refId = json['refId'];
    expiration_date = json['expiration_date'];
    vat = json['vat'] != null ? double.parse(json['vat'].toString()) : null;
    discount_money = json['discount_money'] != null
        ? double.parse(json['discount_money'].toString())
        : null;
    amount =
        json['amount'] != null ? double.parse(json['amount'].toString()) : null;
    discount_percent = json['discount_percent'] != null
        ? double.parse(json['discount_percent'].toString())
        : null;
    amount_due = json['amount_due'] != null
        ? double.parse(json['amount_due'].toString())
        : 0;
    month_indicator = json['month_indicator'] != null
        ? int.parse(json['month_indicator'].toString())
        : 0;
    year_indicator = json['year_indicator'] != null
        ? int.parse(json['year_indicator'].toString())
        : 0;
    fee_config = json['fee_config'];
    indicator =
        json['indicator'] != null ? Indicator.fromMap(json['indicator']) : null;
    transactions = json['transactions'] != null
        ? json['transactions'].isNotEmpty
            ? json['transactions']
                .map<TransactionHistory>((e) => TransactionHistory.fromJson(e))
                .toList()
            : []
        : [];
    isSelected = false;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['date'] = date;
    data['employeeId'] = employeeId;
    data['phone'] = phone;
    data['code'] = code;
    data['apartmentId'] = apartmentId;
    data['residentId'] = residentId;
    data['payment_status'] = payment_status;
    data['receipts_status'] = receipts_status;
    data['customer_type'] = customer_type;
    data['check'] = check;
    data['payer'] = payer;
    data['payer_phone'] = payer_phone;
    data['discount_type'] = discount_type;
    data['payment'] = payment;
    data['type'] = type;
    data['reason'] = reason;
    data['content'] = content;
    data['address'] = address;
    data['guest_name'] = guest_name;
    data['full_name'] = full_name;
    data['expiration_date'] = expiration_date;
    data['vat'] = vat;
    data['discount_money'] = discount_money;
    data['amount'] = amount;
    data['discount_percent'] = discount_percent;
    data['amount_due'] = amount_due;
    data['refSchema'] = refSchema;
    data['refId'] = refId;
    data['fee_config'] = fee_config?.toMap();
    data['month_indicator'] = month_indicator;
    data['year_indicator'] = year_indicator;
    return data;
  }
}

class TransactionHistory {
  TransactionHistory({
    this.amount_money,
    this.amount_owed,
    this.createdTime,
    this.date,
    this.employeeId,
    this.id,
    this.payment_amount,
    this.receiptsId,
    this.time,
    this.isMobile,
    this.updatedTime,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  bool? isMobile;
  String? receiptsId;
  String? employeeId;
  double? amount_money;
  double? payment_amount;
  double? amount_owed;
  String? date;
  String? time;

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    isMobile = json['isMobile'] ?? false;

    receiptsId = json['receiptsId'];
    employeeId = json['employeeId'];

    amount_money = json['amount_money'] != null
        ? double.parse(json['amount_money'].toString())
        : 0;
    payment_amount = json['payment_amount'] != null
        ? double.parse(json['payment_amount'].toString())
        : 0;
    amount_owed = json['amount_owed'] != null
        ? double.parse(json['amount_owed'].toString())
        : 0;
    date = json['date'];
    time = json['time'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['receiptsId'] = receiptsId;
    data['employeeId'] = employeeId;
    data['amount_money'] = amount_money;
    data['payment_amount'] = payment_amount;
    data['amount_owed'] = amount_owed;
    data['date'] = date;
    data['time'] = time;
    data['isMobile'] = isMobile;
    return data;
  }
}

class FeeDetail {
  String? createdTime;
  String? updatedTime;
  double? from;
  double? to;
  double? price;
  FeeDetail({
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

  factory FeeDetail.fromMap(Map<String, dynamic> map) {
    return FeeDetail(
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

  factory FeeDetail.fromJson(String source) =>
      FeeDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
