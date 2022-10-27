class ResponseBanTinDuAnList {
  GetBanTinDuAn? getBanTinDuAn;
  dynamic status;
  String? message;

  ResponseBanTinDuAnList({this.getBanTinDuAn});

  ResponseBanTinDuAnList.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    getBanTinDuAn = json["getBanTinDuAn"] == null
        ? null
        : GetBanTinDuAn.fromJson(json["getBanTinDuAn"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getBanTinDuAn != null) data["getBanTinDuAn"] = getBanTinDuAn?.toJson();
    return data;
  }
}

class GetBanTinDuAn {
  int? total;
  List<BTDAItems>? items;

  GetBanTinDuAn({this.total, this.items});

  GetBanTinDuAn.fromJson(Map<String, dynamic> json) {
    total = json["total"];
    items = json["items"] == null
        ? null
        : (json["items"] as List).map((e) => BTDAItems.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["total"] = total;
    if (items != null) data["items"] = items?.map((e) => e.toJson()).toList();
    return data;
  }
}

class BTDAItems {
  String? contentItemId;
  String? contentType;
  String? createdUtc;
  String? displayText;
  HinhAnh? hinhAnh;
  String? noiDung;
  String? owner;
  PrivateBanTin? privateBanTin;
  String? publishedUtc;
  String? tieuDe;
  DanhMuc? danhMuc;
  UsersLike? list;
  PrivateCreator? privateCreator;

  BTDAItems(
      {this.contentItemId,
      this.contentType,
      this.createdUtc,
      this.displayText,
      this.hinhAnh,
      this.noiDung,
      this.owner,
      this.privateBanTin,
      this.publishedUtc,
      this.tieuDe,
      this.danhMuc,
      this.list,
      this.privateCreator});

  BTDAItems.fromJson(Map<String, dynamic> json) {
    contentItemId = json["contentItemId"];
    contentType = json["contentType"];
    createdUtc = json["createdUtc"];
    displayText = json["displayText"];
    hinhAnh =
        json["hinhAnh"] == null ? null : HinhAnh.fromJson(json["hinhAnh"]);
    noiDung = json["noiDung"];
    owner = json["owner"];
    privateBanTin = json["privateBanTin"] == null
        ? null
        : PrivateBanTin.fromJson(json["privateBanTin"]);
    publishedUtc = json["publishedUtc"];
    tieuDe = json["tieuDe"];
    danhMuc =
        json["danhMuc"] == null ? null : DanhMuc.fromJson(json["danhMuc"]);
    list = json["list"] == null ? null : UsersLike.fromJson(json["list"]);
    privateCreator = json["privateCreator"] == null
        ? null
        : PrivateCreator.fromJson(json["privateCreator"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["contentItemId"] = contentItemId;
    data["contentType"] = contentType;
    data["createdUtc"] = createdUtc;
    data["displayText"] = displayText;
    if (hinhAnh != null) data["hinhAnh"] = hinhAnh?.toJson();
    data["noiDung"] = noiDung;
    data["owner"] = owner;
    if (privateBanTin != null) data["privateBanTin"] = privateBanTin?.toJson();
    data["publishedUtc"] = publishedUtc;
    data["tieuDe"] = tieuDe;
    if (danhMuc != null) data["danhMuc"] = danhMuc?.toJson();
    if (list != null) data["list"] = list?.toJson();
    if (privateCreator != null) {
      data["privateCreator"] = privateCreator?.toJson();
    }
    return data;
  }
}

class PrivateCreator {
  AnhDaiDien? anhDaiDien;
  String? creatorId;
  String? fullName;

  PrivateCreator({this.anhDaiDien, this.creatorId, this.fullName});

  PrivateCreator.fromJson(Map<String, dynamic> json) {
    anhDaiDien = json["anhDaiDien"] == null
        ? null
        : AnhDaiDien.fromJson(json["anhDaiDien"]);
    creatorId = json["creatorId"];
    fullName = json["fullName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (anhDaiDien != null) data["anhDaiDien"] = anhDaiDien?.toJson();
    data["creatorId"] = creatorId;
    data["fullName"] = fullName;
    return data;
  }
}

class AnhDaiDien {
  List<String>? paths;
  List<String>? urls;

  AnhDaiDien({this.paths, this.urls});

  AnhDaiDien.fromJson(Map<String, dynamic> json) {
    paths = json["paths"] == null ? null : List<String>.from(json["paths"]);
    urls = json["urls"] == null ? null : List<String>.from(json["urls"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paths != null) data["paths"] = paths;
    if (urls != null) data["urls"] = urls;
    return data;
  }
}

class UsersLike {
  List<ContentItems>? contentItems;

  UsersLike({this.contentItems});

  UsersLike.fromJson(Map<String, dynamic> json) {
    contentItems = json["contentItems"] == null
        ? null
        : (json["contentItems"] as List)
            .map((e) => ContentItems.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contentItems != null) {
      data["contentItems"] = contentItems?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ContentItems {
  String? owner;
  String? contentItemId;

  ContentItems({this.owner, this.contentItemId});

  ContentItems.fromJson(Map<String, dynamic> json) {
    owner = json["owner"];
    contentItemId = json["contentItemId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["owner"] = owner;
    data["contentItemId"] = contentItemId;
    return data;
  }
}

class DanhMuc {
  String? taxonomyContentItemId;
  List<String>? termContentItemIds;

  DanhMuc({this.taxonomyContentItemId, this.termContentItemIds});

  DanhMuc.fromJson(Map<String, dynamic> json) {
    taxonomyContentItemId = json["taxonomyContentItemId"];
    termContentItemIds = json["termContentItemIds"] == null
        ? null
        : List<String>.from(json["termContentItemIds"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["taxonomyContentItemId"] = taxonomyContentItemId;
    if (termContentItemIds != null) {
      data["termContentItemIds"] = termContentItemIds;
    }
    return data;
  }
}

class PrivateBanTin {
  dynamic soLuongComment;
  dynamic soLuongLike;

  PrivateBanTin({this.soLuongComment, this.soLuongLike});

  PrivateBanTin.fromJson(Map<String, dynamic> json) {
    soLuongComment = json["soLuongComment"];
    soLuongLike = json["soLuongLike"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["soLuongComment"] = soLuongComment;
    data["soLuongLike"] = soLuongLike;
    return data;
  }
}

class HinhAnh {
  List<String>? paths;
  List<String>? urls;

  HinhAnh({this.paths, this.urls});

  HinhAnh.fromJson(Map<String, dynamic> json) {
    paths = json["paths"] == null ? null : List<String>.from(json["paths"]);
    urls = json["urls"] == null ? null : List<String>.from(json["urls"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paths != null) data["paths"] = paths;
    if (urls != null) data["urls"] = urls;
    return data;
  }
}
