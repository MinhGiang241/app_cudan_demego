class BillModel {
  final int? id;
  final String? name;
  final String? code;
  final String? content;
  final double? vat;
  final double? price;
  final String? status;
  final String? date;
  bool isSelected;

  BillModel(
      {this.id,
      this.name,
      this.code,
      this.content,
      this.vat,
      this.price,
      this.status,
      this.date,
      this.isSelected = false});
}
