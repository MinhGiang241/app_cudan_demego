import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class BookingPrv extends ChangeNotifier {
  final TextEditingController handOverDateController = TextEditingController();
  final TextEditingController handOverTimeController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String? validateHandOverDate;
  String? validateHandOverTime;

  DateTime? handOverDate;
  TimeOfDay? handOverTime;

  bool isSendLoading = false;

  pickHandOverDate(BuildContext context) async {
    await Utils.showDatePickers(
      context,
      initDate: handOverDate ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        handOverDate = v;
        handOverDateController.text = Utils.dateFormat(v.toIso8601String(), 0);

        notifyListeners();
      }
    });
  }

  pickHandOverTime(BuildContext context) {
    showTimePicker(
            context: context,
            initialTime: handOverTime ?? const TimeOfDay(hour: 0, minute: 0))
        .then((v) {
      if (v != null) {
        handOverTimeController.text = v.format(context);
        handOverTime = v;
      }
    });
  }
}
