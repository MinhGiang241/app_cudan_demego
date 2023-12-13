import 'package:app_cudan/models/booking_service.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/area.dart';
import '../../../services/api_booking_service.dart';
import '../../../utils/utils.dart';
import '../confirm_booking_service.dart';

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
  TextEditingController feeController = TextEditingController();
  TextEditingController guestAddressController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  List<FeeByMonth> shelflifeList = [];
  int? selectedShelfLifeIndex;
  int? selectedAreaIndex;
  List<Area> areas = [];
  double price = 0;
  FeeByMonth? guestFee;
  FeeByMonth? residentFee;
  String? startValidate;
  String? endValidate;
  String? shelfLifeValidate;
  String? areaValidate;
  String? guestAddressValidate;
  bool autoValid = false;
  final formKey = GlobalKey<FormState>();
  final formatCurrency = NumberFormat.simpleCurrency(locale: "vi");

  genValidateString() {
    if (startDate == null) {
      startValidate = S.current.not_blank;
    } else {
      startValidate = null;
    }

    if (selectedAreaIndex == null) {
      areaValidate = S.current.not_blank;
    } else {
      areaValidate = null;
    }

    if (selectedShelfLifeIndex == null) {
      shelfLifeValidate = S.current.not_blank;
    } else {
      shelfLifeValidate = null;
    }
    if (guestAddressController.text.trim().isEmpty) {
      guestAddressValidate = S.current.not_blank;
    } else {
      guestAddressValidate = null;
    }

    // if (endDate != null && endDate!.compareTo(DateTime.now()) < 0) {
    //   endValidate = S.current.end_date_after_now;
    // } else {
    //   endValidate = null;
    // }
    notifyListeners();
  }

  clearValidate() {
    startValidate = null;
    areaValidate = null;
    shelfLifeValidate = null;
    notifyListeners();
  }

  validate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      clearValidate();
    } else {
      genValidateString();
    }
  }

  countFee(BuildContext context) {
    var isResident =
        //context.read<ResidentInfoPrv>().residentId != null &&
        context.read<ResidentInfoPrv>().selectedApartment != null;
    if (selectedShelfLifeIndex != null) {
      price = service.service_charge == 'nocharge'
          ? 0
          : (isResident
              ? (shelflifeList[selectedShelfLifeIndex!].price_resident ?? 0)
              : (shelflifeList[selectedShelfLifeIndex!].price_guest ?? 0));
      feeController.text = formatCurrency.format(price).replaceAll("₫", "VND");
      notifyListeners();
    }
  }

  selectTime(int? value) {
    timeOption = value;
    notifyListeners();
  }

  getShelfLife() async {
    var data = service.toMap();
    await APIBookingService.getShelfLifeList(
      data['list_of_fees_by_month'] ?? [],
    ).then((v) {
      print(data);
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
      notifyListeners();
    }).catchError((e) {
      print(e);
      //Utils.showErrorMessage(context, e);
    });
  }

  onChangeArea(v) {
    selectedAreaIndex = v;
    areaValidate = null;
    notifyListeners();
  }

  onChangeShelfLife(context, v) {
    if (v != null) {
      selectedShelfLifeIndex = v;
      countFee(context);
      shelfLifeValidate = null;
      if (startDate != null) {
        var freeByMonth = shelflifeList[selectedShelfLifeIndex!];
        if (freeByMonth.shelfLife?.type_time == 'TH') {
          endDate = DateTime(
            startDate!.year,
            startDate!.month + (freeByMonth.shelfLife?.use_time ?? 0),
            startDate!.day,
          );
        } else if (freeByMonth.shelfLife?.type_time == 'N') {
          endDate = DateTime(
            startDate!.year + (freeByMonth.shelfLife?.use_time ?? 0),
            startDate!.month,
            startDate!.day,
          );
        } else if (freeByMonth.shelfLife?.type_time == 'NG') {
          endDate = DateTime(
            startDate!.year,
            startDate!.month,
            startDate!.day + (freeByMonth.shelfLife?.use_time ?? 0),
          );
        }

        endDateController.text =
            Utils.dateFormat(endDate!.toIso8601String(), 0);
      }
      notifyListeners();
    }
  }

  onNext(BuildContext context) {
    autoValid = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      clearValidate();
      Navigator.pushNamed(
        context,
        ConfirmBookingService.routeName,
        arguments: {
          'service': service,
          'type': type,
          'time-start':
              service.list_hours_of_operation_per_day?[timeOption!].time_start,
          'time-end':
              service.list_hours_of_operation_per_day?[timeOption!].time_end,
          'area': areas[selectedAreaIndex!],
          'date': startDate!.toIso8601String(),
          'end_date': endDate!.toIso8601String(),
          'fee_month': shelflifeList[selectedShelfLifeIndex!],
          'num': 1,
          'mode': 0,
          'price': price,
          "guest-address": guestAddressController.text.trim()
          // "guest-cfg": configGuest,
          // 'resident-cfg': configResident,
        },
      );
    } else {
      genValidateString();
      notifyListeners();
    }
  }

  pickStartDate(BuildContext context) {
    Utils.showDatePickers(
      context,
      initDate: DateTime.now(),
      startDate: DateTime(
        DateTime.now().year - 100,
        DateTime.now().month,
        DateTime.now().day,
      ),
      endDate:
          // (service.isLimitedDaysRegistration == true &&
          //         service.limited_days_registration_num != null)
          //     ? DateTime(
          //         DateTime.now()
          //             .add(
          //               Duration(
          //                 days: service.limited_days_registration_num!,
          //               ),
          //             )
          //             .year,
          //         DateTime.now()
          //             .add(
          //               Duration(
          //                 days: service.limited_days_registration_num!,
          //               ),
          //             )
          //             .month,
          //         DateTime.now()
          //             .add(
          //               Duration(
          //                 days: service.limited_days_registration_num!,
          //               ),
          //             )
          //             .day,
          //       )
          //     :
          DateTime(DateTime.now().year + 10, 1, 1),
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
