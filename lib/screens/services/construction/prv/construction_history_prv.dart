import 'package:app_cudan/models/construction.dart';
import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/models/timeline_model.dart';
import 'package:app_cudan/services/api_construction.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';

class ConstructionHistoryPrv extends ChangeNotifier {
  List<ConstructionHistory> list = [];
  List<TimelineModel> content = [];
  getHistoryList(
    BuildContext context,
    String constructionregistrationId,
  ) async {
    await APIConstruction.getConstructionHistory(constructionregistrationId)
        .then((v) {
      list.clear();
      for (var i in v) {
        var conHis = ConstructionHistory.fromJson(i);
        list.add(conHis);
        list.sort((a, b) => a.createdTime!.compareTo(b.createdTime!));
        content.add(
          TimelineModel(
            date: conHis.date ?? conHis.createdTime,
            title: genConstructHistory(conHis.status ?? ""),
            color: genStatusColor(conHis.status),
            subTitle:
                "${S.of(context).perform_person}: ${conHis.e != null ? conHis.e?.name : conHis.re != null ? conHis.re?.info_name : null}",
          ),
        );
      }

      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  genConstructHistory(String status) {
    switch (status) {
      case "CANCEL":
        return S.current.cancel_reg;
      case "EDIT":
        return S.current.cancel;
      case "REJECT":
        return S.current.refuse;
      case "APPROVED":
        return S.current.approve_2;
      case "WAIT_MANAGER":
        return S.current.approve_1;
      case "CONFIRM":
        return S.current.confirm;
      case "SEND":
        return S.current.send_request;
      case "PAY_DONE":
        return S.current.pay_done;
      case "NEW":
        return S.current.create_new;
      case "WAIT_OWNER":
        return S.current.confirm;
      case "WAIT_PAY":
        return S.current.send_request;
      default:
        return '';
    }
  }
}
