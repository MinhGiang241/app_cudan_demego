// ignore_for_file: public_member_api_docs, sort_constructors_first
class AssetItemViewModel {
  String? type;
  String? title;
  List<ItemViewModel> list;
  AssetItemViewModel({
    this.type,
    this.title,
    this.list = const <ItemViewModel>[],
  });
}

class ItemViewModel {
  String? name;
  String? code;
  String? id;
  bool achieve;
  bool not_achieve;
  ItemViewModel({
    this.name,
    this.code,
    this.id,
    this.achieve = false,
    this.not_achieve = false,
  });
}
