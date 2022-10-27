class ResponseParcelList {
  List<ParcelItems>? items;
  int? count;
  dynamic status;
  String? message;

  ResponseParcelList({this.items, this.count});

  ResponseParcelList.fromJson(Map<String, dynamic> json) {
    items = json["items"] == null
        ? null
        : (json["items"] as List).map((e) => ParcelItems.fromJson(e)).toList();
    count = json["count"];
    status = json["status"];
    message = json["message"];
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

class ParcelItems {
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
  BuuPham? buuPham;
  TitlePart? titlePart;
  GiaoBuuPham? giaoBuuPham;
  PrivateBuuPham? privateBuuPham;

  ParcelItems(
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
      this.buuPham,
      this.titlePart,
      this.giaoBuuPham,
      this.privateBuuPham});

  ParcelItems.fromJson(Map<String, dynamic> json) {
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
    buuPham =
        json["BuuPham"] == null ? null : BuuPham.fromJson(json["BuuPham"]);
    titlePart = json["TitlePart"] == null
        ? null
        : TitlePart.fromJson(json["TitlePart"]);
    giaoBuuPham = json["GiaoBuuPham"] == null
        ? null
        : GiaoBuuPham.fromJson(json["GiaoBuuPham"]);
    privateBuuPham = json["PrivateBuuPham"] == null
        ? null
        : PrivateBuuPham.fromJson(json["PrivateBuuPham"]);
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
    if (buuPham != null) {
      data["BuuPham"] = buuPham?.toJson();
    }
    if (titlePart != null) {
      data["TitlePart"] = titlePart?.toJson();
    }
    if (giaoBuuPham != null) {
      data["GiaoBuuPham"] = giaoBuuPham?.toJson();
    }
    if (privateBuuPham != null) {
      data["PrivateBuuPham"] = privateBuuPham?.toJson();
    }
    return data;
  }
}

class PrivateBuuPham {
  TrangThai? trangThai;

  PrivateBuuPham({this.trangThai});

  PrivateBuuPham.fromJson(Map<String, dynamic> json) {
    trangThai = json["TrangThai"] == null
        ? null
        : TrangThai.fromJson(json["TrangThai"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (trangThai != null) {
      data["TrangThai"] = trangThai?.toJson();
    }
    return data;
  }
}

class TrangThai {
  String? text;

  TrangThai({this.text});

  TrangThai.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class GiaoBuuPham {
  List<dynamic>? contentItems;
  Trangthai? trangthai;

  GiaoBuuPham({this.contentItems, this.trangthai});

  GiaoBuuPham.fromJson(Map<String, dynamic> json) {
    contentItems = json["ContentItems"] ?? [];
    trangthai = json["Trangthai"] == null
        ? null
        : Trangthai.fromJson(json["Trangthai"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contentItems != null) {
      data["ContentItems"] = contentItems;
    }
    if (trangthai != null) {
      data["Trangthai"] = trangthai?.toJson();
    }
    return data;
  }
}

class Trangthai {
  dynamic text;

  Trangthai({this.text});

  Trangthai.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class TitlePart {
  dynamic title;

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

class BuuPham {
  Id? id;
  ChotTruc? chotTruc;
  dynamic toa;
  Tang? tang;
  dynamic matBang;
  NguoiNhan? nguoiNhan;
  SoDienThoai? soDienThoai;
  NguoiGui? nguoiGui;
  SoDienThoaiNguoiGui? soDienThoaiNguoiGui;
  ThoiGianGui? thoiGianGui;
  HinhAnh? hinhAnh;
  GhiChu? ghiChu;
  TenBuuPham? tenBuuPham;
  ToaNha? toaNha;
  CanHo? canHo;

  BuuPham(
      {this.id,
      this.chotTruc,
      this.toa,
      this.tang,
      this.matBang,
      this.nguoiNhan,
      this.soDienThoai,
      this.nguoiGui,
      this.soDienThoaiNguoiGui,
      this.thoiGianGui,
      this.hinhAnh,
      this.ghiChu,
      this.tenBuuPham,
      this.toaNha,
      this.canHo});

  BuuPham.fromJson(Map<String, dynamic> json) {
    id = json["ID"] == null ? null : Id.fromJson(json["ID"]);
    chotTruc =
        json["ChotTruc"] == null ? null : ChotTruc.fromJson(json["ChotTruc"]);
    toa = json["Toa"];
    tang = json["Tang"] == null ? null : Tang.fromJson(json["Tang"]);
    matBang = json["MatBang"];
    nguoiNhan = json["NguoiNhan"] == null
        ? null
        : NguoiNhan.fromJson(json["NguoiNhan"]);
    soDienThoai = json["SoDienThoai"] == null
        ? null
        : SoDienThoai.fromJson(json["SoDienThoai"]);
    nguoiGui =
        json["NguoiGui"] == null ? null : NguoiGui.fromJson(json["NguoiGui"]);
    soDienThoaiNguoiGui = json["SoDienThoaiNguoiGui"] == null
        ? null
        : SoDienThoaiNguoiGui.fromJson(json["SoDienThoaiNguoiGui"]);
    thoiGianGui = json["ThoiGianGui"] == null
        ? null
        : ThoiGianGui.fromJson(json["ThoiGianGui"]);
    hinhAnh =
        json["HinhAnh"] == null ? null : HinhAnh.fromJson(json["HinhAnh"]);
    ghiChu = json["GhiChu"] == null ? null : GhiChu.fromJson(json["GhiChu"]);
    tenBuuPham = json["TenBuuPham"] == null
        ? null
        : TenBuuPham.fromJson(json["TenBuuPham"]);
    toaNha = json["ToaNha"] == null ? null : ToaNha.fromJson(json["ToaNha"]);
    canHo = json["CanHo"] == null ? null : CanHo.fromJson(json["CanHo"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data["ID"] = id?.toJson();
    }
    if (chotTruc != null) {
      data["ChotTruc"] = chotTruc?.toJson();
    }
    data["Toa"] = toa;
    if (tang != null) {
      data["Tang"] = tang?.toJson();
    }
    data["MatBang"] = matBang;
    if (nguoiNhan != null) {
      data["NguoiNhan"] = nguoiNhan?.toJson();
    }
    if (soDienThoai != null) {
      data["SoDienThoai"] = soDienThoai?.toJson();
    }
    if (nguoiGui != null) {
      data["NguoiGui"] = nguoiGui?.toJson();
    }
    if (soDienThoaiNguoiGui != null) {
      data["SoDienThoaiNguoiGui"] = soDienThoaiNguoiGui?.toJson();
    }
    if (thoiGianGui != null) {
      data["ThoiGianGui"] = thoiGianGui?.toJson();
    }
    if (hinhAnh != null) {
      data["HinhAnh"] = hinhAnh?.toJson();
    }
    if (ghiChu != null) {
      data["GhiChu"] = ghiChu?.toJson();
    }
    if (tenBuuPham != null) {
      data["TenBuuPham"] = tenBuuPham?.toJson();
    }
    if (toaNha != null) {
      data["ToaNha"] = toaNha?.toJson();
    }
    if (canHo != null) {
      data["CanHo"] = canHo?.toJson();
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

class ToaNha {
  List<String>? contentItemIds;
  List<String>? displayTexts;

  ToaNha({this.contentItemIds, this.displayTexts});

  ToaNha.fromJson(Map<String, dynamic> json) {
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

class TenBuuPham {
  String? text;

  TenBuuPham({this.text});

  TenBuuPham.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class GhiChu {
  dynamic text;

  GhiChu({this.text});

  GhiChu.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class HinhAnh {
  List<String?>? mediaTexts;
  List<String?>? paths;

  HinhAnh({this.mediaTexts, this.paths});

  HinhAnh.fromJson(Map<String, dynamic> json) {
    mediaTexts = json["MediaTexts"] == null
        ? null
        : List<String>.from(json["MediaTexts"]);
    paths = json["Paths"] == null ? null : List<String?>.from(json["Paths"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mediaTexts != null) {
      data["MediaTexts"] = mediaTexts;
    }
    if (paths != null) {
      data["Paths"] = paths;
    }
    return data;
  }
}

class ThoiGianGui {
  String? value;

  ThoiGianGui({this.value});

  ThoiGianGui.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class SoDienThoaiNguoiGui {
  String? text;

  SoDienThoaiNguoiGui({this.text});

  SoDienThoaiNguoiGui.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class NguoiGui {
  String? text;

  NguoiGui({this.text});

  NguoiGui.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
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

class NguoiNhan {
  List<String>? contentItemIds;
  List<String>? displayTexts;

  NguoiNhan({this.contentItemIds, this.displayTexts});

  NguoiNhan.fromJson(Map<String, dynamic> json) {
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
  List<String>? contentItemIds;
  List<String>? displayTexts;

  Tang({this.contentItemIds, this.displayTexts});

  Tang.fromJson(Map<String, dynamic> json) {
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

class ChotTruc {
  dynamic text;

  ChotTruc({this.text});

  ChotTruc.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
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
