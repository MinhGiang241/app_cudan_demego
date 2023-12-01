import 'package:flutter/cupertino.dart';

import '../../../models/area.dart';
import '../../../models/booking_service.dart';

class ConfirmBookingServicePrv extends ChangeNotifier {
  ConfirmBookingServicePrv({
    required this.service,
    required this.time_start,
    required this.time_end,
    required this.area,
    required this.dateString,
    required this.num,
    required this.mode,
  });
  BookingService service;
  String time_start;
  String time_end;
  Area area;
  String dateString;
  int num;
  int mode;

  setMode(int value) {
    mode = value;
    notifyListeners();
  }
}
