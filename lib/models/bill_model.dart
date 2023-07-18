import 'receipt.dart';

class BillModel {
  final int? id;
  final String? name;
  final String? code;
  final String? content;
  final int? vat;
  final int? price;
  final String? status;
  final String? date;
  bool isSelected;
  Receipt re;

  BillModel({
    this.id,
    required this.re,
    this.name,
    this.code,
    this.content,
    this.vat,
    this.price,
    this.status,
    this.date,
    this.isSelected = false,
  });
}
