import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class GeneralInfoPrv extends ChangeNotifier {
  GlobalKey infoKey = GlobalKey();
  int initPage = 0;

  final TextEditingController handOverDateController = TextEditingController();
  final TextEditingController handOverTimeController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final PageController pageController = PageController();

  String? validateHandOverDate;
  String? validateHandOverTime;
  DateTime? handOverDate;
  TimeOfDay? handOverTime;
  bool isSendLoading = false;

  onChangePage(int index) {
    initPage = index;
    notifyListeners();
  }

  selectItemPass(bool value, int indexAsset, int indexItem) {
    (dataAsset[indexAsset]["assets"] as List)[indexItem]['pass'] = value;
    notifyListeners();
  }

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

  var dataAsset = [
    {
      "id": 1,
      "title": "Nhà vệ sinh",
      "assets": [
        {
          "name": "Bổn rửa mặt",
          "amount": 2,
          "pass": true,
          "material": "Sứ",
        },
        {
          "name": "Bàn trang điểm",
          "amount": 1,
          "pass": false,
          "material": "Sứ",
        },
        {
          "name": "Bổn rửa mặt",
          "amount": 2,
          "pass": true,
          "material": "Sứ",
        },
      ]
    },
    {
      "id": 2,
      "title": "Nhà bếp",
      "assets": [
        {
          "name": "Bổn rửa mặt",
          "amount": 2,
          "pass": true,
          "material": "Sứ",
        },
        {
          "name": "Bàn trang điểm",
          "amount": 1,
          "pass": false,
          "material": "Sứ",
        },
        {
          "name": "Bổn rửa mặt",
          "amount": 2,
          "pass": true,
          "material": "Sứ",
        },
      ]
    },
    {
      "id": 3,
      "title": "Phòng ăn",
      "assets": [
        {
          "name": "Bổn rửa mặt",
          "amount": 2,
          "pass": true,
          "material": "Sứ",
        },
        {
          "name": "Bàn trang điểm",
          "amount": 1,
          "pass": false,
          "material": "Sứ",
        },
        {
          "name": "Bổn rửa mặt",
          "amount": 2,
          "pass": true,
          "material": "Sứ",
        },
      ]
    },
  ];
}
