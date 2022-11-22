import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../generated/l10n.dart';
import '../../../services/api_auth.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_dialog.dart';
import '../fogot_pass/reset_pass_screen.dart';
import '../sign_in_screen.dart';
import 'auth_prv.dart';

class VerifyOTPPrv extends ChangeNotifier {
  final TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType> errorAnimationController =
      StreamController.broadcast();
  StreamController<int> timeResendController = StreamController.broadcast();

  final formKey = GlobalKey<FormState>();

  String? otpValidate;

  int second = 60;

  final AuthPrv authPrv;
  final String user;
  final String name;
  final String email;
  final String phone;
  final String pass;
  final bool isPhone;
  late Timer timer;
  VerifyOTPPrv(this.authPrv, this.user, this.name, this.pass, this.email,
      this.phone, this.isPhone) {
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  bool isLoading = false;
  bool isResending = false;

  offTextError() {
    otpValidate = null;
    notifyListeners();
  }

  _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      second--;
      timeResendController.add(second);
      if (second == 0) {
        t.cancel();
      }
    });
  }

  verify(BuildContext context, bool isForgotPass, Function verify) async {
    if (otpController.text.isEmpty || otpController.text.length < 6) {
      _onError();
    } else {
      otpValidate = null;
      isLoading = true;
      notifyListeners();
      if (isForgotPass) {
        await authPrv
            .onVerify(context, name, email, phone, otpController.text,
                isForgotPass, isPhone, () {})
            .then((value) {
          isLoading = false;
          notifyListeners();
        });
      } else {
        await verify().then((v) {});
        // await
        //  authPrv
        //     .onVerify(context, name, email, phone, otpController.text,
        //         isForgotPass, isPhone, verify)
        //     .then((value) {
        //   isLoading = false;
        //   notifyListeners();
        // });
        isLoading = false;
        notifyListeners();
      }
    }
  }

  _onError() {
    otpValidate = S.current.otp_invalid;
    notifyListeners();
    errorAnimationController.add(ErrorAnimationType.shake);
  }

  resend(BuildContext context) async {
    isResending = true;
    notifyListeners();

    if (isPhone) {
      await APIAuth.sendOTPviaPhone(phone).then((v) {
        Utils.showSuccessMessage(
            context: context, e: S.of(context).success_opt);
        second = 60;
        notifyListeners();
      }).catchError((e) {
        Utils.showErrorMessage(context, e);
      });
      isResending = false;
      notifyListeners();
    } else {
      await APIAuth.sendOtpViaEmail(email).then((v) {
        Utils.showSuccessMessage(
            context: context, e: S.of(context).success_opt);
        second = 60;
        notifyListeners();
      }).catchError((e) {
        Utils.showErrorMessage(context, e);
      });
      isResending = false;
      notifyListeners();
    }
  }
}
