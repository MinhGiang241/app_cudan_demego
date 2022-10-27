class ResponseDanhMucBanTin {
  GetTaxonomyByAlias? getTaxonomyByAlias;
  dynamic status;
  String? message;
  ResponseDanhMucBanTin({this.getTaxonomyByAlias});

  ResponseDanhMucBanTin.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    getTaxonomyByAlias = json["getTaxonomyByAlias"] == null
        ? null
        : GetTaxonomyByAlias.fromJson(json["getTaxonomyByAlias"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getTaxonomyByAlias != null) {
      data["getTaxonomyByAlias"] = getTaxonomyByAlias?.toJson();
    }
    return data;
  }
}

class GetTaxonomyByAlias {
  List<DanhMucItems>? items;

  GetTaxonomyByAlias({this.items});

  GetTaxonomyByAlias.fromJson(Map<String, dynamic> json) {
    items = json["items"] == null
        ? null
        : (json["items"] as List).map((e) => DanhMucItems.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data["items"] = items?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class DanhMucItems {
  String? contentItemId;
  String? displayText;
  Alias? alias;
  Taxonomy? taxonomy;

  DanhMucItems(
      {this.contentItemId, this.displayText, this.alias, this.taxonomy});

  DanhMucItems.fromJson(Map<String, dynamic> json) {
    contentItemId = json["contentItemId"];
    displayText = json["displayText"];
    alias = json["alias"] == null ? null : Alias.fromJson(json["alias"]);
    taxonomy =
        json["taxonomy"] == null ? null : Taxonomy.fromJson(json["taxonomy"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["contentItemId"] = contentItemId;
    data["displayText"] = displayText;
    if (alias != null) {
      data["alias"] = alias?.toJson();
    }
    if (taxonomy != null) {
      data["taxonomy"] = taxonomy?.toJson();
    }
    return data;
  }
}

class Taxonomy {
  List<ContentItems>? contentItems;

  Taxonomy({this.contentItems});

  Taxonomy.fromJson(Map<String, dynamic> json) {
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
  String? displayText;
  String? contentItemId;

  ContentItems({this.displayText, this.contentItemId});

  ContentItems.fromJson(Map<String, dynamic> json) {
    displayText = json["displayText"];
    contentItemId = json["contentItemId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["displayText"] = displayText;
    data["contentItemId"] = contentItemId;
    return data;
  }
}

class Alias {
  String? alias;

  Alias({this.alias});

  Alias.fromJson(Map<String, dynamic> json) {
    alias = json["alias"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["alias"] = alias;
    return data;
  }
}
