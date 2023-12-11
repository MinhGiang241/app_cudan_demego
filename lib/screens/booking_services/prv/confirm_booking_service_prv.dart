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
    this.bookingRegistration,
    required this.oldContext,
  }) {
    var residentId = oldContext.read<ResidentInfoPrv>().residentId;
    var userInfo = oldContext.read<ResidentInfoPrv>().userInfo;
    var phone = userInfo?.phone_required ?? userInfo?.account?.phone;
    var apartment = oldContext.read<ResidentInfoPrv>().selectedApartment;
    var isResident = residentId != null && apartment != null;
    var now = DateTime.now();
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
    if (bookingRegistration != null && service.service_charge != 'nocharge') {
      var configResidentIndex = bookingRegistration?.booking_info
          ?.indexWhere((e) => e.object == 'resident');
      if (configResidentIndex != null && configResidentIndex != -1) {
        var bi = bookingRegistration?.booking_info![configResidentIndex];
        configResident = {
          'price': bi?.price,
          'price_adult': bi?.num_adult,
          'price_child': bi?.num_child,
          'price_adult_weekend': bi?.num_adult_weekend,
          'price_child_weekend': bi?.price_child_weekend,
        };
      }

      var configGuestIndex = bookingRegistration?.booking_info
          ?.indexWhere((e) => e.object == 'guest');
      if (configGuestIndex != null && configGuestIndex != -1) {
        var bi = bookingRegistration?.booking_info![configGuestIndex];
        configGuest = {
          'price': bi?.price,
          'price_adult': bi?.num_adult,
          'price_child': bi?.num_child,
          'price_adult_weekend': bi?.num_adult_weekend,
          'price_child_weekend': bi?.price_child_weekend,
        };
      }
    }

    if (mode == 0) {
      bookingRegistration = RegisterBookingService(
        shelfLifeId: shelfLife?.shelfLife?.id,
        total_price: price,
        fee: service.service_charge,
        serviceConfigurationId: service.id,
        note: service.note,
        // address:,
        // confirm_use: confirm_use,
        total_num_ticket: type == "month" ? num : null,
        status: 'WAIT_USE',
        payment_status:
            service.service_charge == 'nocharge' ? 'free' : 'UNPAID',
        time_slot: '$time_start - $time_end',
        ticket_type: service.ticket_type,
        agree_to_terms_of_service: confirm_use,
        object: isResident ? 'resident' : 'guest',
        residentId: residentId,
        apartmentId: apartment?.apartmentId,
        registration_type: type,
        end_date: type == 'month'
            ? DateTime(now.year, now.month + 1, now.day).toIso8601String()
            : null,
        use_date: dateString,
        phone_number: phone,
        filter_fee: service.service_charge == 'nocharge' ? 'free' : 'charges',
        areaId: area.id,
        booking_info: [
          if (service.service_charge == "nocharge" && type == "turn")
            BookingInfo(
              fee: 0,
              num: 0,
              num_adult: num,
              price: 0,
              price_child: 0,
              price_adult: 0,
              num_child: 0,
              object: isResident ? 'resident' : 'guest',
            ),
          if (configResident != null && !checkNullConfig(configResident!))
            BookingInfo(
              object: 'resident',
              fee: service.ticket_type == 'ageclassified'
                  ? (guestFee?.price ?? 0.0)
                  : 0.0,
              num: num,
              price: num *
                  (service.ticket_type == 'ageclassified'
                      ? (guestFee?.price ?? 0.0)
                      : 0.0),
              num_adult: service.ticket_type == 'ageclassified'
                  ? (configResident?['price_adult'] ?? 0)
                  : 0,
              num_child: service.ticket_type == 'ageclassified'
                  ? (configResident?['price_child'] ?? 0)
                  : 0,
              price_adult: (service.ticket_type == 'ageclassified'
                      ? (configResident?['price_adult'] ?? 0.0)
                      : 0.0) *
                  (residentFee?.price_adult ?? 0),
              price_child: (service.ticket_type == 'ageclassified'
                      ? (configResident?['price_child'] ?? 0.0)
                      : 0.0) *
                  (residentFee?.price_adult ?? 0),
            ),
          if (configGuest != null && !checkNullConfig(configGuest!))
            BookingInfo(
              object: 'guest',
              fee: service.ticket_type == 'ageclassified'
                  ? (guestFee?.price ?? 0.0)
                  : 0.0,
              num: num,
              price: num *
                  (service.ticket_type == 'ageclassified'
                      ? (guestFee?.price ?? 0.0)
                      : 0.0),
              num_adult: service.ticket_type == 'ageclassified'
                  ? (configGuest?['price_adult'] ?? 0)
                  : 0,
              num_child: service.ticket_type == 'ageclassified'
                  ? (configGuest?['price_child'] ?? 0)
                  : 0,
              price_adult: (service.ticket_type == 'ageclassified'
                      ? (configGuest?['price_adult'] ?? 0.0)
                      : 0.0) *
                  (guestFee?.price_adult ?? 0),
              price_child: (service.ticket_type == 'ageclassified'
                      ? (configGuest?['price_child'] ?? 0.0)
                      : 0.0) *
                  (guestFee?.price_child ?? 0),
            ),
        ],
      );
    }
  }
  BuildContext oldContext;
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
        return false;
      }
    }
    return true;
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
      total_price: type == "month"
          ? isResident
              ? (shelfLife?.price_resident ?? 0) * num
              : (shelfLife?.price_guest ?? 0) * num
          : null,

      fee: service.service_charge,
      serviceConfigurationId: service.id,
      note: service.note,
      // address:,
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
          ? DateTime(now.year, now.month + 1, now.day).toIso8601String()
          : null,
      use_date: dateString,
      phone_number: phone,
      filter_fee: service.service_charge == 'nocharge' ? 'free' : 'charges',
      areaId: area.id,
      booking_info: [
        if (service.service_charge == "nocharge" && type == "turn")
          BookingInfo(
            fee: 0,
            num: 0,
            num_adult: num,
            price: 0,
            price_child: 0,
            price_adult: 0,
            num_child: 0,
            object: isResident ? 'resident' : 'guest',
          ),
        if (configResident != null && !checkNullConfig(configResident!))
          BookingInfo(
            object: 'resident',
            fee: service.ticket_type == 'ageclassified'
                ? (guestFee?.price ?? 0.0)
                : 0.0,
            num: num,
            price: num *
                (service.ticket_type == 'ageclassified'
                    ? (guestFee?.price ?? 0.0)
                    : 0.0),
            num_adult: service.ticket_type == 'ageclassified'
                ? (configResident?['price_adult'] ?? 0)
                : 0,
            num_child: service.ticket_type == 'ageclassified'
                ? (configResident?['price_child'] ?? 0)
                : 0,
            price_adult: (service.ticket_type == 'ageclassified'
                    ? (configResident?['price_adult'] ?? 0.0)
                    : 0.0) *
                (residentFee?.price_adult ?? 0),
            price_child: (service.ticket_type == 'ageclassified'
                    ? (configResident?['price_child'] ?? 0.0)
                    : 0.0) *
                (residentFee?.price_adult ?? 0),
          ),
        if (configGuest != null && !checkNullConfig(configGuest!))
          BookingInfo(
            object: 'guest',
            fee: service.ticket_type == 'ageclassified'
                ? (guestFee?.price ?? 0.0)
                : 0.0,
            num: num,
            price: num *
                (service.ticket_type == 'ageclassified'
                    ? (guestFee?.price ?? 0.0)
                    : 0.0),
            num_adult: service.ticket_type == 'ageclassified'
                ? (configGuest?['price_adult'] ?? 0)
                : 0,
            num_child: service.ticket_type == 'ageclassified'
                ? (configGuest?['price_child'] ?? 0)
                : 0,
            price_adult: (service.ticket_type == 'ageclassified'
                    ? (configGuest?['price_adult'] ?? 0.0)
                    : 0.0) *
                (guestFee?.price_adult ?? 0),
            price_child: (service.ticket_type == 'ageclassified'
                    ? (configGuest?['price_child'] ?? 0.0)
                    : 0.0) *
                (guestFee?.price_child ?? 0),
          ),
        // if (type == "month")
        //   BookingInfo(
        //     object: isResident ? 'resident' : 'guest',
        //   ),
      ],
    );
    var data = registration.toMap();
    await APIBookingService.changeStatusRegisterService(data, 'WAIT_USE')
        .then((v) {
      loading = false;
      notifyListeners();
      // if (v != null) {
      // bookingRegistration = RegisterBookingService.fromMap(v);
      // mode = 1;
      Utils.showSuccessMessage(
        context: context,
        e: S.of(context).success_booking(service.name ?? ''),
        onClose: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HistoryRegisterServiceScreen.routeName,
            (route) => route.isFirst,
            arguments: {
              'init': bookingRegistration?.registration_type == 'month' ? 1 : 0,
            },
          );
        },
      );
      // }
      notifyListeners();
    }).catchError((e) {
      loading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e);
    });
  }

  onCancelService(BuildContext context) async {
    var booking = bookingRegistration?.copyWith();

    if (booking != null) {
      var status =
          booking.filter_fee == 'charges' ? "CANCELLATION_APPROVAL" : "CANCEL";
      Utils.showConfirmMessage(
        context: context,
        title: S.of(context).cancel_reg,
        content: S.of(context).confirm_cancel_request(booking.code ?? ''),
        onConfirm: () async {
          loading = true;
          notifyListeners();
          await APIBookingService.changeStatusRegisterService(
            booking.toMap(),
            "CANCEL",
          ).then((v) {
            loading = false;
            notifyListeners();
            Utils.showSuccessMessage(
              context: context,
              e: status == "CANCELLATION_APPROVAL"
                  ? S.of(context).success_send_to_cancel
                  : S.of(context).success_can_req,
              onClose: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HistoryRegisterServiceScreen.routeName,
                  (route) => route.isFirst,
                  arguments: {
                    'init': bookingRegistration?.registration_type == 'month'
                        ? 1
                        : 0,
                  },
                );
              },
            );
          }).catchError((e) {
            loading = false;
            notifyListeners();
            Utils.showErrorMessage(context, e);
          });
        },
      );
    }
  }
}
