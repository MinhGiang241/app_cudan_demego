import 'package:app_cudan/models/booking_service.dart';
import 'package:flutter/material.dart';

import '../../../models/area.dart';
import '../../../models/transportation_card.dart';
import '../../../services/api_booking_service.dart';
import '../../../services/api_transport.dart';
import '../../../utils/utils.dart';

class MonthBookingServicePrv extends ChangeNotifier {
  MonthBookingServicePrv({required this.service, required this.type}) {
    getShelfLife();
    getLocationList();

    // var guestIndex =
    //     service.list_of_fees_by_month?.indexWhere((e) => e.object == "guest");
    // guestFee = (service.list_of_fees_by_month != null &&
    //         guestIndex != null &&
    //         guestIndex != -1)
    //     ? service.list_of_fees_by_turn![guestIndex]
    //     : null;
  }
  BookingService service;
  String type;
  int? timeOption = 0;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  List<FeeByMonth> shelflifeList = [];
  String? selectedShelfLifeId;
  int? selectedShelfLifeIndex;
  int? selectedAreaIndex;
  List<Area> areas = [];
  double price = 0;
  FeeByMonth? guestFee;
  FeeByMonth? residentFee;

  selectTime(int? value) {
    timeOption = value;
    notifyListeners();
  }

  getShelfLife() async {
    var data = service.toMap();
    await APIBookingService.getShelfLifeList(
      data['list_of_fees_by_month'] ?? [],
    ).then((v) {
      if (v != null) {
        shelflifeList.clear();
        selectedShelfLifeIndex = null;
        for (var i in v) {
          shelflifeList.add(FeeByMonth.fromMap(i));
        }
      }
      print(shelflifeList);
      notifyListeners();
    }).catchError((e) => {});
  }

  getLocationList() async {
    var data = service.toMap();
    await APIBookingService.getAreaListBooking(
      null,
      null,
      data['list_of_service_areas'] ?? [],
    ).then((v) {
      if (v != null) {
        areas.clear();
        for (var i in v) {
          areas.add(Area.fromMap(i));
        }
      }
    }).catchError((e) {
      print(e);
      //Utils.showErrorMessage(context, e);
    });
  }

  onChangeArea(v) {
    selectedAreaIndex = 1;
    notifyListeners();
  }

  onChangeShelfLife(v) {
    if (v != null) {
      selectedShelfLifeIndex = v;
      if (startDate != null) {
        var freeByMonth = shelflifeList[selectedShelfLifeIndex!];
        endDate = DateTime(
          startDate!.year,
          startDate!.month + (freeByMonth.shelfLife?.use_time ?? 0),
          startDate!.day,
        );
        endDateController.text =
            Utils.dateFormat(endDate!.toIso8601String(), 0);

        price = service.service_charge == 'nocharge' ? 0 : 0;
      }
      notifyListeners();
    }
  }

  pickStartDate(BuildContext context) {
    Utils.showDatePickers(
      context,
      initDate: DateTime.now(),
      startDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      endDate: (service.isLimitedDaysRegistration == true &&
              service.limited_days_registration_num != null)
          ? DateTime(
              DateTime.now()
                  .add(
                    Duration(
                      days: service.limited_days_registration_num!,
                    ),
                  )
                  .year,
              DateTime.now()
                  .add(
                    Duration(
                      days: service.limited_days_registration_num!,
                    ),
                  )
                  .month,
              DateTime.now()
                  .add(
                    Duration(
                      days: service.limited_days_registration_num!,
                    ),
                  )
                  .day,
            )
          : DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        startDate = v;
        startDateController.text = Utils.dateFormat(v.toIso8601String(), 0);
        if (selectedShelfLifeIndex != null) {
          var shelfLife = shelflifeList[selectedShelfLifeIndex!];
          endDate = DateTime(
            startDate!.year,
            startDate!.month + (shelfLife.shelfLife?.use_time ?? 0),
            startDate!.day,
          );
          endDateController.text =
              Utils.dateFormat(endDate!.toIso8601String(), 0);
        }
      } else {}
    });
  }
}
