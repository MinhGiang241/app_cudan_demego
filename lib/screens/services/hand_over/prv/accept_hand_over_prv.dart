import 'package:flutter/material.dart';

import '../../../../models/file_upload.dart';
import '../../../../models/hand_over.dart';
import '../../../../services/api_rules.dart';
import '../../../../utils/utils.dart';
import '../widget/asset_item.dart';

class AcceptHandOverPrv extends ChangeNotifier {
  AcceptHandOverPrv(this.handOver) {
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

    //mateial
    materialList = {};
    for (var i in handOver.material_list ?? <Materials>[]) {
      if (materialList[i.assetPositionId] == null) {
        materialList[i.assetPositionId!] = <Materials>[];
        materialList[i.assetPositionId]!.add(i);
      } else {
        materialList[i.assetPositionId]!.add(i);
      }
    }

    // asset
    assetList = {};
    for (var i in handOver.list_assets_additional ?? <AddAsset>[]) {
      if (assetList[i.assetPositionId_additional] == null) {
        assetList[i.assetPositionId_additional!] = <AddAsset>[];
        assetList[i.assetPositionId_additional]!.add(i);
      } else {
        assetList[i.assetPositionId_additional]!.add(i);
      }
    }

    print(materialList);
    print(assetList);
  }

  late Map<String, List<Materials>> materialList;
  late Map<String, List<AddAsset>> assetList;
  late HandOver handOver;
  List<FileUploadModel> ruleFiles = [];

  bool generalInfoExpand = false;
  bool assetListExpand = false;
  bool materialListExpand = false;
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

  Future getRuleFiles() async {
    await APIRule.getListRulesFiles("handover").then((v) {
      if (v != null) {
        ruleFiles.clear();
        for (var i in v) {
          ruleFiles.add(FileUploadModel.fromMap(i));
        }
        ruleFiles.sort(
          (a, b) => a.id!.compareTo(b.id!),
        );
      }
    });
  }

  toggleExpandNotPass() {
    expandNotPass = !expandNotPass;
    notifyListeners();
  }

  selectItemPass(bool value, String key, int indexItem, DetailType type) {
    if (type == DetailType.ASSET) {
      assetList[key]![indexItem].achieve = value;
      assetList[key]![indexItem].not_achieve = !value;
    }
    if (type == DetailType.MATERIAL) {
      materialList[key]![indexItem].achieve = value;
      materialList[key]![indexItem].not_achieve = !value;
    }

    // (data[indexAsset]["assets"] as List)[indexItem]['pass'] = value;
    // var a = (data[indexAsset]["assets"] as List)[indexItem];
    // if (value && notPassList.contains(a)) {
    //   notPassList.remove(a);
    // }
    // if (!value && !notPassList.contains(a)) {
    //   notPassList.add(a);
    // }

    notifyListeners();
  }

  // pickHandOverDate(BuildContext context) async {
  //   await Utils.showDatePickers(
  //     context,
  //     initDate: handOverDate ?? DateTime.now(),
  //     startDate: DateTime(DateTime.now().year - 10, 1, 1),
  //     endDate: DateTime(DateTime.now().year + 10, 1, 1),
  //   ).then((v) {
  //     if (v != null) {
  //       handOverDate = v;
  //       handOverDateController.text = Utils.dateFormat(v.toIso8601String(), 0);

  //       notifyListeners();
  //     }
  //   });
  // }

  // pickHandOverTime(BuildContext context) {
  //   showTimePicker(
  //           context: context,
  //           initialTime: handOverTime ?? const TimeOfDay(hour: 0, minute: 0))
  //       .then((v) {
  //     if (v != null) {
  //       handOverTimeController.text = v.format(context);
  //       handOverTime = v;
  //     }
  //   });
  // }

  toggleGeneralInfo() {
    generalInfoExpand = !generalInfoExpand;
    notifyListeners();
  }

  toggleAssetList() {
    assetListExpand = !assetListExpand;
    notifyListeners();
  }

  toggleMaterialList() {
    materialListExpand = !materialListExpand;
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
