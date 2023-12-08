import 'package:app_cudan/models/booking_service.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_booking_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/utils.dart';

class HistoryRegisterServicePrv extends ChangeNotifier {
  List<RegisterBookingService> monthList = [];
  List<RegisterBookingService> turnList = [];
  var turnRefreshController = RefreshController(initialRefresh: false);
  var monthRefreshController = RefreshController(initialRefresh: false);
  var emptyMonthRefreshController = RefreshController(initialRefresh: false);
  var emptyTurnRefreshController = RefreshController(initialRefresh: false);

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
        if (type == 'month') {
          monthList.clear();
        }
        if (type == 'turn') {
          turnList.clear();
        }
        for (var i in v) {
          var reg = RegisterBookingService.fromMap(i);
          if (reg.registration_type == 'month') {
            monthList.add(reg);
          }
          if (reg.registration_type == 'turn') {
            turnList.add(reg);
          }
        }
      }
      notifyListeners();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
