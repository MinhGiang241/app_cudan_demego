// ignore_for_file: non_constant_identifier_names

class Delivery {
  Delivery(
      {this.id,
      this.apartmentId,
      this.code,
      this.createdTime,
      this.end_time,
      this.help_check,
      this.item_added_list,
      this.note_reason,
      this.phone_number,
      this.reasons,
      this.residentId,
      this.start_time,
      this.status,
      this.type_transfer,
      this.updatedTime,
      this.image,
      this.end_hour,
      this.start_hour,
      this.describe});
  String? id;
  String? createdTime;
  String? updatedTime;
  String? apartmentId;
  String? residentId;
  String? phone_number;
  String? type_transfer;
  String? start_time;
  String? end_time;
  String? start_hour;
  String? end_hour;
  String? code;
  String? reasons;
  String? note_reason;
  String? describe;
  String? status;
  bool? help_check;
  List<ItemDeliver>? item_added_list;
  List<ImageDelivery>? image;
  Delivery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    apartmentId = json['apartmentId'];
    residentId = json['residentId'];
    phone_number = json['phone_number'];
    describe = json['describe'];
    type_transfer = json['type_transfer'];
    start_time = json['start_time'];
    end_time = json['end_time'];
    code = json['code'];
    reasons = json['reasons'];
    note_reason = json['note_reason'];
    status = json['status'];
    help_check = json['help_check'];
    image = json['image'] != null
        ? json['image'].length != 0
            ? json['image']
                .map<ImageDelivery>((e) => ImageDelivery.fromJson(e))
                .toList()
            : []
        : [];
    item_added_list = json['item_added_list'] != null
        ? json['item_added_list'].length != 0
            ? json['item_added_list']
                .map<ItemDeliver>((e) => ItemDeliver.fromJson(e))
                .toList()
            : []
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['residentId'] = residentId;
    data['apartmentId'] = apartmentId;
    data['phone_number'] = phone_number;
    data['type_transfer'] = type_transfer;
    data['start_time'] = start_time;
    data['describe'] = describe;
    data['end_time'] = end_time;
    data['code'] = code;
    data['reasons'] = reasons;
    data['note_reason'] = note_reason;
    data['status'] = status;
    data['help_check'] = help_check;
    data['image'] = image != null ? [...image!.map((e) => e.toJson())] : [];
    data['item_added_list'] = item_added_list != null
        ? [...item_added_list!.map((e) => e.toJson())]
        : [];
    return data;
  }
}

class ItemDeliver {
  ItemDeliver(
      {this.createdTime,
      this.dimension,
      this.item_name,
      this.updatedTime,
      this.weight});
  String? createdTime;
  String? updatedTime;
  String? item_name;
  String? dimension;
  double? weight;
  ItemDeliver.fromJson(Map<String, dynamic> json) {
    createdTime = json['createdTime'];
    dimension = json['dimension'];
    item_name = json['item_name'];
    updatedTime = json['updatedTime'];

    weight = double.tryParse(json['weight'].toString()) != null
        ? double.parse(json['weight'].toString())
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdTime'] = createdTime;
    data['dimension'] = dimension;
    data['item_name'] = item_name;
    data['updatedTime'] = updatedTime;
    data['weight'] = weight;

    return data;
  }
}

class ImageDelivery {
  String? id;
  String? name;

  ImageDelivery({this.id, this.name});
  ImageDelivery.fromJson(Map<String, dynamic> json) {
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
