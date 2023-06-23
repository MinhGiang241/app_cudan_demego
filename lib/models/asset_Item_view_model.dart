// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cudan/models/file_upload.dart';

class AssetItemViewModel {
  final String? type;
  final String? title;
  final List<ItemViewModel> list;
  AssetItemViewModel({
    this.type,
    this.title,
    this.list = const <ItemViewModel>[],
  });
}

class ItemViewModel {
  final String? name;
  final String? code;
  final String? id;
  final bool? achieve;
  final bool? not_achieve;
  final String? unit;
  final String? material_specification;
  final String? note;
  final String? brand;
  final int? amount;
  final List<FileUploadModel> photos;
  ItemViewModel({
    this.name,
    this.code,
    this.id,
    this.achieve,
    this.not_achieve,
    this.unit,
    this.material_specification,
    this.note,
    this.amount,
    this.brand,
    this.photos = const [],
  });
}
