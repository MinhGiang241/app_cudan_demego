class ResponseCreateComment {
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
  CommentBanTin? commentBanTin;
  CommonPart? commonPart;
  TitlePart? titlePart;
  ListPart? listPart;
  PrivateCreatorPart? privateCreatorPart;
  PrivateBanTinPart? privateBanTinPart;
  ContainedPart? containedPart;
  dynamic status;
  String? message;

  ResponseCreateComment(
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
      this.commentBanTin,
      this.commonPart,
      this.titlePart,
      this.listPart,
      this.privateCreatorPart,
      this.privateBanTinPart,
      this.containedPart});

  ResponseCreateComment.fromJson(Map<String, dynamic> json) {
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
    commentBanTin = json["CommentBanTin"] == null
        ? null
        : CommentBanTin.fromJson(json["CommentBanTin"]);
    commonPart = json["CommonPart"] == null
        ? null
        : CommonPart.fromJson(json["CommonPart"]);
    titlePart = json["TitlePart"] == null
        ? null
        : TitlePart.fromJson(json["TitlePart"]);
    listPart =
        json["ListPart"] == null ? null : ListPart.fromJson(json["ListPart"]);
    privateCreatorPart = json["PrivateCreatorPart"] == null
        ? null
        : PrivateCreatorPart.fromJson(json["PrivateCreatorPart"]);
    privateBanTinPart = json["PrivateBanTinPart"] == null
        ? null
        : PrivateBanTinPart.fromJson(json["PrivateBanTinPart"]);
    containedPart = json["ContainedPart"] == null
        ? null
        : ContainedPart.fromJson(json["ContainedPart"]);
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
    if (commentBanTin != null) {
      data["CommentBanTin"] = commentBanTin?.toJson();
    }
    if (commonPart != null) {
      data["CommonPart"] = commonPart?.toJson();
    }
    if (titlePart != null) {
      data["TitlePart"] = titlePart?.toJson();
    }
    if (listPart != null) {
      data["ListPart"] = listPart?.toJson();
    }
    if (privateCreatorPart != null) {
      data["PrivateCreatorPart"] = privateCreatorPart?.toJson();
    }
    if (privateBanTinPart != null) {
      data["PrivateBanTinPart"] = privateBanTinPart?.toJson();
    }
    if (containedPart != null) {
      data["ContainedPart"] = containedPart?.toJson();
    }
    return data;
  }
}

class ContainedPart {
  String? listContentItemId;

  ContainedPart({this.listContentItemId});

  ContainedPart.fromJson(Map<String, dynamic> json) {
    listContentItemId = json["ListContentItemId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["ListContentItemId"] = listContentItemId;
    return data;
  }
}

class PrivateBanTinPart {
  SoLuongLike? soLuongLike;
  SoLuongComment? soLuongComment;
  BanTinId? banTinId;

  PrivateBanTinPart({this.soLuongLike, this.soLuongComment, this.banTinId});

  PrivateBanTinPart.fromJson(Map<String, dynamic> json) {
    soLuongLike = json["SoLuongLike"] == null
        ? null
        : SoLuongLike.fromJson(json["SoLuongLike"]);
    soLuongComment = json["SoLuongComment"] == null
        ? null
        : SoLuongComment.fromJson(json["SoLuongComment"]);
    banTinId =
        json["BanTinId"] == null ? null : BanTinId.fromJson(json["BanTinId"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (soLuongLike != null) {
      data["SoLuongLike"] = soLuongLike?.toJson();
    }
    if (soLuongComment != null) {
      data["SoLuongComment"] = soLuongComment?.toJson();
    }
    if (banTinId != null) {
      data["BanTinId"] = banTinId?.toJson();
    }
    return data;
  }
}

class BanTinId {
  String? text;

  BanTinId({this.text});

  BanTinId.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
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

class PrivateCreatorPart {
  FullName? fullName;
  AnhDaiDien? anhDaiDien;
  CreatorId? creatorId;

  PrivateCreatorPart({this.fullName, this.anhDaiDien, this.creatorId});

  PrivateCreatorPart.fromJson(Map<String, dynamic> json) {
    fullName =
        json["FullName"] == null ? null : FullName.fromJson(json["FullName"]);
    anhDaiDien = json["AnhDaiDien"] == null
        ? null
        : AnhDaiDien.fromJson(json["AnhDaiDien"]);
    creatorId = json["CreatorId"] == null
        ? null
        : CreatorId.fromJson(json["CreatorId"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fullName != null) {
      data["FullName"] = fullName?.toJson();
    }
    if (anhDaiDien != null) {
      data["AnhDaiDien"] = anhDaiDien?.toJson();
    }
    if (creatorId != null) {
      data["CreatorId"] = creatorId?.toJson();
    }
    return data;
  }
}

class CreatorId {
  String? text;

  CreatorId({this.text});

  CreatorId.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class AnhDaiDien {
  List<String>? paths;
  List<dynamic>? mediaTexts;

  AnhDaiDien({this.paths, this.mediaTexts});

  AnhDaiDien.fromJson(Map<String, dynamic> json) {
    paths = json["Paths"] == null ? null : List<String>.from(json["Paths"]);
    mediaTexts = json["MediaTexts"] ?? [];
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

class FullName {
  String? text;

  FullName({this.text});

  FullName.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
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
  CommonPart();

  CommonPart.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}

class CommentBanTin {
  NoiDung? noiDung;

  CommentBanTin({this.noiDung});

  CommentBanTin.fromJson(Map<String, dynamic> json) {
    noiDung =
        json["NoiDung"] == null ? null : NoiDung.fromJson(json["NoiDung"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (noiDung != null) {
      data["NoiDung"] = noiDung?.toJson();
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
