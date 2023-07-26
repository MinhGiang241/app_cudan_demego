import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class AddNewLetterUltilityPrv extends ChangeNotifier {
  int activeStep = 0;
  final PageController pageController = PageController();
  final TextEditingController dateController = TextEditingController();
  DateTime? date;
  String? validateDate;
  String? currentTimeValue;
  String? locationValue;
  int resNum = 0;
  var locationList = [
    {'name': 'CVTT Vườn nướng BBQ01'},
    {'name': 'CVTT Vườn nướng BBQ02'},
    {'name': 'CVTT Vườn nướng BBQ03'},
    {'name': 'CVTT Vườn nướng BBQ04'},
    {'name': 'CVTT Vườn nướng BBQ05'},
    {'name': 'CVTT Vườn nướng BBQ06'},
    {'name': 'CVTT Vườn nướng BBQ07'},
    {'name': 'CVTT Vườn nướng BBQ08'},
    {'name': 'CVTT Vườn nướng BBQ09'},
    {'name': 'CVTT Vườn nướng BBQ10'},
  ];

  var timeList = [
    {
      'time': '06:00 - 08:00',
      'full': true,
      'isbook': false,
    },
    {
      'time': '08:00 - 10:00',
      'full': false,
      'isbook': false,
    },
    {
      'time': '10:00 - 12:00',
      'full': false,
      'isbook': false,
    },
    {
      'time': '12:00 - 14:00',
      'full': true,
      'isbook': false,
    },
    {
      'time': '14:00 - 16:00',
      'full': false,
      'isbook': false,
    },
    {
      'time': '16:00 - 18:00',
      'full': false,
      'isbook': false,
    },
    {
      'time': '18:00 - 20:00',
      'full': true,
      'isbook': false,
    },
    {
      'value': '7',
      'time': '20:00 - 22:00',
      'full': false,
      'isbook': false,
    },
  ];

  pickDate(BuildContext context) {
    Utils.showDatePickers(
      context,
      initDate: date ?? DateTime.now(),
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        date = v;
        dateController.text = Utils.dateFormat(date!.toIso8601String(), 0);
        validateDate = null;
        notifyListeners();
      }
    });
  }

  bookingTime(value, int index) {
    currentTimeValue = value;
    notifyListeners();
  }

  onPageChange(v) {
    activeStep = v;
    notifyListeners();
  }

  onNextStep1(BuildContext context) {
    FocusScope.of(context).unfocus();
    pageController.animateToPage(
      ++activeStep,
      duration: const Duration(milliseconds: 250),
      curve: Curves.bounceInOut,
    );
  }

  onNextStep2(BuildContext context, String value) {
    setLocationValue(value);
    FocusScope.of(context).unfocus();
    pageController.animateToPage(
      ++activeStep,
      duration: const Duration(milliseconds: 250),
      curve: Curves.bounceInOut,
    );
  }

  onBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    pageController.animateToPage(
      --activeStep,
      duration: const Duration(milliseconds: 250),
      curve: Curves.bounceInOut,
    );
  }

  addResNum() {
    ++resNum;
    notifyListeners();
  }

  subtractResNum() {
    if (resNum > 0) {
      --resNum;
    }
    notifyListeners();
  }

  setLocationValue(String value) {
    locationValue = value;
    notifyListeners();
  }
}
