import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_event.dart';
import 'package:app_cudan/services/api_new.dart';

import '../../../models/event.dart';
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
  Event? event;
  bool isLoading = false;
  bool isResNewsLoading = false;
  bool isProNewsLoading = false;
  bool isEventLoading = false;
  List<New> newResidentList = [];
  List<New> newProjectList = [];
  BuildContext? context;

  HomePrv(ctx) {
    context = ctx;
    _initial();
  }
  onParticipate() {
    if (event != null) {
      event!.isParticipation = true;
    }
    notifyListeners();
  }

  markRead(BuildContext context, New e) async {
    if (e.isRead != true) {
      var mark = MarkRead(
          accountId: context.read<ResidentInfoPrv>().userInfo!.account!.id,
          newId: e.id,
          type: "NEW");
      await APINew.markRead(mark.toJson());

      // listNews[index].isRead = true;
      notifyListeners();
    }
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
      isEventLoading = true;
      isResNewsLoading = true;
      isProNewsLoading = true;
      notifyListeners();
      var accountId = context!.read<ResidentInfoPrv>().userInfo != null
          ? context!.read<ResidentInfoPrv>().userInfo!.account!.id
          : null;
      var residentNews =
          await APINew.getNewList(5, 0, "RESIDENT", accountId ?? '');
      for (var i in residentNews) {
        newResidentList.add(New.fromJson(i));
      }
      newResidentList.sort(
        (a, b) => b.createdTime!.compareTo(a.createdTime ?? ""),
      );
      var projectNews =
          await APINew.getNewList(5, 0, "PROJECT", accountId ?? '');
      for (var i in projectNews) {
        newProjectList.add(New.fromJson(i));
      }
      newProjectList.sort(
        (a, b) => b.createdTime!.compareTo(a.createdTime ?? ""),
      );
      // ignore: use_build_context_synchronously

      await APIEvent.getEventList(0, 1, "COMING", accountId ?? "").then((v) {
        if (v.length >= 0) {
          event = Event.fromJson(v[0]);
        }
      });
      isEventLoading = false;
      isResNewsLoading = false;
      isProNewsLoading = false;
      notifyListeners();
    } catch (e) {
      isEventLoading = false;
      isResNewsLoading = false;
      isProNewsLoading = false;

      notifyListeners();
      Utils.showErrorMessage(context!, e.toString());
    }
  }
}
