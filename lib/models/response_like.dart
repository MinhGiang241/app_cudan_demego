class ResponseLike {
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
  LikeBanTin? likeBanTin;
  CommonPart? commonPart;
  TitlePart? titlePart;
  PrivateCreatorPart? privateCreatorPart;
  ContainedPart? containedPart;

  ResponseLike(
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
      this.likeBanTin,
      this.commonPart,
      this.titlePart,
      this.privateCreatorPart,
      this.containedPart});

  ResponseLike.fromJson(Map<String, dynamic> json) {
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
    likeBanTin = json["LikeBanTin"] == null
        ? null
        : LikeBanTin.fromJson(json["LikeBanTin"]);
    commonPart = json["CommonPart"] == null
        ? null
        : CommonPart.fromJson(json["CommonPart"]);
    titlePart = json["TitlePart"] == null
        ? null
        : TitlePart.fromJson(json["TitlePart"]);
    privateCreatorPart = json["PrivateCreatorPart"] == null
        ? null
        : PrivateCreatorPart.fromJson(json["PrivateCreatorPart"]);
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
    if (likeBanTin != null) {
      data["LikeBanTin"] = likeBanTin?.toJson();
    }
    if (commonPart != null) {
      data["CommonPart"] = commonPart?.toJson();
    }
    if (titlePart != null) {
      data["TitlePart"] = titlePart?.toJson();
    }
    if (privateCreatorPart != null) {
      data["PrivateCreatorPart"] = privateCreatorPart?.toJson();
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

class LikeBanTin {
  LikeBanTin();

  LikeBanTin.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}
