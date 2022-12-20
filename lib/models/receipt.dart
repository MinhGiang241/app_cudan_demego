// ignore_for_file: non_constant_identifier_names

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
    this.discount_percent,
    this.full_name,
    this.guest_name,
    this.reason,
    this.vat,
    this.transactions = const [],
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
  double? vat;
  double? discount_money;
  double? discount_percent;
  double? amount_due;
  late List<TransactionHistory> transactions;
  late bool isSelected;

  Receipt.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    date = json['date'];
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
    payment = json['payment'];
    type = json['type'];
    reason = json['reason'];
    content = json['content'];
    address = json['address'];
    guest_name = json['guest_name'];
    full_name = json['full_name'];
    vat = json['vat'] != null ? double.parse(json['vat'].toString()) : 0;
    discount_money = json['discount_money'] != null
        ? double.parse(json['discount_money'].toString())
        : 0;
    discount_percent = json['discount_percent'] != null
        ? double.parse(json['discount_percent'].toString())
        : 0;
    amount_due = json['amount_due'] != null
        ? double.parse(json['amount_due'].toString())
        : 0;
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
    data['apartmentId'] = apartmentId;
    data['residentId'] = residentId;
    data['payment_status'] = payment_status;
    data['receipts_status'] = receipts_status;
    data['customer_type'] = customer_type;
    data['check'] = check;
    data['payer'] = payer;
    data['payer_phone'] = payer_phone;
    data['payment'] = payment;
    data['type'] = type;
    data['reason'] = reason;
    data['content'] = content;
    data['address'] = address;
    data['guest_name'] = guest_name;
    data['full_name'] = full_name;
    data['vat'] = vat;
    data['discount_money'] = discount_money;
    data['discount_percent'] = discount_percent;
    data['amount_due'] = amount_due;
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
    this.expiration_date,
    this.id,
    this.payment_amount,
    this.receiptsId,
    this.time,
    this.updatedTime,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? receiptsId;
  String? employeeId;
  double? amount_money;
  double? payment_amount;
  double? amount_owed;
  String? date;
  String? time;
  String? expiration_date;
  TransactionHistory.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
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
    expiration_date = json['expiration_date'];
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
    data['expiration_date'] = expiration_date;
    return data;
  }
}
