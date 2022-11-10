import 'package:flutter/material.dart';

import '../../../../models/response_thecudan_list.dart';
import '../../../../services/api_tower.dart';

class ResidentCardPrv extends ChangeNotifier {
  ResponseTheCuDanList? responseTheCuDanList;

  ResidentCardPrv() {
    _initial();
  }

  Future<void> _initial() async {
    await APITower.getTheCuDan().then((value) async {
      responseTheCuDanList = value;
      notifyListeners();
      // for (var i = responseTheCuDanList!.items!.length - 1; i > 2; i--) {
      //   await APITower.unlikeBantin(
      //       id: responseTheCuDanList!.items![i].contentItemId!);
      // }
    });
  }

  Future<void> retry() async {
    responseTheCuDanList = null;
    notifyListeners();
    await _initial();
  }
}
