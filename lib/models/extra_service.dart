// ignore_for_file: non_constant_identifier_names

class ExtraService {
  ExtraService({
    this.code,
    this.createdTime,
    this.description,
    this.id,
    this.isAffiliate,
    this.isCharge,
    this.isDisplay,
    this.link_affiliate,
    this.name,
    this.payments,
    this.service_icon,
    this.updatedTime,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? name;
  bool? isCharge;
  bool? isDisplay;
  bool? isAffiliate;
  String? description;
  String? link_affiliate;
  ServiceIcon? service_icon;
  Payment? payments;

  ExtraService.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    name = json['name'];
    isCharge = json['isCharge'];
    isDisplay = json['isDisplay'];
    isAffiliate = json['isAffiliate'];
    description = json['description'];
    link_affiliate = json['link_affiliate'];
    service_icon = json['service_icon'] != null
        ? ServiceIcon.fromjson(json['service_icon'])
        : null;
    payments =
        json['payments'] != null ? Payment.fromJson(json['payments']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['code'] = code;
    data['name'] = name;
    data['isCharge'] = isCharge;
    data['isDisplay'] = isDisplay;
    data['isAffiliate'] = isAffiliate;
    data['description'] = description;
    data['link_affiliate'] = link_affiliate;
    data['description'] = description;
    data['link_affiliate'] = link_affiliate;
    return data;
  }
}

class ServiceIcon {
  ServiceIcon({
    this.createdTime,
    this.id,
    this.name,
    this.updatedTime,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? name;

  ServiceIcon.fromjson(Map<String, dynamic> json) {
    id = json['file_id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_id'] = id;
    data['name'] = name;
    return data;
  }
}

class Payment {
  Payment(
      {this.createdTime,
      this.id,
      this.paymentCycle,
      this.price,
      this.updatedTime});
  String? id;
  String? createdTime;
  String? updatedTime;
  double? price;
  String? paymentCycle;
  Payment.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    price = json['price'];
    paymentCycle = json['paymentCycle'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['price'] = price;
    return data;
  }
}
