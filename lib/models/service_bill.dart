// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'receipt.dart';

class ServiceBillTransaction {
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? billNum;
  String? status;
  String? purpose;
  String? apartmentId;
  String? payer_name;
  bool? paid_all_debt;
  bool? paid_all_service;
  List<String>? services;
  String? since;
  double? amount_money;
  double? received_amount;
  String? payment_method;
  String? casherId;
  double? cashback;
  double? debt;
  double? need_cashback;
  String? time;
  String? transferId;
  String? payer_phone;
  String? terminated_reason;
  String? terminated_time;
  int? month;
  int? year;
  String? note;
  List<Receipt>? receipts;
  List<Receipt>? debtRelates;
  ServiceBillTransaction({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.code,
    this.billNum,
    this.status,
    this.purpose,
    this.apartmentId,
    this.payer_name,
    this.paid_all_debt,
    this.paid_all_service,
    this.services,
    this.since,
    this.amount_money,
    this.received_amount,
    this.payment_method,
    this.casherId,
    this.cashback,
    this.debt,
    this.need_cashback,
    this.time,
    this.transferId,
    this.payer_phone,
    this.terminated_reason,
    this.terminated_time,
    this.month,
    this.year,
    this.note,
    this.receipts,
    this.debtRelates,
  });

  ServiceBillTransaction copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    String? code,
    String? billNum,
    String? status,
    String? purpose,
    String? apartmentId,
    String? payer_name,
    bool? paid_all_debt,
    bool? paid_all_service,
    List<String>? services,
    String? since,
    double? amount_money,
    double? received_amount,
    String? payment_method,
    String? casherId,
    double? cashback,
    double? debt,
    double? need_cashback,
    String? time,
    String? transferId,
    String? payer_phone,
    String? terminated_reason,
    String? terminated_time,
    int? month,
    int? year,
    String? note,
    List<Receipt>? receipts,
    List<Receipt>? debtRelates,
  }) {
    return ServiceBillTransaction(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      code: code ?? this.code,
      billNum: billNum ?? this.billNum,
      status: status ?? this.status,
      purpose: purpose ?? this.purpose,
      apartmentId: apartmentId ?? this.apartmentId,
      payer_name: payer_name ?? this.payer_name,
      paid_all_debt: paid_all_debt ?? this.paid_all_debt,
      paid_all_service: paid_all_service ?? this.paid_all_service,
      services: services ?? this.services,
      since: since ?? this.since,
      amount_money: amount_money ?? this.amount_money,
      received_amount: received_amount ?? this.received_amount,
      payment_method: payment_method ?? this.payment_method,
      casherId: casherId ?? this.casherId,
      cashback: cashback ?? this.cashback,
      debt: debt ?? this.debt,
      need_cashback: need_cashback ?? this.need_cashback,
      time: time ?? this.time,
      transferId: transferId ?? this.transferId,
      payer_phone: payer_phone ?? this.payer_phone,
      terminated_reason: terminated_reason ?? this.terminated_reason,
      terminated_time: terminated_time ?? this.terminated_time,
      month: month ?? this.month,
      year: year ?? this.year,
      note: note ?? this.note,
      receipts: receipts ?? this.receipts,
      debtRelates: debtRelates ?? this.debtRelates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'code': code,
      'billNum': billNum,
      'status': status,
      'purpose': purpose,
      'apartmentId': apartmentId,
      'payer_name': payer_name,
      'paid_all_debt': paid_all_debt,
      'paid_all_service': paid_all_service,
      'services': services,
      'since': since,
      'amount_money': amount_money,
      'received_amount': received_amount,
      'payment_method': payment_method,
      'casherId': casherId,
      'cashback': cashback,
      'debt': debt,
      'need_cashback': need_cashback,
      'time': time,
      'transferId': transferId,
      'payer_phone': payer_phone,
      'terminated_reason': terminated_reason,
      'terminated_time': terminated_time,
      'month': month,
      'year': year,
      'note': note,
      'receipts': receipts?.map((x) => x.toJson()).toList(),
      'debtRelates': debtRelates?.map((x) => x.toJson()).toList(),
    };
  }

  factory ServiceBillTransaction.fromMap(Map<String, dynamic> map) {
    return ServiceBillTransaction(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      billNum: map['billNum'] != null ? map['billNum'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      purpose: map['purpose'] != null ? map['purpose'] as String : null,
      apartmentId:
          map['apartmentId'] != null ? map['apartmentId'] as String : null,
      payer_name:
          map['payer_name'] != null ? map['payer_name'] as String : null,
      paid_all_debt:
          map['paid_all_debt'] != null ? map['paid_all_debt'] as bool : null,
      paid_all_service: map['paid_all_service'] != null
          ? map['paid_all_service'] as bool
          : null,
      services: map['services'] != null
          ? List<String>.from((map['services'] as List<dynamic>))
          : null,
      since: map['since'] != null ? map['since'] as String : null,
      amount_money: double.tryParse(map['amount_money'].toString()) != null
          ? double.parse(map['amount_money'].toString())
          : null,
      received_amount:
          double.tryParse(map['received_amount'].toString()) != null
              ? double.parse(map['received_amount'].toString())
              : null,
      payment_method: map['payment_method'] != null
          ? map['payment_method'] as String
          : null,
      casherId: map['casherId'] != null ? map['casherId'] as String : null,
      cashback: double.tryParse(map['cashback'].toString()) != null
          ? double.parse(map['cashback'].toString())
          : null,
      debt: double.tryParse(map['debt'].toString()) != null
          ? double.parse(map['debt'].toString())
          : null,
      need_cashback: double.tryParse(map['need_cashback'].toString()) != null
          ? double.parse(map['need_cashback'].toString())
          : null,
      time: map['time'] != null ? map['time'] as String : null,
      transferId:
          map['transferId'] != null ? map['transferId'] as String : null,
      payer_phone:
          map['payer_phone'] != null ? map['payer_phone'] as String : null,
      terminated_reason: map['terminated_reason'] != null
          ? map['terminated_reason'] as String
          : null,
      terminated_time: map['terminated_time'] != null
          ? map['terminated_time'] as String
          : null,
      month: int.tryParse(map['month'].toString()) != null
          ? int.parse(map['month'].toString())
          : null,
      year: int.tryParse(map['year'].toString()) != null
          ? int.parse(map['year'].toString())
          : null,
      note: map['note'] != null ? map['note'] as String : null,
      receipts: map['receipts'] != null
          ? List<Receipt>.from(
              (map['receipts'] as List<dynamic>).map<Receipt?>(
                (x) => Receipt.fromJson(x as Map<String, dynamic>),
              ),
            )
          : [],
      debtRelates: map['debtRelates'] != null
          ? List<Receipt>.from(
              (map['debtRelates'] as List<dynamic>).map<Receipt?>(
                (x) => Receipt.fromJson(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceBillTransaction.fromJson(String source) =>
      ServiceBillTransaction.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
