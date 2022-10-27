class ResponseApartment {
  List<Apartments>? apartments;
  dynamic status;
  String? message;

  ResponseApartment({this.apartments});

  ResponseApartment.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    apartments = json["apartments"] == null
        ? null
        : (json["apartments"] as List)
            .map((e) => Apartments.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (apartments != null) {
      data["apartments"] = apartments?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Apartments {
  String? id;
  String? name;
  String? detail;
  List<FloorPlan>? floorPlan;

  Apartments({this.id, this.name, this.detail, this.floorPlan});

  Apartments.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    detail = json["detail"];
    floorPlan = json["floorPlan"] == null
        ? null
        : (json["floorPlan"] as List)
            .map((e) => FloorPlan.fromJson(e))
            .toList();
    if (floorPlan != null) {
      if (floorPlan!.isNotEmpty) {
        floorPlan?.forEach((element) {
          element.apartmentId = id;
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["detail"] = detail;
    if (floorPlan != null) {
      data["floorPlan"] = floorPlan?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class FloorPlan {
  String? id;
  String? apartmentId;
  String? name;
  String? detail;
  dynamic floorPlan;

  FloorPlan({this.id, this.name, this.detail, this.floorPlan});

  FloorPlan.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    apartmentId = json["apartmentId"];
    name = json["name"];
    detail = json["detail"];
    floorPlan = json["floorPlan"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["apartmentId"] = apartmentId;
    data["name"] = name;
    data["detail"] = detail;
    data["floorPlan"] = floorPlan;
    return data;
  }
}
