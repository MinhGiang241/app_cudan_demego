import 'dart:async';

import 'package:app_cudan/services/api_hand_over.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/hand_over.dart';
import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';
import '../../../auth/prv/resident_info_prv.dart';
import '../hand_over_screen.dart';

class OtpBookingPrv extends ChangeNotifier {
  OtpBookingPrv({required this.schedule, required this.apartmentName}) {
    _startTimer();
  }

  final TextEditingController otpController = TextEditingController();
  late AppointmentSchedule schedule;
  String? otpValidate;
  String apartmentName;
  StreamController<ErrorAnimationType> errorAnimationController =
      StreamController.broadcast();
  StreamController<int> timeResendController = StreamController.broadcast();
  bool isResending = false;
  int second = 30;
  bool isLoading = false;
  bool isSendLoading = false;
  late Timer timer;
  _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      second--;
      timeResendController.add(second);
      if (second == 0) {
        t.cancel();
      }
    });
  }

  offTextError() {
    otpValidate = null;
    notifyListeners();
  }

  resend(BuildContext context) async {
    isResending = true;
    isSendLoading = true;
    notifyListeners();
    await APIAuth.sendOtpAddMoreEmail(
      "email",
      false,
      context.read<ResidentInfoPrv>().userInfo?.account?.id ?? "",
    ).then((v) {
      Utils.showSuccessMessage(context: context, e: S.of(context).success_opt);
      isSendLoading = false;

      second = 30;
      notifyListeners();
      _startTimer();
    }).catchError((e) {
      isSendLoading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e);
    });
  }

  verify(
    BuildContext context,
  ) async {
    if (otpController.text.isEmpty || otpController.text.length < 6) {
      _onError();
    } else {
      // var accountId = context.read<ResidentInfoPrv>().userInfo?.account?.id;
      // if (otpController.text == '000000') {
      isSendLoading = true;
      notifyListeners();
      APIHandOver.saveApointmentScheduleList(schedule.copyWith().toMap())
          .then((v) {
        isSendLoading = false;
        notifyListeners();
        Utils.showSuccessMessage(
          context: context,
          e: S.of(context).success_book_schedule(apartmentName),
          onClose: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HandOverScreen.routeName,
              (route) => route.isFirst,
              arguments: {
                "init": 0,
              },
            );
          },
        );
      }).catchError((e) {
        isSendLoading = false;
        notifyListeners();
        Utils.showErrorMessage(context, e);
      });
      // }
    }
  }

  _onError() {
    otpValidate = S.current.otp_invalid;
    notifyListeners();
    errorAnimationController.add(ErrorAnimationType.shake);
  }
}
