class ResponsePetList {
  List<PetItems>? items;
  int? count;
  dynamic status;
  String? message;

  ResponsePetList({this.items, this.count});

  ResponsePetList.fromJson(Map<String, dynamic> json) {
    items = json["items"] == null
        ? null
        : (json["items"] as List).map((e) => PetItems.fromJson(e)).toList();
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

class PetItems {
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
  VatNuoi? vatNuoi;
  BienBanVatNuoi? bienBanVatNuoi;
  KhachHangVatNuoi? khachHangVatNuoi;
  TitlePart? titlePart;

  PetItems(
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
      this.vatNuoi,
      this.bienBanVatNuoi,
      this.khachHangVatNuoi,
      this.titlePart});

  PetItems.fromJson(Map<String, dynamic> json) {
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
    vatNuoi =
        json["VatNuoi"] == null ? null : VatNuoi.fromJson(json["VatNuoi"]);
    bienBanVatNuoi = json["BienBanVatNuoi"] == null
        ? null
        : BienBanVatNuoi.fromJson(json["BienBanVatNuoi"]);
    khachHangVatNuoi = json["KhachHangVatNuoi"] == null
        ? null
        : KhachHangVatNuoi.fromJson(json["KhachHangVatNuoi"]);
    titlePart = json["TitlePart"] == null
        ? null
        : TitlePart.fromJson(json["TitlePart"]);
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
    if (vatNuoi != null) {
      data["VatNuoi"] = vatNuoi?.toJson();
    }
    if (bienBanVatNuoi != null) {
      data["BienBanVatNuoi"] = bienBanVatNuoi?.toJson();
    }
    if (khachHangVatNuoi != null) {
      data["KhachHangVatNuoi"] = khachHangVatNuoi?.toJson();
    }
    if (titlePart != null) {
      data["TitlePart"] = titlePart?.toJson();
    }
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

class KhachHangVatNuoi {
  List<ContentItems1>? contentItems;
  Trangthai1? trangthai;

  KhachHangVatNuoi({this.contentItems, this.trangthai});

  KhachHangVatNuoi.fromJson(Map<String, dynamic> json) {
    contentItems = json["ContentItems"] == null
        ? null
        : (json["ContentItems"] as List)
            .map((e) => ContentItems1.fromJson(e))
            .toList();
    trangthai = json["Trangthai"] == null
        ? null
        : Trangthai1.fromJson(json["Trangthai"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contentItems != null) {
      data["ContentItems"] = contentItems?.map((e) => e.toJson()).toList();
    }
    if (trangthai != null) {
      data["Trangthai"] = trangthai?.toJson();
    }
    return data;
  }
}

class Trangthai1 {
  String? text;

  Trangthai1({this.text});

  Trangthai1.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class ContentItems1 {
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
  KhachHangVatNuoi1? khachHangVatNuoi;

  ContentItems1(
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
      this.khachHangVatNuoi});

  ContentItems1.fromJson(Map<String, dynamic> json) {
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
    khachHangVatNuoi = json["KhachHangVatNuoi"] == null
        ? null
        : KhachHangVatNuoi1.fromJson(json["KhachHangVatNuoi"]);
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
    if (khachHangVatNuoi != null) {
      data["KhachHangVatNuoi"] = khachHangVatNuoi?.toJson();
    }
    return data;
  }
}

class KhachHangVatNuoi1 {
  ChuSoHuu? chuSoHuu;
  SoDienThoai? soDienThoai;
  SoDinhDanh? soDinhDanh;
  Toa? toa;
  Tang? tang;
  MatBang? matBang;

  KhachHangVatNuoi1(
      {this.chuSoHuu,
      this.soDienThoai,
      this.soDinhDanh,
      this.toa,
      this.tang,
      this.matBang});

  KhachHangVatNuoi1.fromJson(Map<String, dynamic> json) {
    chuSoHuu =
        json["ChuSoHuu"] == null ? null : ChuSoHuu.fromJson(json["ChuSoHuu"]);
    soDienThoai = json["SoDienThoai"] == null
        ? null
        : SoDienThoai.fromJson(json["SoDienThoai"]);
    soDinhDanh = json["SoDinhDanh"] == null
        ? null
        : SoDinhDanh.fromJson(json["SoDinhDanh"]);
    toa = json["Toa"] == null ? null : Toa.fromJson(json["Toa"]);
    tang = json["Tang"] == null ? null : Tang.fromJson(json["Tang"]);
    matBang =
        json["MatBang"] == null ? null : MatBang.fromJson(json["MatBang"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chuSoHuu != null) {
      data["ChuSoHuu"] = chuSoHuu?.toJson();
    }
    if (soDienThoai != null) {
      data["SoDienThoai"] = soDienThoai?.toJson();
    }
    if (soDinhDanh != null) {
      data["SoDinhDanh"] = soDinhDanh?.toJson();
    }
    if (toa != null) {
      data["Toa"] = toa?.toJson();
    }
    if (tang != null) {
      data["Tang"] = tang?.toJson();
    }
    if (matBang != null) {
      data["MatBang"] = matBang?.toJson();
    }
    return data;
  }
}

class MatBang {
  List<String>? contentItemIds;
  List<String>? displayTexts;

  MatBang({this.contentItemIds, this.displayTexts});

  MatBang.fromJson(Map<String, dynamic> json) {
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

class Toa {
  List<String>? contentItemIds;
  List<String>? displayTexts;

  Toa({this.contentItemIds, this.displayTexts});

  Toa.fromJson(Map<String, dynamic> json) {
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

class SoDinhDanh {
  String? text;

  SoDinhDanh({this.text});

  SoDinhDanh.fromJson(Map<String, dynamic> json) {
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

class ChuSoHuu {
  List<String>? contentItemIds;
  List<String>? displayTexts;

  ChuSoHuu({this.contentItemIds, this.displayTexts});

  ChuSoHuu.fromJson(Map<String, dynamic> json) {
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

class BienBanVatNuoi {
  List<ContentItems>? contentItems;
  Trangthai? trangthai;

  BienBanVatNuoi({this.contentItems, this.trangthai});

  BienBanVatNuoi.fromJson(Map<String, dynamic> json) {
    contentItems = json["ContentItems"] == null
        ? null
        : (json["ContentItems"] as List)
            .map((e) => ContentItems.fromJson(e))
            .toList();
    trangthai = json["Trangthai"] == null
        ? null
        : Trangthai.fromJson(json["Trangthai"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contentItems != null) {
      data["ContentItems"] = contentItems?.map((e) => e.toJson()).toList();
    }
    if (trangthai != null) {
      data["Trangthai"] = trangthai?.toJson();
    }
    return data;
  }
}

class Trangthai {
  String? text;

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

class ContentItems {
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
  BienBanVatNuoi1? bienBanVatNuoi;

  ContentItems(
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
      this.bienBanVatNuoi});

  ContentItems.fromJson(Map<String, dynamic> json) {
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
    bienBanVatNuoi = json["BienBanVatNuoi"] == null
        ? null
        : BienBanVatNuoi1.fromJson(json["BienBanVatNuoi"]);
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
    if (bienBanVatNuoi != null) {
      data["BienBanVatNuoi"] = bienBanVatNuoi?.toJson();
    }
    return data;
  }
}

class BienBanVatNuoi1 {
  BienBan? bienBan;

  BienBanVatNuoi1({this.bienBan});

  BienBanVatNuoi1.fromJson(Map<String, dynamic> json) {
    bienBan =
        json["BienBan"] == null ? null : BienBan.fromJson(json["BienBan"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bienBan != null) {
      data["BienBan"] = bienBan?.toJson();
    }
    return data;
  }
}

class BienBan {
  List<String>? paths;
  List<String>? mediaTexts;

  BienBan({this.paths, this.mediaTexts});

  BienBan.fromJson(Map<String, dynamic> json) {
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

class VatNuoi {
  Id? id;
  LoaiVatNuoi? loaiVatNuoi;
  TenLoaiVatNuoi? tenLoaiVatNuoi;
  MoTaTomTat? moTaTomTat;
  Giong? giong;
  MauSac? mauSac;
  GioiTinh? gioiTinh;
  Tuoi? tuoi;
  DamBaoVeSinhSachSe? damBaoVeSinhSachSe;
  HinhAnhVatNuoi? hinhAnhVatNuoi;
  GiayChungNhanTiemPhongDai? giayChungNhanTiemPhongDai;
  TenVatNuoi? tenVatNuoi;

  VatNuoi(
      {this.id,
      this.loaiVatNuoi,
      this.tenLoaiVatNuoi,
      this.moTaTomTat,
      this.giong,
      this.mauSac,
      this.gioiTinh,
      this.tuoi,
      this.damBaoVeSinhSachSe,
      this.hinhAnhVatNuoi,
      this.giayChungNhanTiemPhongDai,
      this.tenVatNuoi});

  VatNuoi.fromJson(Map<String, dynamic> json) {
    id = json["ID"] == null ? null : Id.fromJson(json["ID"]);
    loaiVatNuoi = json["LoaiVatNuoi"] == null
        ? null
        : LoaiVatNuoi.fromJson(json["LoaiVatNuoi"]);
    tenLoaiVatNuoi = json["TenLoaiVatNuoi"] == null
        ? null
        : TenLoaiVatNuoi.fromJson(json["TenLoaiVatNuoi"]);
    moTaTomTat = json["MoTaTomTat"] == null
        ? null
        : MoTaTomTat.fromJson(json["MoTaTomTat"]);
    giong = json["Giong"] == null ? null : Giong.fromJson(json["Giong"]);
    mauSac = json["MauSac"] == null ? null : MauSac.fromJson(json["MauSac"]);
    gioiTinh =
        json["GioiTinh"] == null ? null : GioiTinh.fromJson(json["GioiTinh"]);
    tuoi = json["Tuoi"] == null ? null : Tuoi.fromJson(json["Tuoi"]);
    damBaoVeSinhSachSe = json["DamBaoVeSinhSachSe"] == null
        ? null
        : DamBaoVeSinhSachSe.fromJson(json["DamBaoVeSinhSachSe"]);
    hinhAnhVatNuoi = json["HinhAnhVatNuoi"] == null
        ? null
        : HinhAnhVatNuoi.fromJson(json["HinhAnhVatNuoi"]);
    giayChungNhanTiemPhongDai = json["GiayChungNhanTiemPhongDai"] == null
        ? null
        : GiayChungNhanTiemPhongDai.fromJson(json["GiayChungNhanTiemPhongDai"]);
    tenVatNuoi = json["TenVatNuoi"] == null
        ? null
        : TenVatNuoi.fromJson(json["TenVatNuoi"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data["ID"] = id?.toJson();
    }
    if (loaiVatNuoi != null) {
      data["LoaiVatNuoi"] = loaiVatNuoi?.toJson();
    }
    if (tenLoaiVatNuoi != null) {
      data["TenLoaiVatNuoi"] = tenLoaiVatNuoi?.toJson();
    }
    if (moTaTomTat != null) {
      data["MoTaTomTat"] = moTaTomTat?.toJson();
    }
    if (giong != null) {
      data["Giong"] = giong?.toJson();
    }
    if (mauSac != null) {
      data["MauSac"] = mauSac?.toJson();
    }
    if (gioiTinh != null) {
      data["GioiTinh"] = gioiTinh?.toJson();
    }
    if (tuoi != null) {
      data["Tuoi"] = tuoi?.toJson();
    }
    if (damBaoVeSinhSachSe != null) {
      data["DamBaoVeSinhSachSe"] = damBaoVeSinhSachSe?.toJson();
    }
    if (hinhAnhVatNuoi != null) {
      data["HinhAnhVatNuoi"] = hinhAnhVatNuoi?.toJson();
    }
    if (giayChungNhanTiemPhongDai != null) {
      data["GiayChungNhanTiemPhongDai"] = giayChungNhanTiemPhongDai?.toJson();
    }
    if (tenVatNuoi != null) {
      data["TenVatNuoi"] = tenVatNuoi?.toJson();
    }
    return data;
  }
}

class TenVatNuoi {
  String? text;

  TenVatNuoi({this.text});

  TenVatNuoi.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class GiayChungNhanTiemPhongDai {
  List<String>? mediaTexts;
  List<String>? paths;

  GiayChungNhanTiemPhongDai({this.mediaTexts, this.paths});

  GiayChungNhanTiemPhongDai.fromJson(Map<String, dynamic> json) {
    mediaTexts = json["MediaTexts"] == null
        ? null
        : List<String>.from(json["MediaTexts"]);
    paths = json["Paths"] == null ? null : List<String>.from(json["Paths"]);
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

class HinhAnhVatNuoi {
  List<String>? mediaTexts;
  List<String>? paths;

  HinhAnhVatNuoi({this.mediaTexts, this.paths});

  HinhAnhVatNuoi.fromJson(Map<String, dynamic> json) {
    mediaTexts = json["MediaTexts"] == null
        ? null
        : List<String>.from(json["MediaTexts"]);
    paths = json["Paths"] == null ? null : List<String>.from(json["Paths"]);
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

class DamBaoVeSinhSachSe {
  bool? value;

  DamBaoVeSinhSachSe({this.value});

  DamBaoVeSinhSachSe.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class Tuoi {
  String? text;

  Tuoi({this.text});

  Tuoi.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class GioiTinh {
  String? text;

  GioiTinh({this.text});

  GioiTinh.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class MauSac {
  String? text;

  MauSac({this.text});

  MauSac.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class Giong {
  String? text;

  Giong({this.text});

  Giong.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class MoTaTomTat {
  String? text;

  MoTaTomTat({this.text});

  MoTaTomTat.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class TenLoaiVatNuoi {
  String? text;

  TenLoaiVatNuoi({this.text});

  TenLoaiVatNuoi.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class LoaiVatNuoi {
  String? text;

  LoaiVatNuoi({this.text});

  LoaiVatNuoi.fromJson(Map<String, dynamic> json) {
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
