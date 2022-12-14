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
    return data;
  }
}
