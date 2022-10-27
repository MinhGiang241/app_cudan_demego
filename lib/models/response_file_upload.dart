class ResponseFileUpload {
  List<ResponseFile>? files;
  dynamic status;
  String? message;

  ResponseFileUpload({this.files});

  ResponseFileUpload.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    files = json["files"] == null
        ? null
        : (json["files"] as List).map((e) => ResponseFile.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (files != null) {
      data["files"] = files?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ResponseFile {
  String? name;
  int? size;
  double? lastModify;
  String? folder;
  String? url;
  String? mediaPath;
  String? mime;
  String? mediaText;
  Anchor? anchor;

  ResponseFile(
      {this.name,
      this.size,
      this.lastModify,
      this.folder,
      this.url,
      this.mediaPath,
      this.mime,
      this.mediaText,
      this.anchor});

  ResponseFile.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    size = json["size"];
    lastModify = json["lastModify"];
    folder = json["folder"];
    url = json["url"];
    mediaPath = json["mediaPath"];
    mime = json["mime"];
    mediaText = json["mediaText"];
    anchor = json["anchor"] == null ? null : Anchor.fromJson(json["anchor"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["size"] = size;
    data["lastModify"] = lastModify;
    data["folder"] = folder;
    data["url"] = url;
    data["mediaPath"] = mediaPath;
    data["mime"] = mime;
    data["mediaText"] = mediaText;
    if (anchor != null) {
      data["anchor"] = anchor?.toJson();
    }
    return data;
  }
}

class Anchor {
  double? x;
  double? y;

  Anchor({this.x, this.y});

  Anchor.fromJson(Map<String, dynamic> json) {
    x = json["x"];
    y = json["y"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["x"] = x;
    data["y"] = y;
    return data;
  }
}
