class ResponseNewsDetails {
  String? contentItemId;
  String? contentItemVersionId;
  String? contentType;
  String? displayText;
  bool? latest;
  bool? published;
  String? modifiedUtc;
  String? publishedUtc;
  String? createdUtc;
  String? owner;
  String? author;
  BanTin? banTin;
  CommonPart? commonPart;
  TitlePart? titlePart;
  PrivateBanTinPart? privateBanTinPart;
  ListPart? listPart;
  dynamic status;
  String? message;

  ResponseNewsDetails(
      {this.contentItemId,
      this.contentItemVersionId,
      this.contentType,
      this.displayText,
      this.latest,
      this.published,
      this.modifiedUtc,
      this.publishedUtc,
      this.createdUtc,
      this.owner,
      this.author,
      this.banTin,
      this.commonPart,
      this.titlePart,
      this.privateBanTinPart,
      this.listPart});

  ResponseNewsDetails.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    contentItemId = json["ContentItemId"];
    contentItemVersionId = json["ContentItemVersionId"];
    contentType = json["ContentType"];
    displayText = json["DisplayText"];
    latest = json["Latest"];
    published = json["Published"];
    modifiedUtc = json["ModifiedUtc"];
    publishedUtc = json["PublishedUtc"];
    createdUtc = json["CreatedUtc"];
    owner = json["Owner"];
    author = json["Author"];
    banTin = json["BanTin"] == null ? null : BanTin.fromJson(json["BanTin"]);
    commonPart = json["CommonPart"] == null
        ? null
        : CommonPart.fromJson(json["CommonPart"]);
    titlePart = json["TitlePart"] == null
        ? null
        : TitlePart.fromJson(json["TitlePart"]);
    privateBanTinPart = json["PrivateBanTinPart"] == null
        ? null
        : PrivateBanTinPart.fromJson(json["PrivateBanTinPart"]);
    listPart =
        json["ListPart"] == null ? null : ListPart.fromJson(json["ListPart"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["ContentItemId"] = contentItemId;
    data["ContentItemVersionId"] = contentItemVersionId;
    data["ContentType"] = contentType;
    data["DisplayText"] = displayText;
    data["Latest"] = latest;
    data["Published"] = published;
    data["ModifiedUtc"] = modifiedUtc;
    data["PublishedUtc"] = publishedUtc;
    data["CreatedUtc"] = createdUtc;
    data["Owner"] = owner;
    data["Author"] = author;
    if (banTin != null) {
      data["BanTin"] = banTin?.toJson();
    }
    if (commonPart != null) {
      data["CommonPart"] = commonPart?.toJson();
    }
    if (titlePart != null) {
      data["TitlePart"] = titlePart?.toJson();
    }
    if (privateBanTinPart != null) {
      data["PrivateBanTinPart"] = privateBanTinPart?.toJson();
    }
    if (listPart != null) {
      data["ListPart"] = listPart?.toJson();
    }
    return data;
  }
}

class ListPart {
  ListPart();

  ListPart.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}

class PrivateBanTinPart {
  SoLuongLike? soLuongLike;
  SoLuongComment? soLuongComment;

  PrivateBanTinPart({this.soLuongLike, this.soLuongComment});

  PrivateBanTinPart.fromJson(Map<String, dynamic> json) {
    soLuongLike = json["SoLuongLike"] == null
        ? null
        : SoLuongLike.fromJson(json["SoLuongLike"]);
    soLuongComment = json["SoLuongComment"] == null
        ? null
        : SoLuongComment.fromJson(json["SoLuongComment"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (soLuongLike != null) {
      data["SoLuongLike"] = soLuongLike?.toJson();
    }
    if (soLuongComment != null) {
      data["SoLuongComment"] = soLuongComment?.toJson();
    }
    return data;
  }
}

class SoLuongComment {
  dynamic value;

  SoLuongComment({this.value});

  SoLuongComment.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class SoLuongLike {
  dynamic value;

  SoLuongLike({this.value});

  SoLuongLike.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class TitlePart {
  String? title;

  TitlePart({this.title});

  TitlePart.fromJson(Map<String, dynamic> json) {
    title = json["Title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Title"] = title;
    return data;
  }
}

class CommonPart {
  Owner? owner;

  CommonPart({this.owner});

  CommonPart.fromJson(Map<String, dynamic> json) {
    owner = json["Owner"] == null ? null : Owner.fromJson(json["Owner"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (owner != null) {
      data["Owner"] = owner?.toJson();
    }
    return data;
  }
}

class Owner {
  List<String>? userIds;
  List<String>? userNames;

  Owner({this.userIds, this.userNames});

  Owner.fromJson(Map<String, dynamic> json) {
    userIds =
        json["UserIds"] == null ? null : List<String>.from(json["UserIds"]);
    userNames =
        json["UserNames"] == null ? null : List<String>.from(json["UserNames"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userIds != null) {
      data["UserIds"] = userIds;
    }
    if (userNames != null) {
      data["UserNames"] = userNames;
    }
    return data;
  }
}

class BanTin {
  NoiDung? noiDung;
  DanhMuc? danhMuc;
  TieuDe? tieuDe;
  AnhBia? anhBia;

  BanTin({this.noiDung, this.danhMuc, this.tieuDe, this.anhBia});

  BanTin.fromJson(Map<String, dynamic> json) {
    noiDung =
        json["NoiDung"] == null ? null : NoiDung.fromJson(json["NoiDung"]);
    danhMuc =
        json["DanhMuc"] == null ? null : DanhMuc.fromJson(json["DanhMuc"]);
    tieuDe = json["TieuDe"] == null ? null : TieuDe.fromJson(json["TieuDe"]);
    anhBia = json["AnhBia"] == null ? null : AnhBia.fromJson(json["AnhBia"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (noiDung != null) {
      data["NoiDung"] = noiDung?.toJson();
    }
    if (danhMuc != null) {
      data["DanhMuc"] = danhMuc?.toJson();
    }
    if (tieuDe != null) {
      data["TieuDe"] = tieuDe?.toJson();
    }
    if (anhBia != null) {
      data["AnhBia"] = anhBia?.toJson();
    }
    return data;
  }
}

class AnhBia {
  List<String>? paths;
  List<String>? mediaTexts;

  AnhBia({this.paths, this.mediaTexts});

  AnhBia.fromJson(Map<String, dynamic> json) {
    paths = json["Paths"] == null ? null : List<String>.from(json["Paths"]);
    mediaTexts = json["MediaTexts"] == null
        ? null
        : List<String>.from(json["MediaTexts"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paths != null) {
      data["Paths"] = paths;
    }
    if (mediaTexts != null) {
      data["MediaTexts"] = mediaTexts;
    }
    return data;
  }
}

class TieuDe {
  String? text;

  TieuDe({this.text});

  TieuDe.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class DanhMuc {
  String? taxonomyContentItemId;
  List<String>? termContentItemIds;
  List<String>? tagNames;

  DanhMuc({this.taxonomyContentItemId, this.termContentItemIds, this.tagNames});

  DanhMuc.fromJson(Map<String, dynamic> json) {
    taxonomyContentItemId = json["TaxonomyContentItemId"];
    termContentItemIds = json["TermContentItemIds"] == null
        ? null
        : List<String>.from(json["TermContentItemIds"]);
    tagNames =
        json["TagNames"] == null ? null : List<String>.from(json["TagNames"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["TaxonomyContentItemId"] = taxonomyContentItemId;
    if (termContentItemIds != null) {
      data["TermContentItemIds"] = termContentItemIds;
    }
    if (tagNames != null) {
      data["TagNames"] = tagNames;
    }
    return data;
  }
}

class NoiDung {
  String? text;

  NoiDung({this.text});

  NoiDung.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}
