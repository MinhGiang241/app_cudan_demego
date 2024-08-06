
class Homecategory {
  Homecategory(
      {this.text, this.key, this.type, this.externalLink, this.iconUrl});
  String? text;
  String? key;
  String? type;
  String? externalLink;
  String? iconUrl;

  Homecategory.fromMap(Map<String, dynamic> map) {
    text=map['text'];
    key =map['key'];
    type=map['type'];
    externalLink=map['externalLink'];
    iconUrl=map['iconUrl'];
  }
}
