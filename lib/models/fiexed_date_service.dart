import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class FixedDateService {
  String? id;
  String? createdTime;
  String? updatedTime;
  int? receipt_date;
  int? cut_service_date;
  List<PaymentReminder>? payment_reminder;
  FixedDateService({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.receipt_date,
    this.cut_service_date,
    this.payment_reminder,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'receipt_date': receipt_date,
      'cut_service_date': cut_service_date,
      'payment_reminder': payment_reminder?.map((x) => x.toMap()).toList(),
    };
  }

  factory FixedDateService.fromMap(Map<String, dynamic> map) {
    return FixedDateService(
      id: map['id'] != null ? map['id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      receipt_date:
          map['receipt_date'] != null ? map['receipt_date'] as int : null,
      cut_service_date: map['cut_service_date'] != null
          ? map['cut_service_date'] as int
          : null,
      payment_reminder: map['payment_reminder'] != null
          ? List<PaymentReminder>.from(
              (map['payment_reminder'] as List<dynamic>).map<PaymentReminder?>(
                (x) => PaymentReminder.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FixedDateService.fromJson(String source) =>
      FixedDateService.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PaymentReminder {
  int? after_date;
  PaymentReminder({
    this.after_date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'after_date': after_date,
    };
  }

  factory PaymentReminder.fromMap(Map<String, dynamic> map) {
    return PaymentReminder(
      after_date: map['after_date'] != null ? map['after_date'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentReminder.fromJson(String source) =>
      PaymentReminder.fromMap(json.decode(source) as Map<String, dynamic>);
}
