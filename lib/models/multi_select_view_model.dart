class MultiSelectViewModel {
  MultiSelectViewModel({
    this.value,
    this.title,
    this.subTitle,
    this.isSelected = false,
  });
  String? title;
  String? value;
  String? subTitle;
  bool? isSelected;
}
