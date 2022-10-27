class ResponseConstructionProfileList {
  int? total;
  List<ConstructionProfile>? results;
  dynamic code;
  String? message;

  ResponseConstructionProfileList({this.total, this.results});

  ResponseConstructionProfileList.fromJson(Map<String, dynamic> json) {
    code = json["status"];
    message = json["message"];
    total = json["total"];
    results = json["results"] == null
        ? null
        : (json["results"] as List)
            .map((e) => ConstructionProfile.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["total"] = total;
    if (results != null) {
      data["results"] = results?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ConstructionProfile {
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
  DangKyThiCong? dangKyThiCong;
  TitlePart? titlePart;
  ThongTinChuHoThiCong? thongTinChuHoThiCong;
  ThongTinNhaThauThiCong? thongTinNhaThauThiCong;
  NoiDungThiCong? noiDungThiCong;
  PrivateDangKyThiCongPart? privateDangKyThiCongPart;
  ListPart? listPart;

  ConstructionProfile(
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
      this.dangKyThiCong,
      this.titlePart,
      this.thongTinChuHoThiCong,
      this.thongTinNhaThauThiCong,
      this.noiDungThiCong,
      this.privateDangKyThiCongPart,
      this.listPart});

  ConstructionProfile.fromJson(Map<String, dynamic> json) {
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
    dangKyThiCong = json["DangKyThiCong"] == null
        ? null
        : DangKyThiCong.fromJson(json["DangKyThiCong"]);
    titlePart = json["TitlePart"] == null
        ? null
        : TitlePart.fromJson(json["TitlePart"]);
    thongTinChuHoThiCong = json["ThongTinChuHoThiCong"] == null
        ? null
        : ThongTinChuHoThiCong.fromJson(json["ThongTinChuHoThiCong"]);
    thongTinNhaThauThiCong = json["ThongTinNhaThauThiCong"] == null
        ? null
        : ThongTinNhaThauThiCong.fromJson(json["ThongTinNhaThauThiCong"]);
    noiDungThiCong = json["NoiDungThiCong"] == null
        ? null
        : NoiDungThiCong.fromJson(json["NoiDungThiCong"]);
    privateDangKyThiCongPart = json["PrivateDangKyThiCongPart"] == null
        ? null
        : PrivateDangKyThiCongPart.fromJson(json["PrivateDangKyThiCongPart"]);
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
    if (dangKyThiCong != null) {
      data["DangKyThiCong"] = dangKyThiCong?.toJson();
    }
    if (titlePart != null) {
      data["TitlePart"] = titlePart?.toJson();
    }
    if (thongTinChuHoThiCong != null) {
      data["ThongTinChuHoThiCong"] = thongTinChuHoThiCong?.toJson();
    }
    if (thongTinNhaThauThiCong != null) {
      data["ThongTinNhaThauThiCong"] = thongTinNhaThauThiCong?.toJson();
    }
    if (noiDungThiCong != null) {
      data["NoiDungThiCong"] = noiDungThiCong?.toJson();
    }
    if (privateDangKyThiCongPart != null) {
      data["PrivateDangKyThiCongPart"] = privateDangKyThiCongPart?.toJson();
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

class PrivateDangKyThiCongPart {
  TrangThai? trangThai;
  DatCocThiCong? datCocThiCong;
  HoanCocThiCong? hoanCocThiCong;

  PrivateDangKyThiCongPart(
      {this.trangThai, this.datCocThiCong, this.hoanCocThiCong});

  PrivateDangKyThiCongPart.fromJson(Map<String, dynamic> json) {
    trangThai = json["TrangThai"] == null
        ? null
        : TrangThai.fromJson(json["TrangThai"]);
    datCocThiCong = json["DatCocThiCong"] == null
        ? null
        : DatCocThiCong.fromJson(json["DatCocThiCong"]);
    hoanCocThiCong = json["HoanCocThiCong"] == null
        ? null
        : HoanCocThiCong.fromJson(json["HoanCocThiCong"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (trangThai != null) {
      data["TrangThai"] = trangThai?.toJson();
    }
    if (datCocThiCong != null) {
      data["DatCocThiCong"] = datCocThiCong?.toJson();
    }
    if (hoanCocThiCong != null) {
      data["HoanCocThiCong"] = hoanCocThiCong?.toJson();
    }
    return data;
  }
}

class HoanCocThiCong {
  List<dynamic>? contentItemIds;

  HoanCocThiCong({this.contentItemIds});

  HoanCocThiCong.fromJson(Map<String, dynamic> json) {
    contentItemIds = json["ContentItemIds"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contentItemIds != null) {
      data["ContentItemIds"] = contentItemIds;
    }
    return data;
  }
}

class DatCocThiCong {
  List<dynamic>? contentItemIds;

  DatCocThiCong({this.contentItemIds});

  DatCocThiCong.fromJson(Map<String, dynamic> json) {
    contentItemIds = json["ContentItemIds"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contentItemIds != null) {
      data["ContentItemIds"] = contentItemIds;
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

class NoiDungThiCong {
  List<ContentItems2>? contentItems;
  Trangthai2? trangthai;

  NoiDungThiCong({this.contentItems, this.trangthai});

  NoiDungThiCong.fromJson(Map<String, dynamic> json) {
    contentItems = json["ContentItems"] == null
        ? null
        : (json["ContentItems"] as List)
            .map((e) => ContentItems2.fromJson(e))
            .toList();
    trangthai = json["Trangthai"] == null
        ? null
        : Trangthai2.fromJson(json["Trangthai"]);
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

class Trangthai2 {
  String? text;

  Trangthai2({this.text});

  Trangthai2.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class ContentItems2 {
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
  NoiDungThiCong1? noiDungThiCong;
  TitlePart3? titlePart;

  ContentItems2(
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
      this.noiDungThiCong,
      this.titlePart});

  ContentItems2.fromJson(Map<String, dynamic> json) {
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
    noiDungThiCong = json["NoiDungThiCong"] == null
        ? null
        : NoiDungThiCong1.fromJson(json["NoiDungThiCong"]);
    titlePart = json["TitlePart"] == null
        ? null
        : TitlePart3.fromJson(json["TitlePart"]);
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
    if (noiDungThiCong != null) {
      data["NoiDungThiCong"] = noiDungThiCong?.toJson();
    }
    if (titlePart != null) {
      data["TitlePart"] = titlePart?.toJson();
    }
    return data;
  }
}

class TitlePart3 {
  String? title;

  TitlePart3({this.title});

  TitlePart3.fromJson(Map<String, dynamic> json) {
    title = json["Title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Title"] = title;
    return data;
  }
}

class NoiDungThiCong1 {
  HangMuc? hangMuc;
  NoiDung? noiDung;
  BanVeThiCong? banVeThiCong;
  SoTien? soTien;

  NoiDungThiCong1({this.hangMuc, this.noiDung, this.banVeThiCong, this.soTien});

  NoiDungThiCong1.fromJson(Map<String, dynamic> json) {
    hangMuc =
        json["HangMuc"] == null ? null : HangMuc.fromJson(json["HangMuc"]);
    noiDung =
        json["NoiDung"] == null ? null : NoiDung.fromJson(json["NoiDung"]);
    banVeThiCong = json["BanVeThiCong"] == null
        ? null
        : BanVeThiCong.fromJson(json["BanVeThiCong"]);
    soTien = json["SoTien"] == null ? null : SoTien.fromJson(json["SoTien"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hangMuc != null) {
      data["HangMuc"] = hangMuc?.toJson();
    }
    if (noiDung != null) {
      data["NoiDung"] = noiDung?.toJson();
    }
    if (banVeThiCong != null) {
      data["BanVeThiCong"] = banVeThiCong?.toJson();
    }
    if (soTien != null) {
      data["SoTien"] = soTien?.toJson();
    }
    return data;
  }
}

class SoTien {
  int? value;

  SoTien({this.value});

  SoTien.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class BanVeThiCong {
  List<String?>? paths;
  List<String>? mediaTexts;

  BanVeThiCong({this.paths, this.mediaTexts});

  BanVeThiCong.fromJson(Map<String, dynamic> json) {
    paths = json["Paths"] == null ? null : List<String?>.from(json["Paths"]);
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

class HangMuc {
  String? text;

  HangMuc({this.text});

  HangMuc.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class ThongTinNhaThauThiCong {
  List<ContentItems1>? contentItems;
  Trangthai1? trangthai;

  ThongTinNhaThauThiCong({this.contentItems, this.trangthai});

  ThongTinNhaThauThiCong.fromJson(Map<String, dynamic> json) {
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
  ThongTinNhaThauThiCong1? thongTinNhaThauThiCong;
  TitlePart2? titlePart;

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
      this.thongTinNhaThauThiCong,
      this.titlePart});

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
    thongTinNhaThauThiCong = json["ThongTinNhaThauThiCong"] == null
        ? null
        : ThongTinNhaThauThiCong1.fromJson(json["ThongTinNhaThauThiCong"]);
    titlePart = json["TitlePart"] == null
        ? null
        : TitlePart2.fromJson(json["TitlePart"]);
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
    if (thongTinNhaThauThiCong != null) {
      data["ThongTinNhaThauThiCong"] = thongTinNhaThauThiCong?.toJson();
    }
    if (titlePart != null) {
      data["TitlePart"] = titlePart?.toJson();
    }
    return data;
  }
}

class TitlePart2 {
  String? title;

  TitlePart2({this.title});

  TitlePart2.fromJson(Map<String, dynamic> json) {
    title = json["Title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Title"] = title;
    return data;
  }
}

class ThongTinNhaThauThiCong1 {
  Ten? ten;
  DiaChi? diaChi;
  Email? email;
  SoHopDong? soHopDong;
  TuNgay? tuNgay;
  DenNgay? denNgay;
  Nam? nam;
  Nu? nu;
  SoDienThoai1? soDienThoai;
  SoLuongCongNhan? soLuongCongNhan;

  ThongTinNhaThauThiCong1(
      {this.ten,
      this.diaChi,
      this.email,
      this.soHopDong,
      this.tuNgay,
      this.denNgay,
      this.nam,
      this.nu,
      this.soDienThoai,
      this.soLuongCongNhan});

  ThongTinNhaThauThiCong1.fromJson(Map<String, dynamic> json) {
    ten = json["Ten"] == null ? null : Ten.fromJson(json["Ten"]);
    diaChi = json["DiaChi"] == null ? null : DiaChi.fromJson(json["DiaChi"]);
    email = json["Email"] == null ? null : Email.fromJson(json["Email"]);
    soHopDong = json["SoHopDong"] == null
        ? null
        : SoHopDong.fromJson(json["SoHopDong"]);
    tuNgay = json["TuNgay"] == null ? null : TuNgay.fromJson(json["TuNgay"]);
    denNgay =
        json["DenNgay"] == null ? null : DenNgay.fromJson(json["DenNgay"]);
    nam = json["Nam"] == null ? null : Nam.fromJson(json["Nam"]);
    nu = json["Nu"] == null ? null : Nu.fromJson(json["Nu"]);
    soDienThoai = json["SoDienThoai"] == null
        ? null
        : SoDienThoai1.fromJson(json["SoDienThoai"]);
    soLuongCongNhan = json["SoLuongCongNhan"] == null
        ? null
        : SoLuongCongNhan.fromJson(json["SoLuongCongNhan"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ten != null) {
      data["Ten"] = ten?.toJson();
    }
    if (diaChi != null) {
      data["DiaChi"] = diaChi?.toJson();
    }
    if (email != null) {
      data["Email"] = email?.toJson();
    }
    if (soHopDong != null) {
      data["SoHopDong"] = soHopDong?.toJson();
    }
    if (tuNgay != null) {
      data["TuNgay"] = tuNgay?.toJson();
    }
    if (denNgay != null) {
      data["DenNgay"] = denNgay?.toJson();
    }
    if (nam != null) {
      data["Nam"] = nam?.toJson();
    }
    if (nu != null) {
      data["Nu"] = nu?.toJson();
    }
    if (soDienThoai != null) {
      data["SoDienThoai"] = soDienThoai?.toJson();
    }
    if (soLuongCongNhan != null) {
      data["SoLuongCongNhan"] = soLuongCongNhan?.toJson();
    }
    return data;
  }
}

class SoLuongCongNhan {
  int? value;

  SoLuongCongNhan({this.value});

  SoLuongCongNhan.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class SoDienThoai1 {
  String? text;

  SoDienThoai1({this.text});

  SoDienThoai1.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class Nu {
  int? value;

  Nu({this.value});

  Nu.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class Nam {
  int? value;

  Nam({this.value});

  Nam.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class DenNgay {
  String? value;

  DenNgay({this.value});

  DenNgay.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class TuNgay {
  String? value;

  TuNgay({this.value});

  TuNgay.fromJson(Map<String, dynamic> json) {
    value = json["Value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Value"] = value;
    return data;
  }
}

class SoHopDong {
  String? text;

  SoHopDong({this.text});

  SoHopDong.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class Email {
  String? text;

  Email({this.text});

  Email.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class DiaChi {
  String? text;

  DiaChi({this.text});

  DiaChi.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class Ten {
  String? text;

  Ten({this.text});

  Ten.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class ThongTinChuHoThiCong {
  List<ContentItems>? contentItems;
  Trangthai? trangthai;

  ThongTinChuHoThiCong({this.contentItems, this.trangthai});

  ThongTinChuHoThiCong.fromJson(Map<String, dynamic> json) {
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
  ThongTinChuHoThiCong1? thongTinChuHoThiCong;
  TitlePart1? titlePart;

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
      this.thongTinChuHoThiCong,
      this.titlePart});

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
    thongTinChuHoThiCong = json["ThongTinChuHoThiCong"] == null
        ? null
        : ThongTinChuHoThiCong1.fromJson(json["ThongTinChuHoThiCong"]);
    titlePart = json["TitlePart"] == null
        ? null
        : TitlePart1.fromJson(json["TitlePart"]);
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
    if (thongTinChuHoThiCong != null) {
      data["ThongTinChuHoThiCong"] = thongTinChuHoThiCong?.toJson();
    }
    if (titlePart != null) {
      data["TitlePart"] = titlePart?.toJson();
    }
    return data;
  }
}

class TitlePart1 {
  String? title;

  TitlePart1({this.title});

  TitlePart1.fromJson(Map<String, dynamic> json) {
    title = json["Title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Title"] = title;
    return data;
  }
}

class ThongTinChuHoThiCong1 {
  ToaNha? toaNha;
  Tang? tang;
  MatBang? matBang;
  ChuSoHuu? chuSoHuu;
  SoDienThoai? soDienThoai;
  SoDinhDanh? soDinhDanh;

  ThongTinChuHoThiCong1(
      {this.toaNha,
      this.tang,
      this.matBang,
      this.chuSoHuu,
      this.soDienThoai,
      this.soDinhDanh});

  ThongTinChuHoThiCong1.fromJson(Map<String, dynamic> json) {
    toaNha = json["ToaNha"] == null ? null : ToaNha.fromJson(json["ToaNha"]);
    tang = json["Tang"] == null ? null : Tang.fromJson(json["Tang"]);
    matBang =
        json["MatBang"] == null ? null : MatBang.fromJson(json["MatBang"]);
    chuSoHuu =
        json["ChuSoHuu"] == null ? null : ChuSoHuu.fromJson(json["ChuSoHuu"]);
    soDienThoai = json["SoDienThoai"] == null
        ? null
        : SoDienThoai.fromJson(json["SoDienThoai"]);
    soDinhDanh = json["SoDinhDanh"] == null
        ? null
        : SoDinhDanh.fromJson(json["SoDinhDanh"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (toaNha != null) {
      data["ToaNha"] = toaNha?.toJson();
    }
    if (tang != null) {
      data["Tang"] = tang?.toJson();
    }
    if (matBang != null) {
      data["MatBang"] = matBang?.toJson();
    }
    if (chuSoHuu != null) {
      data["ChuSoHuu"] = chuSoHuu?.toJson();
    }
    if (soDienThoai != null) {
      data["SoDienThoai"] = soDienThoai?.toJson();
    }
    if (soDinhDanh != null) {
      data["SoDinhDanh"] = soDinhDanh?.toJson();
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

class DangKyThiCong {
  So? so;

  DangKyThiCong({this.so});

  DangKyThiCong.fromJson(Map<String, dynamic> json) {
    so = json["So"] == null ? null : So.fromJson(json["So"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (so != null) {
      data["So"] = so?.toJson();
    }
    return data;
  }
}

class So {
  String? text;

  So({this.text});

  So.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}
