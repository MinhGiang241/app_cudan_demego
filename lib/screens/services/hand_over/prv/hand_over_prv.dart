import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_hand_over.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/hand_over.dart';
import '../../../../utils/utils.dart';

class HandOverPrv extends ChangeNotifier {
  List<AppointmentSchedule> listHandOverSchedule = [];
  Future getHandOverBookingByResidentId(
    BuildContext context,
  ) async {
    var residentId = context.read<ResidentInfoPrv>().residentId;
    await APIHandOver.getApointmentScheduleList(residentId).then((v) {
      listHandOverSchedule.clear();
      for (var i in v) {
        listHandOverSchedule.add(AppointmentSchedule.fromMap(i));
      }
      print(listHandOverSchedule);
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
