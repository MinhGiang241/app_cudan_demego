import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/booking_services/history_register_service_screen.dart';
import 'package:app_cudan/services/api_booking_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/area.dart';
import '../../../models/booking_service.dart';
import '../../../utils/utils.dart';

class ConfirmBookingServicePrv extends ChangeNotifier {
  ConfirmBookingServicePrv({
    required this.service,
    required this.time_start,
    required this.time_end,
    required this.area,
    required this.dateString,
    required this.num,
    required this.mode,
    required this.type,
    this.configGuest,
    this.configResident,
    this.end_date,
    this.price,
    this.shelfLife,
  }) {
    var guestIndex =
        service.list_of_fees_by_turn?.indexWhere((e) => e.object == "guest");
    guestFee = (service.list_of_fees_by_turn != null &&
            guestIndex != null &&
            guestIndex != -1)
        ? service.list_of_fees_by_turn![guestIndex]
        : null;

    var residentIndex =
        service.list_of_fees_by_turn?.indexWhere((e) => e.object == "resident");
    residentFee = (service.list_of_fees_by_turn != null &&
            residentIndex != null &&
            residentIndex != -1)
        ? service.list_of_fees_by_turn![residentIndex]
        : null;
  }
  BookingService service;
  String time_start;
  String time_end;
  Area area;
  String dateString;
  String type;
  int num;
  int mode;
  bool loading = false;
  bool confirm_use = false;
  RegisterBookingService? bookingRegistration;
  Map<String, dynamic>? configGuest;
  Map<String, dynamic>? configResident;
  FeeByTurn? guestFee;
  FeeByTurn? residentFee;
  String? end_date;
  double? price;
  FeeByMonth? shelfLife;

  toggleConfirmUse() {
    confirm_use = !confirm_use;
    notifyListeners();
  }

  setMode(int value) {
    mode = value;
    notifyListeners();
  }

  bool checkNullConfig(Map<String, dynamic> data) {
    for (var i in data.keys) {
      if (data[i] != null && data[i] != 0) {
        return true;
      }
    }
    return false;
  }

  saveRegisterService(BuildContext context) async {
    loading = true;
    notifyListeners();
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var userInfo = context.read<ResidentInfoPrv>().userInfo;
    var phone = userInfo?.phone_required ?? userInfo?.account?.phone;
    var apartment = context.read<ResidentInfoPrv>().selectedApartment;
    var isResident = residentId != null && apartment != null;
    var now = DateTime.now();
    print(configGuest);
    print(configResident);

    var registration = RegisterBookingService(
      shelfLifeId: shelfLife?.shelfLife?.id,
      total_price: price,
      fee: service.service_charge,
      serviceConfigurationId: service.id,
      note: service.note,
      // confirm_use: confirm_use,
      total_num_ticket: type == "month" ? num : null,
      status: 'WAIT_USE',
      payment_status: service.service_charge == 'nocharge' ? 'free' : 'UNPAID',
      time_slot: '$time_start - $time_end',
      ticket_type: service.ticket_type,
      agree_to_terms_of_service: confirm_use,
      object: isResident ? 'resident' : 'guest',
      residentId: residentId,
      apartmentId: apartment?.apartmentId,
      registration_type: type,
      end_date: type == 'month'
          ? DateTime(now.year, now.month + 1, now.day).toUtc().toIso8601String()
          : null,
      use_date: dateString,
      phone_number: phone,
      filter_fee: service.service_charge == 'nocharge' ? 'free' : 'charges',
      areaId: area.id,
      booking_info: [
        if (configResident != null && !checkNullConfig(configResident!))
          BookingInfo(
            object: 'resident',
            fee: service.ticket_type == 'ageclassifided'
                ? 0.0
                : (residentFee?.price ?? 0.0),
            num: num,
            price: num *
                (service.ticket_type == 'ageclassifided'
                    ? 0.0
                    : (residentFee?.price ?? 0.0)),
            num_adult: service.ticket_type == 'ageclassifided'
                ? (configResident?['price_adult'] ?? 0)
                : 0,
            num_child: service.ticket_type == 'ageclassifided'
                ? (configResident?['price_child'] ?? 0)
                : 0,
            price_adult: (service.ticket_type == 'ageclassifided'
                    ? (configResident?['price_adult'] ?? 0.0)
                    : 0.0) *
                (residentFee?.price_adult ?? 0),
            price_child: (service.ticket_type == 'ageclassifided'
                    ? (configResident?['price_child'] ?? 0.0)
                    : 0.0) *
                (residentFee?.price_adult ?? 0),
          ),
        if (configGuest != null && !checkNullConfig(configGuest!))
          BookingInfo(
            object: 'guest',
            fee: service.ticket_type == 'ageclassifided'
                ? 0.0
                : (guestFee?.price ?? 0.0),
            num: num,
            price: num *
                (service.ticket_type == 'ageclassifided'
                    ? 0.0
                    : (guestFee?.price ?? 0.0)),
            num_adult: service.ticket_type == 'ageclassifided'
                ? (configGuest?['price_adult'] ?? 0)
                : 0,
            num_child: service.ticket_type == 'ageclassifided'
                ? (configGuest?['price_child'] ?? 0)
                : 0,
            price_adult: (service.ticket_type == 'ageclassifided'
                    ? (configGuest?['price_adult'] ?? 0.0)
                    : 0.0) *
                (guestFee?.price_adult ?? 0),
            price_child: (service.ticket_type == 'ageclassifided'
                    ? (configGuest?['price_child'] ?? 0.0)
                    : 0.0) *
                (guestFee?.price_child ?? 0),
          ),
      ],
    );
    var data = registration.toMap();
    await APIBookingService.saveRegiterService(data).then((v) {
      loading = false;
      notifyListeners();
      if (v != null) {
        bookingRegistration = RegisterBookingService.fromMap(v);
        mode = 1;
        Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_booking(service.name ?? ''),
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HistoryRegisterServiceScreen.routeName,
                (route) => route.isFirst,
              );
            });
      }
      notifyListeners();
    }).catchError((e) {
      loading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e);
    });
  }
}
