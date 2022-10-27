class ResponseNewsList {
  GetAllBanTin? getAllBanTin;
  dynamic status;
  String? message;

  ResponseNewsList({this.getAllBanTin});

  ResponseNewsList.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    getAllBanTin = json["getAllBanTin"] == null
        ? null
        : GetAllBanTin.fromJson(json["getAllBanTin"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getAllBanTin != null) {
      data["getAllBanTin"] = getAllBanTin?.toJson();
    }
    return data;
  }
}

class GetAllBanTin {
  List<NewsListItems>? items;
  int? total;

  GetAllBanTin({this.items, this.total});

  GetAllBanTin.fromJson(Map<String, dynamic> json) {
    items = json["items"] == null
        ? null
        : (json["items"] as List)
            .map((e) => NewsListItems.fromJson(e))
            .toList();
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data["items"] = items?.map((e) => e.toJson()).toList();
    }
    data["total"] = total;
    return data;
  }
}

class NewsListItems {
  String? contentItemId;
  String? tieuDe;
  String? publishedUtc;
  PrivateBanTin? privateBanTin;
  String? owner;
  String? noiDung;
  DanhMuc? danhMuc;
  AnhBia? anhBia;
  String? author;
  String? contentType;
  String? createdUtc;
  UsersLike? list;
  PrivateCreator? privateCreator;

  NewsListItems(
      {this.contentItemId,
      this.tieuDe,
      this.publishedUtc,
      this.privateBanTin,
      this.owner,
      this.noiDung,
      this.danhMuc,
      this.anhBia,
      this.author,
      this.contentType,
      this.createdUtc,
      this.list,
      this.privateCreator});

  NewsListItems.fromJson(Map<String, dynamic> json) {
    contentItemId = json["contentItemId"];
    tieuDe = json["tieuDe"];
    publishedUtc = json["publishedUtc"];
    privateBanTin = json["privateBanTin"] == null
        ? null
        : PrivateBanTin.fromJson(json["privateBanTin"]);
    owner = json["owner"];
    noiDung = json["noiDung"];
    danhMuc =
        json["danhMuc"] == null ? null : DanhMuc.fromJson(json["danhMuc"]);
    anhBia = json["anhBia"] == null ? null : AnhBia.fromJson(json["anhBia"]);
    author = json["author"];
    contentType = json["contentType"];
    createdUtc = json["createdUtc"];
    list = json["list"] == null ? null : UsersLike.fromJson(json["list"]);
    privateCreator = json["privateCreator"] == null
        ? null
        : PrivateCreator.fromJson(json["privateCreator"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["contentItemId"] = contentItemId;
    data["tieuDe"] = tieuDe;
    data["publishedUtc"] = publishedUtc;
    if (privateBanTin != null) {
      data["privateBanTin"] = privateBanTin?.toJson();
    }
    data["owner"] = owner;
    data["noiDung"] = noiDung;
    if (danhMuc != null) data["danhMuc"] = danhMuc?.toJson();
    if (anhBia != null) data["anhBia"] = anhBia?.toJson();
    data["author"] = author;
    data["contentType"] = contentType;
    data["createdUtc"] = createdUtc;
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

class AnhBia {
  List<String>? paths;
  List<String>? urls;

  AnhBia({this.paths, this.urls});

  AnhBia.fromJson(Map<String, dynamic> json) {
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
