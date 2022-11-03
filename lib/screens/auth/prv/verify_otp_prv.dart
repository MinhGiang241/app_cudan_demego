import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../generated/l10n.dart';
import '../../../services/api_auth.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_dialog.dart';
import '../fogot_pass/reset_pass_screen.dart';
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
  final String pass;
  late Timer timer;
  VerifyOTPPrv(this.authPrv, this.user, this.name, this.pass, this.email) {
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  bool isLoading = false;
  bool isResending = false;

  _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      second--;
      timeResendController.add(second);
      if (second == 0) {
        t.cancel();
      }
    });
  }

  verify(BuildContext context, bool isForgotPass) async {
    if (otpController.text.isEmpty || otpController.text.length < 6) {
      _onError();
    } else {
      isLoading = true;
      notifyListeners();
      if (isForgotPass) {
        await APIAuth.generateToken(
                phoneNum: user, otp: otpController.text, context: context)
            .then((value) {
          isLoading = false;
          notifyListeners();
          // if (value.status == null) {
          //   if (value.code == 0) {
          //     Utils.pushScreen(
          //         context, ResetPassScreen(phone: user, token: value.message!));
          //   } else {
          //     Utils.showDialog(
          //         context: context,
          //         dialog: PrimaryDialog.errorCode(code: value.code));
          //   }
          // } else {
          //   if (value.status == 'internet_error') {
          //     Utils.showDialog(
          //         context: context,
          //         dialog:
          //             PrimaryDialog.error(msg: 'S.of(context).network_error'));
          //   } else {
          //     Utils.showDialog(
          //         context: context,
          //         dialog: PrimaryDialog.error(
          //             msg: 'S.of(context).err_x(value.message ?? "")'));
          //   }
          // }
        });
      } else {
        await authPrv.onVerify(context, user, otpController.text).then((value) {
          isLoading = false;
          notifyListeners();
        });
      }
    }
  }

  _onError() {
    errorAnimationController.add(ErrorAnimationType.shake);
  }

  resend(BuildContext context) async {
    isResending = true;
    notifyListeners();
    //   await APIAuth.createAccount(
    //           phoneNum: phone,
    //           fullName: name,
    //           email: email,
    //           passWord: pass,
    //           confirmPassword: pass)
    //       .then((value) {
    //     isResending = false;
    //     notifyListeners();
    //     if (value.status == null) {
    //       second = 60;
    //       _startTimer();
    //     } else {
    //       if (value.status == "internet_error") {
    //         Utils.showDialog(
    //             context: context,
    //             dialog: PrimaryDialog.error(
    //               msg: ' S.of(context).network_error',
    //             ));
    //       } else {
    //         Utils.showDialog(
    //             context: context,
    //             dialog: PrimaryDialog.error(
    //               msg: 'S.of(context).err_x(value.message ?? "")',
    //             ));
    //       }
    //     }
    //   });
  }
}
