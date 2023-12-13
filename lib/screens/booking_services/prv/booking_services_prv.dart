import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_booking_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/booking_service.dart';
import '../../../utils/utils.dart';

class BookingServicesPrv extends ChangeNotifier {
  List<BookingService> services = [];
  List<BookingService> viewServices = [];

  Future getBookingServiceList(BuildContext context) async {
    var isResident = context.read<ResidentInfoPrv>().selectedApartment != null;
    // && context.read<ResidentInfoPrv>().selectedApartment != null;
    await APIBookingService.getServiceList().then((v) {
      if (v != null) {
        services.clear();
        viewServices.clear();
        for (var i in v) {
          var se = BookingService.fromMap(i);
          services.add(se);
          if ((se.object == 'resident' || se.object == 'all') && isResident) {
            viewServices.add(se);
          } else if ((se.object == 'guest' || se.object == 'all') &&
              !isResident) {
            viewServices.add(se);
          }
        }
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });

    notifyListeners();
  }
}
