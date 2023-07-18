import 'package:app_cudan/services/api_notification.dart';
import 'package:flutter/material.dart';

import '../../../models/notification.dart';
import '../../../utils/utils.dart';

class NotificationPrv extends ChangeNotifier {
  int unRead = 0;
  int limit = 10;
  int skip = 0;
  String selectedType = '';

  List<NotificationAccessor> notificationList = [];
  List<NotificationType> notiTypeList = [];

  setSelectedType(String typeID) async {
    selectedType = typeID;
    await getNotiflcationList(true);
    notifyListeners();
  }

  Future getUnReadNotification(BuildContext context) async {
    await APINotification.getUnreadNotfication().then((v) {
      unRead = v != null ? v.length : 0;
    });
  }

  Future getInitData(BuildContext context) async {
    try {
      await getNotificationTypeList();
      await getNotiflcationList(true);
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

  Future getNotiflcationList(bool isInit) async {
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
    });
  }
}
