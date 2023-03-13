import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
    notifyListeners();
    await APIAuth.sendOtpViaEmail(email).then((v) {
      Utils.showSuccessMessage(context: context, e: S.of(context).success_opt);

      second = 30;
      notifyListeners();
      _startTimer();
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
