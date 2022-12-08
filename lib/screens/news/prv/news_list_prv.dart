import 'package:flutter/material.dart';

import '../../../models/new.dart';
import '../../../services/api_new.dart';
import '../../../utils/utils.dart';

class NewListPrv extends ChangeNotifier {
  NewListPrv({required this.initList});
  int skip = 0;
  final List<New> initList;
  List<New> listNews = [];
  clearInitList() {
    listNews.clear();
    skip = 0;
    notifyListeners();
  }

  getNews(BuildContext context, bool isInit) async {
    if (isInit) {
      skip = 0;
      listNews.clear();
    }
    await APINew.getNewList(1, skip).then((v) {
      for (var i in v) {
        listNews.add(New.fromJson(i));
      }
      skip += 1;

      print("skip: ${skip}");
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });

    notifyListeners();
  }
}
