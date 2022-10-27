class ResponseLostAndFoundList {
  List<LostAndFoundItem>? items;
  int? count;
  dynamic status;
  String? message;

  ResponseLostAndFoundList({this.items, this.count});

  ResponseLostAndFoundList.fromJson(Map<String, dynamic> json) {
    items = json["items"] == null
        ? null
        : (json["items"] as List)
            .map((e) => LostAndFoundItem.fromJson(e))
            .toList();
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

class LostAndFoundItem {
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
  LostAndFound? lostAndFound;
  TitlePart? titlePart;
  PrivateLostAndFoundPart? privateLostAndFoundPart;
  HoanThanhLostAndFound? hoanThanhLostAndFound;

  LostAndFoundItem(
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
      this.lostAndFound,
      this.titlePart,
      this.privateLostAndFoundPart,
      this.hoanThanhLostAndFound});

  LostAndFoundItem.fromJson(Map<String, dynamic> json) {
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
    lostAndFound = json["LostAndFound"] == null
        ? null
        : LostAndFound.fromJson(json["LostAndFound"]);
    titlePart = json["TitlePart"] == null
        ? null
        : TitlePart.fromJson(json["TitlePart"]);
    privateLostAndFoundPart = json["PrivateLostAndFoundPart"] == null
        ? null
        : PrivateLostAndFoundPart.fromJson(json["PrivateLostAndFoundPart"]);
    hoanThanhLostAndFound = json["HoanThanhLostAndFound"] == null
        ? null
        : HoanThanhLostAndFound.fromJson(json["HoanThanhLostAndFound"]);
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
    if (lostAndFound != null) {
      data["LostAndFound"] = lostAndFound?.toJson();
    }
    if (titlePart != null) {
      data["TitlePart"] = titlePart?.toJson();
    }
    if (privateLostAndFoundPart != null) {
      data["PrivateLostAndFoundPart"] = privateLostAndFoundPart?.toJson();
    }
    if (hoanThanhLostAndFound != null) {
      data["HoanThanhLostAndFound"] = hoanThanhLostAndFound?.toJson();
    }
    return data;
  }
}

class HoanThanhLostAndFound {
  List<ContentItems>? contentItems;

  HoanThanhLostAndFound({this.contentItems});

  HoanThanhLostAndFound.fromJson(Map<String, dynamic> json) {
    contentItems = json["ContentItems"] == null
        ? null
        : (json["ContentItems"] as List)
            .map((e) => ContentItems.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contentItems != null) {
      data["ContentItems"] = contentItems?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ContentItems {
  String? contentType;
  HoanThanhLostAndFound1? hoanThanhLostAndFound;

  ContentItems({this.contentType, this.hoanThanhLostAndFound});

  ContentItems.fromJson(Map<String, dynamic> json) {
    contentType = json["ContentType"];
    hoanThanhLostAndFound = json["HoanThanhLostAndFound"] == null
        ? null
        : HoanThanhLostAndFound1.fromJson(json["HoanThanhLostAndFound"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["ContentType"] = contentType;
    if (hoanThanhLostAndFound != null) {
      data["HoanThanhLostAndFound"] = hoanThanhLostAndFound?.toJson();
    }
    return data;
  }
}

class HoanThanhLostAndFound1 {
  NguoiNhan? nguoiNhan;
  SoCmt? soCmt;
  DiaChi? diaChi;
  SoDienThoaiNguoiNhan? soDienThoaiNguoiNhan;
  HinhAnhHoanThanh? hinhAnhHoanThanh;
  GhiChuHoanThanh? ghiChuHoanThanh;

  HoanThanhLostAndFound1(
      {this.nguoiNhan,
      this.soCmt,
      this.diaChi,
      this.soDienThoaiNguoiNhan,
      this.hinhAnhHoanThanh,
      this.ghiChuHoanThanh});

  HoanThanhLostAndFound1.fromJson(Map<String, dynamic> json) {
    nguoiNhan = json["NguoiNhan"] == null
        ? null
        : NguoiNhan.fromJson(json["NguoiNhan"]);
    soCmt = json["SoCMT"] == null ? null : SoCmt.fromJson(json["SoCMT"]);
    diaChi = json["DiaChi"] == null ? null : DiaChi.fromJson(json["DiaChi"]);
    soDienThoaiNguoiNhan = json["SoDienThoaiNguoiNhan"] == null
        ? null
        : SoDienThoaiNguoiNhan.fromJson(json["SoDienThoaiNguoiNhan"]);
    hinhAnhHoanThanh = json["HinhAnhHoanThanh"] == null
        ? null
        : HinhAnhHoanThanh.fromJson(json["HinhAnhHoanThanh"]);
    ghiChuHoanThanh = json["GhiChuHoanThanh"] == null
        ? null
        : GhiChuHoanThanh.fromJson(json["GhiChuHoanThanh"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nguoiNhan != null) {
      data["NguoiNhan"] = nguoiNhan?.toJson();
    }
    if (soCmt != null) {
      data["SoCMT"] = soCmt?.toJson();
    }
    if (diaChi != null) {
      data["DiaChi"] = diaChi?.toJson();
    }
    if (soDienThoaiNguoiNhan != null) {
      data["SoDienThoaiNguoiNhan"] = soDienThoaiNguoiNhan?.toJson();
    }
    if (hinhAnhHoanThanh != null) {
      data["HinhAnhHoanThanh"] = hinhAnhHoanThanh?.toJson();
    }
    if (ghiChuHoanThanh != null) {
      data["GhiChuHoanThanh"] = ghiChuHoanThanh?.toJson();
    }
    return data;
  }
}

class GhiChuHoanThanh {
  dynamic text;

  GhiChuHoanThanh({this.text});

  GhiChuHoanThanh.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class HinhAnhHoanThanh {
  List<String?>? mediaTexts;
  List<String?>? paths;

  HinhAnhHoanThanh({this.mediaTexts, this.paths});

  HinhAnhHoanThanh.fromJson(Map<String, dynamic> json) {
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

class SoDienThoaiNguoiNhan {
  String? text;

  SoDienThoaiNguoiNhan({this.text});

  SoDienThoaiNguoiNhan.fromJson(Map<String, dynamic> json) {
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

class SoCmt {
  String? text;

  SoCmt({this.text});

  SoCmt.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class NguoiNhan {
  String? text;

  NguoiNhan({this.text});

  NguoiNhan.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class PrivateLostAndFoundPart {
  TrangThai? trangThai;

  PrivateLostAndFoundPart({this.trangThai});

  PrivateLostAndFoundPart.fromJson(Map<String, dynamic> json) {
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

class LostAndFound {
  NguoiBaoCao? nguoiBaoCao;
  Id? id;
  SoDienThoai? soDienThoai;
  dynamic tenVatPham;
  DiaDiemNhatDuoc? diaDiemNhatDuoc;
  dynamic hinhAnh;
  dynamic thoiGian;
  GhiChu? ghiChu;
  Ten? ten;
  HinhAnhBaoCao? hinhAnhBaoCao;

  LostAndFound(
      {this.nguoiBaoCao,
      this.id,
      this.soDienThoai,
      this.tenVatPham,
      this.diaDiemNhatDuoc,
      this.hinhAnh,
      this.thoiGian,
      this.ghiChu,
      this.ten,
      this.hinhAnhBaoCao});

  LostAndFound.fromJson(Map<String, dynamic> json) {
    nguoiBaoCao = json["NguoiBaoCao"] == null
        ? null
        : NguoiBaoCao.fromJson(json["NguoiBaoCao"]);
    id = json["ID"] == null ? null : Id.fromJson(json["ID"]);
    soDienThoai = json["SoDienThoai"] == null
        ? null
        : SoDienThoai.fromJson(json["SoDienThoai"]);
    tenVatPham = json["TenVatPham"];
    diaDiemNhatDuoc = json["DiaDiemNhatDuoc"] == null
        ? null
        : DiaDiemNhatDuoc.fromJson(json["DiaDiemNhatDuoc"]);
    hinhAnh = json["HinhAnh"];
    thoiGian = json["ThoiGian"];
    ghiChu = json["GhiChu"] == null ? null : GhiChu.fromJson(json["GhiChu"]);
    ten = json["Ten"] == null ? null : Ten.fromJson(json["Ten"]);
    hinhAnhBaoCao = json["HinhAnhBaoCao"] == null
        ? null
        : HinhAnhBaoCao.fromJson(json["HinhAnhBaoCao"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nguoiBaoCao != null) {
      data["NguoiBaoCao"] = nguoiBaoCao?.toJson();
    }
    if (id != null) {
      data["ID"] = id?.toJson();
    }
    if (soDienThoai != null) {
      data["SoDienThoai"] = soDienThoai?.toJson();
    }
    data["TenVatPham"] = tenVatPham;
    if (diaDiemNhatDuoc != null) {
      data["DiaDiemNhatDuoc"] = diaDiemNhatDuoc?.toJson();
    }
    data["HinhAnh"] = hinhAnh;
    data["ThoiGian"] = thoiGian;
    if (ghiChu != null) {
      data["GhiChu"] = ghiChu?.toJson();
    }
    if (ten != null) {
      data["Ten"] = ten?.toJson();
    }
    if (hinhAnhBaoCao != null) {
      data["HinhAnhBaoCao"] = hinhAnhBaoCao?.toJson();
    }
    return data;
  }
}

class HinhAnhBaoCao {
  List<String?>? paths;
  List<String?>? mediaTexts;

  HinhAnhBaoCao({this.paths, this.mediaTexts});

  HinhAnhBaoCao.fromJson(Map<String, dynamic> json) {
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

class DiaDiemNhatDuoc {
  String? text;

  DiaDiemNhatDuoc({this.text});

  DiaDiemNhatDuoc.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}

class SoDienThoai {
  dynamic text;

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

class NguoiBaoCao {
  String? text;

  NguoiBaoCao({this.text});

  NguoiBaoCao.fromJson(Map<String, dynamic> json) {
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Text"] = text;
    return data;
  }
}
