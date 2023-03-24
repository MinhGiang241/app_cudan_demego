import 'dart:async';

import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';

class OtpAddEmailPrv extends ChangeNotifier {
  OtpAddEmailPrv({required this.email}) {
    _startTimer();
  }
  final TextEditingController otpController = TextEditingController();
  final String email;
  String? otpValidate;
  StreamController<ErrorAnimationType> errorAnimationController =
      StreamController.broadcast();
  StreamController<int> timeResendController = StreamController.broadcast();
  bool isResending = false;
  int second = 30;
  bool isLoading = false;
  bool isRendLoading = false;
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
    isRendLoading = true;
    notifyListeners();
    await APIAuth.sendOtpAddMoreEmail(
      email,
      false,
      context.read<ResidentInfoPrv>().userInfo?.account?.id ?? "",
    ).then((v) {
      Utils.showSuccessMessage(context: context, e: S.of(context).success_opt);
      isRendLoading = false;

      second = 30;
      notifyListeners();
      _startTimer();
    }).catchError((e) {
      isRendLoading = false;
      notifyListeners();
      Utils.showErrorMessage(context, e);
    });
  }

  verify(BuildContext context) async {
    var accountId = context.read<ResidentInfoPrv>().userInfo?.account?.id;

    await APIAuth.verifyOtpAddMoreEmail(
      email,
      accountId!,
      otpController.text.trim(),
    ).then((v) {
      context.read<ResidentInfoPrv>().setEmail(email);
      Utils.showSuccessMessage(
        context: context,
        e: S.of(context).success_add_email,
        onClose: () {
          int count = 0;
          Navigator.of(context).popUntil((_) => ++count >= 2);
        },
      );
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
