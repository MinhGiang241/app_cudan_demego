// ignore_for_file: non_constant_identifier_names

import 'reason.dart';

class Pet {
  Pet({
    this.address,
    this.apartmentId,
    this.check,
    this.code,
    this.color,
    this.createdTime,
    this.describe,
    this.id,
    this.isMobile,
    this.note,
    this.pet_name,
    this.pet_status,
    this.pet_type,
    this.regulations,
    this.sex,
    this.species,
    this.subscriberId,
    this.tel,
    this.updatedTime,
    this.weight,
    this.avt_pet,
    this.certificate,
    this.report,
    this.reasons,
  });
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? apartmentId;
  String? subscriberId;
  String? tel;
  String? pet_name;
  String? pet_type;
  String? color;
  String? species;
  String? sex;
  String? reasons;
  double? weight;
  String? describe;
  bool? check;
  String? address;
  String? regulations;
  String? pet_status;
  String? note;
  bool? isMobile;
  Reason? r;
  List<PetFile>? avt_pet;
  List<PetFile>? certificate;
  List<PetFile>? report;
  Pet.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    apartmentId = json['apartmentId'];
    subscriberId = json['subscriberId'];
    tel = json['tel'];
    pet_name = json['pet_name'];
    pet_type = json['pet_type'];
    color = json['color'];
    species = json['species'];
    sex = json['sex'];
    weight = double.tryParse(json['weight'].toString()) != null
        ? double.parse(json['weight'].toString())
        : 0;
    describe = json['describe'];
    check = json['check'];
    address = json['address'];
    regulations = json['regulations'];
    pet_status = json['pet_status'];
    note = json['note'];
    isMobile = json['isMobile'];
    reasons = json['reasons'];
    r = json['r'] != null
        ? json['r'].isNotEmpty
            ? Reason.fromJson(json['r'][0])
            : null
        : null;
    avt_pet = json['avt_pet'] != null
        ? json['avt_pet'].isNotEmpty
            ? json['avt_pet'].map<PetFile>((e) => PetFile.fromJson(e)).toList()
            : []
        : [];
    certificate = json['certificate'] != null
        ? json['certificate'].isNotEmpty
            ? json['certificate']
                .map<PetFile>((e) => PetFile.fromJson(e))
                .toList()
            : []
        : [];
    report = json['report'] != null
        ? json['report'].isNotEmpty
            ? json['report'].map<PetFile>((e) => PetFile.fromJson(e)).toList()
            : []
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['code'] = code;
    data['apartmentId'] = apartmentId;
    data['subscriberId'] = subscriberId;
    data['tel'] = tel;
    data['pet_name'] = pet_name;
    data['pet_type'] = pet_type;
    data['color'] = color;
    data['species'] = species;
    data['sex'] = sex;
    data['weight'] = weight;
    data['describe'] = describe;
    data['check'] = check;
    data['address'] = address;
    data['regulations'] = regulations;
    data['pet_status'] = pet_status;
    data['note'] = note;
    data['reasons'] = reasons;
    data['isMobile'] = isMobile;
    data['avt_pet'] = avt_pet != null
        ? avt_pet!.map((e) {
            return e.toJson();
          }).toList()
        : [];
    data['certificate'] = certificate != null
        ? certificate!.map((e) {
            return e.toJson();
          }).toList()
        : [];
    data['report'] = report != null
        ? report!.map((e) {
            return e.toJson();
          }).toList()
        : [];
    return data;
  }
}

class PetFile {
  PetFile({this.id, this.name});
  String? id;
  String? name;
  PetFile.fromJson(Map<String, dynamic> json) {
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
