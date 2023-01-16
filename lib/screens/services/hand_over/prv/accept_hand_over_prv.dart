import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class AcceptHandOverPrv extends ChangeNotifier {
  AcceptHandOverPrv() {
    for (var i = 0; i < data.length; ++i) {
      for (var a = 0; a < (data[i]['assets'] as List).length; a++) {
        (data[i]['assets'] as List)[a]['region'] = data[i]['title'];
        (data[i]['assets'] as List)[a]["indexRegion"] = i;
        (data[i]['assets'] as List)[a]["indexAsset"] = a;
        if (!(data[i]['assets'] as List)[a]['pass']) {
          notPassList.add((data[i]['assets'] as List)[a]);
        }
      }
    }
  }
  bool generalInfoExpand = false;
  bool assetListExpand = false;
  bool expandNotPass = false;
  List notPassList = [];
  GlobalKey infoKey = GlobalKey();

  final TextEditingController handOverDateController = TextEditingController();
  final TextEditingController handOverTimeController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String? validateHandOverDate;
  String? validateHandOverTime;

  DateTime? handOverDate;
  TimeOfDay? handOverTime;

  bool isSendLoading = false;

  toggleExpandNotPass() {
    expandNotPass = !expandNotPass;
    notifyListeners();
  }

  selectItemPass(bool value, int indexAsset, int indexItem) {
    (data[indexAsset]["assets"] as List)[indexItem]['pass'] = value;
    var a = (data[indexAsset]["assets"] as List)[indexItem];
    if (value && notPassList.contains(a)) {
      notPassList.remove(a);
    }
    if (!value && !notPassList.contains(a)) {
      notPassList.add(a);
    }

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

  toggleGeneralInfo() {
    generalInfoExpand = !generalInfoExpand;
    notifyListeners();
  }

  toggleAssetList() {
    assetListExpand = !assetListExpand;
    notifyListeners();
  }

  var data = [
    {
      "id": 1,
      "title": "Nhà vệ sinh",
      "assets": [
        {
          "id": "01",
          "name": "Bổn rửa mặt",
          "amount": 2,
          "pass": true,
          "material": "Sứ",
        },
        {
          "id": "02",
          "name": "Bàn trang điểm",
          "amount": 1,
          "pass": false,
        },
        {
          "id": "03",
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
          "id": "04",
          "name": "Bổn rửa mặt",
          "amount": 2,
          "pass": true,
          "material": "Sứ",
        },
        {
          "id": "05",
          "name": "Bàn trang điểm",
          "amount": 1,
          "pass": false,
          "material": "Sứ",
        },
        {
          "id": "06",
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
          "id": "07",
          "name": "Bổn rửa mặt",
          "amount": 2,
          "pass": true,
          "material": "Sứ",
        },
        {
          "id": "08",
          "name": "Bàn trang điểm",
          "amount": 1,
          "pass": false,
          "material": "Sứ",
        },
        {
          "id": "09",
          "name": "Bổn rửa mặt",
          "amount": 2,
          "pass": true,
          "material": "Sứ",
        },
      ]
    },
  ];
}
