// ignore_for_file: non_constant_identifier_names

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
  int? weight;
  String? describe;
  bool? check;
  String? address;
  String? regulations;
  String? pet_status;
  String? note;
  bool? isMobile;
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
    weight = json['weight'];
    describe = json['describe'];
    check = json['check'];
    address = json['address'];
    regulations = json['regulations'];
    pet_status = json['pet_status'];
    note = json['note'];
    isMobile = json['isMobile'];
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
  String? file_id;
  String? name;
  PetFile.fromJson(Map<String, dynamic> json) {
    file_id = json['file_id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_id'] = file_id;
    data['name'] = name;
    return data;
  }
}
