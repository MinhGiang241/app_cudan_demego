class ResponseTheCuDanList {
  List<TheCuDanItems>? items;
  int? count;
  dynamic status;
  String? message;

  ResponseTheCuDanList({this.items, this.count});

  ResponseTheCuDanList.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    items = json["items"] == null
        ? null
        : (json["items"] as List)
            .map((e) => TheCuDanItems.fromJson(e))
            .toList();
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data["items"] = items?.map((e) => e.toJson()).toList();
    }
    data["count"] = count;
    return data;
  }
}

class TheCuDanItems {
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
  TheCuDan? theCuDan;
  PrivateTheCuDanPart? privateTheCuDanPart;
  ListPart? listPart;
  AliasPart? aliasPart;
  bool? daGuiEmail;

  TheCuDanItems(
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
      this.theCuDan,
      this.privateTheCuDanPart,
      this.listPart,
      this.aliasPart,
      this.daGuiEmail});

  TheCuDanItems.fromJson(Map<String, dynamic> json) {
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
    theCuDan =
        json["TheCuDan"] == null ? null : TheCuDan.fromJson(json["TheCuDan"]);
    privateTheCuDanPart = json["PrivateTheCuDanPart"] == null
        ? null
        : PrivateTheCuDanPart.fromJson(json["PrivateTheCuDanPart"]);
    listPart =
        json["ListPart"] == null ? null : ListPart.fromJson(json["ListPart"]);
    aliasPart = json["AliasPart"] == null
        ? null
        : AliasPart.fromJson(json["AliasPart"]);
    daGuiEmail = json["DaGuiEmail"];
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
    if (theCuDan != null) {
      data["TheCuDan"] = theCuDan?.toJson();
    }
    if (privateTheCuDanPart != null) {
      data["PrivateTheCuDanPart"] = privateTheCuDanPart?.toJson();
    }
    if (listPart != null) {
      data["ListPart"] = listPart?.toJson();
    }
    if (aliasPart != null) {
      data["AliasPart"] = aliasPart?.toJson();
    }
    data["DaGuiEmail"] = daGuiEmail;
    return data;
  }
}

class AliasPart {
  String? alias;

  AliasPart({this.alias});

  AliasPart.fromJson(Map<String, dynamic> json) {
    alias = json["Alias"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Alias"] = alias;
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

class PrivateTheCuDanPart {
  TinhTrang? tinhTrang;
  SoDichVu? soDichVu;
  MaTaiSanKho? maTaiSanKho;
  CreateFrom? createFrom;

  PrivateTheCuDanPart(
      {this.tinhTrang, this.soDichVu, this.maTaiSanKho, this.createFrom});

  PrivateTheCuDanPart.fromJson(Map<String, dynamic> json) {
    tinhTrang = json["TinhTrang"] == null
        ? null
        : TinhTrang.fromJson(json["TinhTrang"]);
    soDichVu =
        json["SoDichVu"] == null ? null : SoDichVu.fromJson(json["SoDichVu"]);
    maTaiSanKho = json["MaTaiSanKho"] == null
        ? null
        : MaTaiSanKho.fromJson(json["MaTaiSanKho"]);
    createFrom = json["CreateFrom"] == null
        ? null
        : CreateFrom.fromJson(json["CreateFrom"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tinhTrang != null) {
      data["TinhTrang"] = tinhTrang?.toJson();
    }
    if (soDichVu != null) {
      data["SoDichVu"] = soDichVu?.toJson();
    }
    if (maTaiSanKho != null) {
      data["MaTaiSanKho"] = maTaiSanKho?.toJson();
    }
    if (createFrom != null) {
      data["CreateFrom"] = createFrom?.toJson();
    }
    return data;
  }
}

class CreateFrom {
  String? text;

  CreateFrom({this.text});

  CreateFrom.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class MaTaiSanKho {
  MaTaiSanKho();

  MaTaiSanKho.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}

class SoDichVu {
  dynamic value;

  SoDichVu({this.value});

  SoDichVu.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class TinhTrang {
  String? text;

  TinhTrang({this.text});

  TinhTrang.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class TheCuDan {
  Id? id;
  ToaNha? toaNha;
  Tang? tang;
  CanHo? canHo;
  ChuThe? chuThe;
  SoThe? soThe;
  SoDienThoai? soDienThoai;

  TheCuDan(
      {this.id,
      this.toaNha,
      this.tang,
      this.canHo,
      this.chuThe,
      this.soThe,
      this.soDienThoai});

  TheCuDan.fromJson(Map<String, dynamic> json) {
    id = json["ID"] == null ? null : Id.fromJson(json["ID"]);
    toaNha = json["ToaNha"] == null ? null : ToaNha.fromJson(json["ToaNha"]);
    tang = json["Tang"] == null ? null : Tang.fromJson(json["Tang"]);
    canHo = json["CanHo"] == null ? null : CanHo.fromJson(json["CanHo"]);
    chuThe = json["ChuThe"] == null ? null : ChuThe.fromJson(json["ChuThe"]);
    soThe = json["SoThe"] == null ? null : SoThe.fromJson(json["SoThe"]);
    soDienThoai = json["SoDienThoai"] == null
        ? null
        : SoDienThoai.fromJson(json["SoDienThoai"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data["ID"] = id?.toJson();
    }
    if (toaNha != null) {
      data["ToaNha"] = toaNha?.toJson();
    }
    if (tang != null) {
      data["Tang"] = tang?.toJson();
    }
    if (canHo != null) {
      data["CanHo"] = canHo?.toJson();
    }
    if (chuThe != null) {
      data["ChuThe"] = chuThe?.toJson();
    }
    if (soThe != null) {
      data["SoThe"] = soThe?.toJson();
    }
    if (soDienThoai != null) {
      data["SoDienThoai"] = soDienThoai?.toJson();
    }
    return data;
  }
}

class SoDienThoai {
  String? text;

  SoDienThoai({this.text});

  SoDienThoai.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class SoThe {
  String? text;

  SoThe({this.text});

  SoThe.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class ChuThe {
  List<String>? contentItemIds;
  List<String>? displayTexts;

  ChuThe({this.contentItemIds, this.displayTexts});

  ChuThe.fromJson(Map<String, dynamic> json) {
    contentItemIds = json["ContentItemIds"] == null
        ? null
        : List<String>.from(json["ContentItemIds"]);
    displayTexts = json["DisplayTexts"] == null
        ? null
        : List<String>.from(json["DisplayTexts"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contentItemIds != null) {
      data["ContentItemIds"] = contentItemIds;
    }
    if (displayTexts != null) {
      data["DisplayTexts"] = displayTexts;
    }
    return data;
  }
}

class CanHo {
  List<String>? contentItemIds;
  List<String>? displayTexts;

  CanHo({this.contentItemIds, this.displayTexts});

  CanHo.fromJson(Map<String, dynamic> json) {
    contentItemIds = json["ContentItemIds"] == null
        ? null
        : List<String>.from(json["ContentItemIds"]);
    displayTexts = json["DisplayTexts"] == null
        ? null
        : List<String>.from(json["DisplayTexts"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contentItemIds != null) {
      data["ContentItemIds"] = contentItemIds;
    }
    if (displayTexts != null) {
      data["DisplayTexts"] = displayTexts;
    }
    return data;
  }
}

class Tang {
  List<String?>? contentItemIds;
  List<String?>? displayTexts;

  Tang({this.contentItemIds, this.displayTexts});

  Tang.fromJson(Map<String, dynamic> json) {
    contentItemIds = json["ContentItemIds"] == null
        ? null
        : List<String?>.from(json["ContentItemIds"]);
    displayTexts = json["DisplayTexts"] == null
        ? null
        : List<String?>.from(json["DisplayTexts"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contentItemIds != null) {
      data["ContentItemIds"] = contentItemIds;
    }
    if (displayTexts != null) {
      data["DisplayTexts"] = displayTexts;
    }
    return data;
  }
}

class ToaNha {
  List<String?>? contentItemIds;
  List<String?>? displayTexts;

  ToaNha({this.contentItemIds, this.displayTexts});

  ToaNha.fromJson(Map<String, dynamic> json) {
    contentItemIds = json["ContentItemIds"] == null
        ? null
        : List<String?>.from(json["ContentItemIds"]);
    displayTexts = json["DisplayTexts"] == null
        ? null
        : List<String?>.from(json["DisplayTexts"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contentItemIds != null) {
      data["ContentItemIds"] = contentItemIds;
    }
    if (displayTexts != null) {
      data["DisplayTexts"] = displayTexts;
    }
    return data;
  }
}

class Id {
  dynamic value;

  Id({this.value});

  Id.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}
