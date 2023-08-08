import 'dart:async';

import 'package:app_cudan/services/api_notification.dart';
import 'package:flutter/material.dart';

import '../../../models/notification.dart';
import '../../../utils/utils.dart';
import 'undread_noti.dart';

class NotificationPrv extends ChangeNotifier {
  int unRead = 0;
  int limit = 10;
  int skip = 0;
  String selectedType = '';

  var key = UniqueKey();

  setUnread(int v) {
    unRead = v;
    //notifyListeners();
  }

  resetSelectType() {
    selectedType = '';
  }

  List<NotificationAccessor> notificationList = [];
  List<NotificationType> notiTypeList = [];

  markReadNotification(
    NotificationAccessor e,
    int index,
  ) async {
    var a = e.id;
    print(a);
    notificationList[index].isRead = true;
    var indexCount = UnreadNotification.unReadCount
        .indexWhere((i) => i.id == e.message?.typeId);
    if (indexCount != -1 &&
        UnreadNotification.unReadCount[indexCount].total != null) {
      UnreadNotification.unReadCount[indexCount].total =
          UnreadNotification.unReadCount[indexCount].total! - 1;
    }
    UnreadNotification.count.add(unRead);
    notifyListeners();
    await APINotification.markReadNotification(e.id);
    // await getUnReadNotification();s
  }

  setSelectedType(String typeID) async {
    selectedType = typeID;
    key = UniqueKey();
    //await getNotiflcationList(true);
    notifyListeners();
  }

  // Future getUnReadNotification() async {
  //   await APINotification.getUnreadNotfication().then((v) {
  //     unRead = 0;
  //     if (v != null) {
  //       unReadCount.clear();
  //       for (var i in v) {
  //         unRead += i['total'] as int;
  //         unReadCount.add(UnReadCount.fromMap(i));
  //       }
  //     } else {
  //       unRead = 0;
  //     }
  //     UnreadNotification.count.add(unRead);
  //     notifyListeners();
  //   });
  // }

  Future getInitData(BuildContext context) async {
    try {
      await getNotificationTypeList();
      await getNotificationList(true);
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }

  Future getNotificationTypeList() async {
    await APINotification.getNotficationTypeList().then((v) {
      print(v);
      if (v != null) {
        notiTypeList.clear();
        for (var i in v) {
          notiTypeList.add(NotificationType.fromMap(i));
        }
      }

      print(notiTypeList);
    });
  }

  Future getNotificationList(bool isInit) async {
    if (isInit) {
      skip = 0;
    }
    await APINotification.getNotficationList(selectedType, skip, limit)
        .then((v) {
      if (v != null) {
        if (isInit) {
          notificationList.clear();
        }
        skip += 10;
        for (var i in v) {
          notificationList.add(NotificationAccessor.fromMap(i));
        }
      }
      print(notificationList);
      notifyListeners();
    });
  }
}
