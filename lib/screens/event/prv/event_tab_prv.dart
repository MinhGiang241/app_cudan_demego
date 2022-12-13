import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
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
    await APIEvent.getEventList(skip, limit, type,
            context.read<ResidentInfoPrv>().userInfo!.account!.id ?? "")
        .then(
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

  Future participateEvent(BuildContext context, Event e) async {
    Navigator.pop(context);
    var paticipation = EventParticipation(
      accountId: context.read<ResidentInfoPrv>().userInfo!.account!.id,
      eventId: e.id,
      event_for: e.event_for,
    );

    await APIEvent.participateEvent(paticipation.toJson()).then((v) {
      Utils.showSuccessMessage(
          context: context,
          e: S.of(context).scuccess_participation(
              e.title != null ? e.title!.toLowerCase() : ""));
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
