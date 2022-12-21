import 'package:app_cudan/models/missing_object.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_lost.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/utils.dart';

class MissingObjectPrv extends ChangeNotifier {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  List<MissingObject> historyList = [];
  List<MissingObject> foundList = [];
  onChooseMonthYear(DateTime v) {
    year = v.year;
    month = v.month;
    notifyListeners();
  }

  getLostItemList(BuildContext context) async {
    await APILost.getLostItemList(year, month,
            context.read<ResidentInfoPrv>().userInfo!.phone_required ?? "")
        .then((v) {
      historyList.clear();
      foundList.clear();
      for (var i in v) {
        if (i['status'] == "FOUND") {
          foundList.add(MissingObject.fromJson(i));
        } else {
          historyList.add(MissingObject.fromJson(i));
        }
      }
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
