import 'package:flutter/material.dart';

import '../../../models/event.dart';
import '../../../services/api_event.dart';
import '../../../utils/utils.dart';

class EventTabPrv extends ChangeNotifier {
  EventTabPrv({required this.type});
  List<Event> listEvent = [];
  final String type;
  int skip = 0;
  int limit = 5;

  Future getEventList(BuildContext context, bool isFirst) async {
    if (isFirst) {
      listEvent.clear();
      skip = 0;
    } else {
      skip += 5;
    }
    await APIEvent.getEventList(skip, limit, type).then(
      (values) {
        for (var i in values) {
          listEvent.add(Event.fromJson(i));
        }
        notifyListeners();
      },
    ).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
