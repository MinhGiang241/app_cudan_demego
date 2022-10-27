class ResponseForums {
  GetAllBanTinDienDan? getAllBanTinDienDan;
  dynamic status;
  String? message;
  ResponseForums({this.getAllBanTinDienDan});

  ResponseForums.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    getAllBanTinDienDan = json["getAllBanTinDienDan"] == null
        ? null
        : GetAllBanTinDienDan.fromJson(json["getAllBanTinDienDan"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getAllBanTinDienDan != null) {
      data["getAllBanTinDienDan"] = getAllBanTinDienDan?.toJson();
    }
    return data;
  }
}

class GetAllBanTinDienDan {
  int? total;
  List<ForumItems>? items;

  GetAllBanTinDienDan({this.total, this.items});

  GetAllBanTinDienDan.fromJson(Map<String, dynamic> json) {
    total = json["total"];
    items = json["items"] == null
        ? null
        : (json["items"] as List).map((e) => ForumItems.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["total"] = total;
    if (items != null) {
      data["items"] = items?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ForumItems {
  String? contentItemId;
  String? createdUtc;
  String? displayText;
  String? modifiedUtc;
  String? publishedUtc;
  dynamic tieuDe;
  DanhMuc? danhMuc;
  String? noiDung;
  HinhAnh? hinhAnh;
  String? owner;
  PrivateBanTin? privateBanTin;
  UsersLike? list;
  PrivateCreator? privateCreator;

  ForumItems(
      {this.contentItemId,
      this.createdUtc,
      this.displayText,
      this.modifiedUtc,
      this.publishedUtc,
      this.tieuDe,
      this.danhMuc,
      this.noiDung,
      this.hinhAnh,
      this.owner,
      this.privateBanTin,
      this.list,
      this.privateCreator});

  ForumItems.fromJson(Map<String, dynamic> json) {
    contentItemId = json["contentItemId"];
    createdUtc = json["createdUtc"];
    displayText = json["displayText"];
    modifiedUtc = json["modifiedUtc"];
    publishedUtc = json["publishedUtc"];
    tieuDe = json["tieuDe"];
    danhMuc =
        json["danhMuc"] == null ? null : DanhMuc.fromJson(json["danhMuc"]);
    noiDung = json["noiDung"];
    hinhAnh =
        json["hinhAnh"] == null ? null : HinhAnh.fromJson(json["hinhAnh"]);
    owner = json["owner"];
    privateBanTin = json["privateBanTin"] == null
        ? null
        : PrivateBanTin.fromJson(json["privateBanTin"]);
    list = json["list"] == null ? null : UsersLike.fromJson(json["list"]);
    privateCreator = json["privateCreator"] == null
        ? null
        : PrivateCreator.fromJson(json["privateCreator"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["createdUtc"] = createdUtc;
    data["displayText"] = displayText;
    data["modifiedUtc"] = modifiedUtc;
    data["publishedUtc"] = publishedUtc;
    data["tieuDe"] = tieuDe;
    if (danhMuc != null) {
      data["danhMuc"] = danhMuc?.toJson();
    }
    data["noiDung"] = noiDung;
    if (hinhAnh != null) {
      data["hinhAnh"] = hinhAnh?.toJson();
    }
    data["owner"] = owner;
    if (privateBanTin != null) {
      data["privateBanTin"] = privateBanTin?.toJson();
    }
    if (list != null) {
      data["list"] = list?.toJson();
    }
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
    if (anhDaiDien != null) {
      data["anhDaiDien"] = anhDaiDien?.toJson();
    }
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
    if (paths != null) {
      data["paths"] = paths;
    }
    if (urls != null) {
      data["urls"] = urls;
    }
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
  String? contentItemId;
  String? owner;

  ContentItems({this.contentItemId, this.owner});

  ContentItems.fromJson(Map<String, dynamic> json) {
    contentItemId = json["contentItemId"];
    owner = json["owner"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["contentItemId"] = contentItemId;
    data["owner"] = owner;
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

  updateComment(length) {
    soLuongComment = length;
  }

  removeComment() {
    if (soLuongComment != null) {
      soLuongComment--;
    }
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
    if (paths != null) {
      data["paths"] = paths;
    }
    if (urls != null) {
      data["urls"] = urls;
    }
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
