import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/new.dart';
import '../../../services/api_new.dart';
import '../../../utils/utils.dart';

class NewListPrv extends ChangeNotifier {
  NewListPrv({required this.type});
  int skip = 0;
  final String type;

  List<New> listNews = [];
  clearInitList() {
    listNews.clear();
    skip = 0;
    notifyListeners();
  }

  markRead(BuildContext context, int index, New e) async {
    if (e.isRead != true) {
      var mark = MarkRead(
          accountId: context.read<ResidentInfoPrv>().userInfo!.account!.id,
          newId: e.id,
          type: "NEW");
      await APINew.markRead(mark.toJson());

      listNews[index].isRead = true;
      notifyListeners();
    }
  }

  getNews(BuildContext context, bool isInit) async {
    if (isInit) {
      skip = 0;
      listNews.clear();
    }
    await APINew.getNewList(5, skip, type,
            context.read<ResidentInfoPrv>().userInfo!.account!.id!)
        .then((v) {
      for (var i in v) {
        listNews.add(New.fromJson(i));
      }
      skip += 5;

      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });

    notifyListeners();
  }
}
