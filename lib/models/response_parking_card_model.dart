class ResponseParkingCardsList {
  List<ParkingCard>? items;
  int? count;
  dynamic status;
  String? message;

  ResponseParkingCardsList({this.items, this.count});

  ResponseParkingCardsList.fromJson(Map<String, dynamic> json) {
    items = json["items"] == null
        ? null
        : (json["items"] as List).map((e) => ParkingCard.fromJson(e)).toList();
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

class ParkingCard {
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
  TheXe? theXe;
  TitlePart? titlePart;
  KhachHangTheXe? khachHangTheXe;
  ListPart? listPart;
  AliasPart1? aliasPart;
  PrivateTheXePart? privateTheXePart;

  ParkingCard(
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
      this.theXe,
      this.titlePart,
      this.khachHangTheXe,
      this.listPart,
      this.aliasPart,
      this.privateTheXePart});

  ParkingCard.fromJson(Map<String, dynamic> json) {
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
    theXe = json["TheXe"] == null ? null : TheXe.fromJson(json["TheXe"]);
    titlePart = json["TitlePart"] == null
        ? null
        : TitlePart.fromJson(json["TitlePart"]);
    khachHangTheXe = json["KhachHangTheXe"] == null
        ? null
        : KhachHangTheXe.fromJson(json["KhachHangTheXe"]);
    listPart =
        json["ListPart"] == null ? null : ListPart.fromJson(json["ListPart"]);
    aliasPart = json["AliasPart"] == null
        ? null
        : AliasPart1.fromJson(json["AliasPart"]);
    privateTheXePart = json["PrivateTheXePart"] == null
        ? null
        : PrivateTheXePart.fromJson(json["PrivateTheXePart"]);
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
    if (theXe != null) {
      data["TheXe"] = theXe?.toJson();
    }
    if (titlePart != null) {
      data["TitlePart"] = titlePart?.toJson();
    }
    if (khachHangTheXe != null) {
      data["KhachHangTheXe"] = khachHangTheXe?.toJson();
    }
    if (listPart != null) {
      data["ListPart"] = listPart?.toJson();
    }
    if (aliasPart != null) {
      data["AliasPart"] = aliasPart?.toJson();
    }
    if (privateTheXePart != null) {
      data["PrivateTheXePart"] = privateTheXePart?.toJson();
    }
    return data;
  }
}

class PrivateTheXePart {
  String? isDuplicateBienSoXe;
  TrangThai? trangThai;
  Loai? loai;
  ErrorDetail? errorDetail;
  KhachHangId? khachHangId;
  CreateFrom? createFrom;
  MaTaiSanKho? maTaiSanKho;
  Owner? owner;

  PrivateTheXePart(
      {this.isDuplicateBienSoXe,
      this.trangThai,
      this.loai,
      this.errorDetail,
      this.khachHangId,
      this.createFrom,
      this.maTaiSanKho,
      this.owner});

  PrivateTheXePart.fromJson(Map<String, dynamic> json) {
    isDuplicateBienSoXe = json["IsDuplicateBienSoXe"];
    trangThai = json["TrangThai"] == null
        ? null
        : TrangThai.fromJson(json["TrangThai"]);
    loai = json["Loai"] == null ? null : Loai.fromJson(json["Loai"]);
    errorDetail = json["ErrorDetail"] == null
        ? null
        : ErrorDetail.fromJson(json["ErrorDetail"]);
    khachHangId = json["KhachHangId"] == null
        ? null
        : KhachHangId.fromJson(json["KhachHangId"]);
    createFrom = json["CreateFrom"] == null
        ? null
        : CreateFrom.fromJson(json["CreateFrom"]);
    maTaiSanKho = json["MaTaiSanKho"] == null
        ? null
        : MaTaiSanKho.fromJson(json["MaTaiSanKho"]);
    owner = json["Owner"] == null ? null : Owner.fromJson(json["Owner"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["IsDuplicateBienSoXe"] = isDuplicateBienSoXe;
    if (trangThai != null) {
      data["TrangThai"] = trangThai?.toJson();
    }
    if (loai != null) {
      data["Loai"] = loai?.toJson();
    }
    if (errorDetail != null) {
      data["ErrorDetail"] = errorDetail?.toJson();
    }
    if (khachHangId != null) {
      data["KhachHangId"] = khachHangId?.toJson();
    }
    if (createFrom != null) {
      data["CreateFrom"] = createFrom?.toJson();
    }
    if (maTaiSanKho != null) {
      data["MaTaiSanKho"] = maTaiSanKho?.toJson();
    }
    if (owner != null) {
      data["Owner"] = owner?.toJson();
    }
    return data;
  }
}

class Owner {
  String? text;

  Owner({this.text});

  Owner.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class MaTaiSanKho {
  String? text;

  MaTaiSanKho({this.text});

  MaTaiSanKho.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
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

class KhachHangId {
  String? text;

  KhachHangId({this.text});

  KhachHangId.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class ErrorDetail {
  String? text;

  ErrorDetail({this.text});

  ErrorDetail.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class Loai {
  String? text;

  Loai({this.text});

  Loai.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
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

class AliasPart1 {
  String? alias;

  AliasPart1({this.alias});

  AliasPart1.fromJson(Map<String, dynamic> json) {
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

class KhachHangTheXe {
  List<ContentItems>? contentItems;
  Trangthai? trangthai;

  KhachHangTheXe({this.contentItems, this.trangthai});

  KhachHangTheXe.fromJson(Map<String, dynamic> json) {
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
  KhachHangTheXe1? khachHangTheXe;
  AliasPart? aliasPart;

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
      this.khachHangTheXe,
      this.aliasPart});

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
    khachHangTheXe = json["KhachHangTheXe"] == null
        ? null
        : KhachHangTheXe1.fromJson(json["KhachHangTheXe"]);
    aliasPart = json["AliasPart"] == null
        ? null
        : AliasPart.fromJson(json["AliasPart"]);
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
    if (khachHangTheXe != null) {
      data["KhachHangTheXe"] = khachHangTheXe?.toJson();
    }
    if (aliasPart != null) {
      data["AliasPart"] = aliasPart?.toJson();
    }
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

class KhachHangTheXe1 {
  String? trangThai;
  KhachHang? khachHang;
  SoThe? soThe;
  ToaNha? toaNha;
  Tang? tang;
  CanHo? canHo;
  SoDienThoai? soDienThoai;

  KhachHangTheXe1(
      {this.trangThai,
      this.khachHang,
      this.soThe,
      this.toaNha,
      this.tang,
      this.canHo,
      this.soDienThoai});

  KhachHangTheXe1.fromJson(Map<String, dynamic> json) {
    trangThai = json["TrangThai"];
    khachHang = json["KhachHang"] == null
        ? null
        : KhachHang.fromJson(json["KhachHang"]);
    soThe = json["SoThe"] == null ? null : SoThe.fromJson(json["SoThe"]);
    toaNha = json["ToaNha"] == null ? null : ToaNha.fromJson(json["ToaNha"]);
    tang = json["Tang"] == null ? null : Tang.fromJson(json["Tang"]);
    canHo = json["CanHo"] == null ? null : CanHo.fromJson(json["CanHo"]);
    soDienThoai = json["SoDienThoai"] == null
        ? null
        : SoDienThoai.fromJson(json["SoDienThoai"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["TrangThai"] = trangThai;
    if (khachHang != null) {
      data["KhachHang"] = khachHang?.toJson();
    }
    if (soThe != null) {
      data["SoThe"] = soThe?.toJson();
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

class KhachHang {
  List<String>? contentItemIds;
  List<String>? displayTexts;

  KhachHang({this.contentItemIds, this.displayTexts});

  KhachHang.fromJson(Map<String, dynamic> json) {
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

class TheXe {
  Id? id;
  SoDangKy? soDangKy;
  BienKiemSoat? bienKiemSoat;
  DongXe? dongXe;
  MauXe? mauXe;
  NgayHetHan? ngayHetHan;
  LoaiPhuongTien? loaiPhuongTien;
  GhiChu? ghiChu;
  HinhAnh? hinhAnh;
  GiaHanLanThuNhat? giaHanLanThuNhat;

  TheXe(
      {this.id,
      this.soDangKy,
      this.bienKiemSoat,
      this.dongXe,
      this.mauXe,
      this.ngayHetHan,
      this.loaiPhuongTien,
      this.ghiChu,
      this.hinhAnh,
      this.giaHanLanThuNhat});

  TheXe.fromJson(Map<String, dynamic> json) {
    id = json["ID"] == null ? null : Id.fromJson(json["ID"]);
    soDangKy =
        json["SoDangKy"] == null ? null : SoDangKy.fromJson(json["SoDangKy"]);
    bienKiemSoat = json["BienKiemSoat"] == null
        ? null
        : BienKiemSoat.fromJson(json["BienKiemSoat"]);
    dongXe = json["DongXe"] == null ? null : DongXe.fromJson(json["DongXe"]);
    mauXe = json["MauXe"] == null ? null : MauXe.fromJson(json["MauXe"]);
    ngayHetHan = json["NgayHetHan"] == null
        ? null
        : NgayHetHan.fromJson(json["NgayHetHan"]);
    loaiPhuongTien = json["LoaiPhuongTien"] == null
        ? null
        : LoaiPhuongTien.fromJson(json["LoaiPhuongTien"]);
    ghiChu = json["GhiChu"] == null ? null : GhiChu.fromJson(json["GhiChu"]);
    hinhAnh =
        json["HinhAnh"] == null ? null : HinhAnh.fromJson(json["HinhAnh"]);
    giaHanLanThuNhat = json["GiaHanLanThuNhat"] == null
        ? null
        : GiaHanLanThuNhat.fromJson(json["GiaHanLanThuNhat"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data["ID"] = id?.toJson();
    }
    if (soDangKy != null) {
      data["SoDangKy"] = soDangKy?.toJson();
    }
    if (bienKiemSoat != null) {
      data["BienKiemSoat"] = bienKiemSoat?.toJson();
    }
    if (dongXe != null) {
      data["DongXe"] = dongXe?.toJson();
    }
    if (mauXe != null) {
      data["MauXe"] = mauXe?.toJson();
    }
    if (ngayHetHan != null) {
      data["NgayHetHan"] = ngayHetHan?.toJson();
    }
    if (loaiPhuongTien != null) {
      data["LoaiPhuongTien"] = loaiPhuongTien?.toJson();
    }
    if (ghiChu != null) {
      data["GhiChu"] = ghiChu?.toJson();
    }
    if (hinhAnh != null) {
      data["HinhAnh"] = hinhAnh?.toJson();
    }
    if (giaHanLanThuNhat != null) {
      data["GiaHanLanThuNhat"] = giaHanLanThuNhat?.toJson();
    }
    return data;
  }
}

class GiaHanLanThuNhat {
  bool? value;

  GiaHanLanThuNhat({this.value});

  GiaHanLanThuNhat.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class HinhAnh {
  List<String>? mediaTexts;
  List<String>? paths;

  HinhAnh({this.mediaTexts, this.paths});

  HinhAnh.fromJson(Map<String, dynamic> json) {
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

class GhiChu {
  String? text;

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

class LoaiPhuongTien {
  List<String>? contentItemIds;
  List<String>? displayTexts;

  LoaiPhuongTien({this.contentItemIds, this.displayTexts});

  LoaiPhuongTien.fromJson(Map<String, dynamic> json) {
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

class NgayHetHan {
  String? value;

  NgayHetHan({this.value});

  NgayHetHan.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class MauXe {
  String? text;

  MauXe({this.text});

  MauXe.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class DongXe {
  String? text;

  DongXe({this.text});

  DongXe.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class BienKiemSoat {
  String? text;

  BienKiemSoat({this.text});

  BienKiemSoat.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class SoDangKy {
  dynamic value;

  SoDangKy({this.value});

  SoDangKy.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
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
