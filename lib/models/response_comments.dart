class ResponseComments {
  GetCommentBanTin? getCommentBanTin;
  dynamic status;
  String? message;

  ResponseComments({this.getCommentBanTin});

  ResponseComments.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    getCommentBanTin = json["getCommentBanTin"] == null
        ? null
        : GetCommentBanTin.fromJson(json["getCommentBanTin"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getCommentBanTin != null) {
      data["getCommentBanTin"] = getCommentBanTin?.toJson();
    }
    return data;
  }
}

class GetCommentBanTin {
  int? total;
  List<CommentItems>? items;

  GetCommentBanTin({this.total, this.items});

  GetCommentBanTin.fromJson(Map<String, dynamic> json) {
    total = json["total"];
    items = json["items"] == null
        ? null
        : (json["items"] as List).map((e) => CommentItems.fromJson(e)).toList();
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

class CommentItems {
  String? contentItemId;
  String? contentType;
  String? displayText;
  String? createdUtc;
  String? publishedUtc;
  String? noiDung;
  PrivateCreator? privateCreator;
  PrivateBanTin? privateBanTin;
  UsersLike? list;

  CommentItems(
      {this.contentItemId,
      this.contentType,
      this.displayText,
      this.createdUtc,
      this.publishedUtc,
      this.noiDung,
      this.privateCreator,
      this.privateBanTin,
      this.list});

  CommentItems.fromJson(Map<String, dynamic> json) {
    contentItemId = json["contentItemId"];
    contentType = json["contentType"];
    displayText = json["displayText"];
    createdUtc = json["createdUtc"];
    publishedUtc = json["publishedUtc"];
    noiDung = json["noiDung"];
    privateCreator = json["privateCreator"] == null
        ? null
        : PrivateCreator.fromJson(json["privateCreator"]);
    privateBanTin = json["privateBanTin"] == null
        ? null
        : PrivateBanTin.fromJson(json["privateBanTin"]);
    list = json["list"] == null ? null : UsersLike.fromJson(json["list"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["contentItemId"] = contentItemId;
    data["contentType"] = contentType;
    data["displayText"] = displayText;
    data["createdUtc"] = createdUtc;
    data["publishedUtc"] = publishedUtc;
    data["noiDung"] = noiDung;
    if (privateCreator != null) {
      data["privateCreator"] = privateCreator?.toJson();
    }
    if (privateBanTin != null) {
      data["privateBanTin"] = privateBanTin?.toJson();
    }
    if (list != null) {
      data["list"] = list?.toJson();
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

class PrivateBanTin {
  String? banTinId;
  dynamic soLuongComment;
  dynamic soLuongLike;

  PrivateBanTin({this.banTinId, this.soLuongComment, this.soLuongLike});

  PrivateBanTin.fromJson(Map<String, dynamic> json) {
    banTinId = json["banTinId"];
    soLuongComment = json["soLuongComment"];
    soLuongLike = json["soLuongLike"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["banTinId"] = banTinId;
    data["soLuongComment"] = soLuongComment;
    data["soLuongLike"] = soLuongLike;
    return data;
  }
}

class PrivateCreator {
  String? fullName;
  AnhDaiDien? anhDaiDien;

  PrivateCreator({this.fullName, this.anhDaiDien});

  PrivateCreator.fromJson(Map<String, dynamic> json) {
    fullName = json["fullName"];
    anhDaiDien = json["anhDaiDien"] == null
        ? null
        : AnhDaiDien.fromJson(json["anhDaiDien"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["fullName"] = fullName;
    if (anhDaiDien != null) {
      data["anhDaiDien"] = anhDaiDien?.toJson();
    }
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
