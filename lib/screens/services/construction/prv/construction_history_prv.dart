import 'package:app_cudan/models/construction.dart';
import 'package:app_cudan/models/timeline_model.dart';
import 'package:app_cudan/services/api_construction.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class ConstructionHistoryPrv extends ChangeNotifier {
  List<ConstructionHistory> list = [];
  List<TimelineModel> content = [];
  getHistoryList(
      BuildContext context, String constructionregistrationId) async {
    await APIConstruction.getConstructionHistory(constructionregistrationId)
        .then((v) {
      list.clear();
      for (var i in v) {
        var conHis = ConstructionHistory.fromJson(i);
        list.add(conHis);
        content.add(TimelineModel(date: conHis.date, title: conHis.s!.name));
      }

      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
