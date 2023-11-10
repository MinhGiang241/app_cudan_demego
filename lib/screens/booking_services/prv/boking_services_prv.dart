import 'package:app_cudan/services/api_booking_service.dart';
import 'package:flutter/material.dart';

import '../../../models/booking_service.dart';
import '../../../utils/utils.dart';

class BookingServicesPrv extends ChangeNotifier {
  List<BoookingService> services = [];

  Future getBookingServiceList(BuildContext context) async {
    await APIBookingService.getServiceList().then((v) {
      if (v != null) {
        services.clear();
        for (var i in v) {
          services.add(BoookingService.fromMap(i));
        }
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });

    notifyListeners();
  }
}
