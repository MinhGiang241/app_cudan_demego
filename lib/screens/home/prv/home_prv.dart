import 'package:app_cudan/services/api_new.dart';

import '../../../models/new.dart';
import '../../../models/response_bantinduan_list.dart' as btda;
import '../../../models/response_news_list_model.dart';
import '../../../models/response_news_list_model.dart' as newlist;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/response_bantinduan_list.dart';
import '../../../models/response_news_list_model.dart';
import '../../../services/api_tower.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_dialog.dart';
import '../../auth/prv/auth_prv.dart';

class HomePrv extends ChangeNotifier {
  List<NewsListItems>? newsList;
  List<BTDAItems>? btdaList;
  bool isLoading = false;
  bool isResNewsLoading = false;
  bool isProNewsLoading = false;
  late BuildContext context;
  List<New> newResidentList = [];
  List<New> newProjectList = [];

  HomePrv(ctx) {
    context = ctx;
    _initial();
  }

  Future _initial() async {
    // var filter = {
    //   "skip": 0,
    //   "limit": 2,
    //   "postQueryBeforePaging": true,
    //   "group": {
    //     "op": "AND",
    //     "children": [],
    //     "operation": "~i",
    //     "rawFilter": false,
    //   },
    //   "text": "",
    //   "skipDefaultTextSearch": false,
    //   "withRecords": false,
    //   "inline": false,
    //   "is_debug": false,
    //   "unionLimit": 10
    // };
    try {
      isResNewsLoading = true;
      isProNewsLoading = true;
      notifyListeners();
      var residentNews = await APINew.getNewList(5, 0, "RESIDENT");
      for (var i in residentNews) {
        newResidentList.add(New.fromJson(i));
      }
      newResidentList.sort(
        (a, b) => b.createdTime!.compareTo(a.createdTime ?? ""),
      );
      var projectNews = await APINew.getNewList(5, 0, "PROJECT");
      for (var i in projectNews) {
        newProjectList.add(New.fromJson(i));
      }
      newProjectList.sort(
        (a, b) => b.createdTime!.compareTo(a.createdTime ?? ""),
      );
      isResNewsLoading = false;
      isProNewsLoading = false;
      notifyListeners();
    } catch (e) {
      isResNewsLoading = false;
      isProNewsLoading = false;

      notifyListeners();
      Utils.showErrorMessage(context, e.toString());
    }
  }
}
