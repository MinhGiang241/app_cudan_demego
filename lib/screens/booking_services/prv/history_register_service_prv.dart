import 'package:app_cudan/models/booking_service.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_booking_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';

class HistoryRegisterServicePrv extends ChangeNotifier {
  List<RegisterBookingService> monthList = [];
  List<RegisterBookingService> turnList = [];

  Future getRegisterServiceList(String type, BuildContext context) async {
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    var phone = context.read<ResidentInfoPrv>().userInfo?.phone_required;
    await APIBookingService.getRegisterServiceHistoryList(
      type,
      residentId,
      apartmentId,
      phone,
    ).then((v) {
      if (v != null) {
        monthList.clear();
        turnList.clear();
        for (var i in v) {
          if (type == 'month') {
            monthList.add(RegisterBookingService.fromMap(i));
          }
          if (type == 'turn') {
            turnList.add(RegisterBookingService.fromMap(i));
          }
        }
      }
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
