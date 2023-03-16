extension ConvertDateTime on String {
  String formatDateTimeDMY() {
    DateTime dt = DateTime.parse(this);
    DateTime d = dt.add(const Duration(hours: 7));
    return "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}";
  }

  String formatDateTimeHmDMY() {
    DateTime dt = DateTime.parse(this);
    DateTime d = dt.add(const Duration(hours: 7));
    return "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} - ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}";
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
