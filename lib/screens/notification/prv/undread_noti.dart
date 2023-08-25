import 'dart:async';
import '../../../models/notification.dart';
import '../../../services/api_notification.dart';

class UnreadNotification {
  static StreamController<int> count = StreamController.broadcast();
  static List<UnReadCount> unReadCount = [];

  static Future getUnReadNotification() async {
    await APINotification.getUnreadNotfication().then((v) {
      var unRead = 0;
      if (v != null) {
        unReadCount.clear();
        for (var i in v) {
          unRead += i['total'] as int;
          unReadCount.add(UnReadCount.fromMap(i));
        }
      } else {
        unRead = 0;
      }
      UnreadNotification.count.add(unRead);
    });
  }
}
