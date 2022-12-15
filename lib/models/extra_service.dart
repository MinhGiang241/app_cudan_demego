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
    this.use_time,
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
  List<Payment>? use_time;
  List<Pay>? pay;

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
    pay = json['pay'] != null
        ? json['pay'].isNotEmpty
            ? json['pay'].map<Pay>((e) => Pay.fromJson(e)).toList()
            : []
        : [];

    use_time = json['use_time'] != null
        ? json['use_time'].isNotEmpty
            ? json['use_time'].map<Payment>((e) => Payment.fromJson(e)).toList()
            : []
        : [];

    service_icon = json['service_icon'] != null
        ? ServiceIcon.fromjson(json['service_icon'])
        : null;
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

class Pay {
  Pay({
    this.code,
    this.createdTime,
    this.id,
    this.describe,
    this.updatedTime,
    this.price,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  int? use_time;
  String? type_time;
  String? describe;
  int? price;

  Pay.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    type_time = json['type_time'];
    use_time = json['use_time'];
    price = json['price'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['type_time'] = type_time;
    data['use_time'] = use_time;

    data['code'] = code;
    data['describe'] = describe;
    data['price'] = price;
    return data;
  }
}

class Payment {
  Payment(
      {this.createdTime,
      this.id,
      this.shelfLifeId,
      this.price,
      this.updatedTime});
  String? id;
  String? createdTime;
  String? updatedTime;
  int? price;
  String? shelfLifeId;
  Payment.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    price = json['price'];
    shelfLifeId = json['shelfLifeId'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['price'] = price;
    data['shelfLifeId'] = shelfLifeId;
    return data;
  }
}
