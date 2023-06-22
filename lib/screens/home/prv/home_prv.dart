import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_event.dart';
import 'package:app_cudan/services/api_new.dart';

import '../../../models/event.dart';
import '../../../models/new.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';
import '../../chat/bloc/chat_message_bloc.dart';

class HomePrv extends ChangeNotifier {
  Event? event;
  bool isLoading = false;
  bool isResNewsLoading = false;
  bool isProNewsLoading = false;
  bool isEventLoading = false;
  List<New> newResidentList = [];
  List<New> newProjectList = [];
  BuildContext? context;
  int? messageCount;
  bool onNavigatorFooter = true;

  HomePrv(ctx) {
    context = ctx;
    initial();
  }
  onParticipate() {
    if (event != null) {
      event!.isParticipation = true;
    }
    notifyListeners();
  }

  clearMessageBadge() async {
    messageCount = null;
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

  toogleNavigatorFooter() {
    onNavigatorFooter = !onNavigatorFooter;
  }

  Future initial() async {
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
        if (v.length >= 1) {
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
    notifyListeners();
  }
}
