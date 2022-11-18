// ignore_for_file: use_build_context_synchronously

import 'package:app_cudan/constants/regex_text.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../models/account.dart';
import '../../../services/api_auth.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_dialog.dart';
import '../fogot_pass/option_send_otp.dart';
import '../verify_otp_screen.dart';

class ForgotPassPrv extends ChangeNotifier {
  ForgotPassPrv({
    required this.isForgotPass,
  });
  final phoneController = TextEditingController();

  String? phoneValidate;
  String? user;

  String? phoneNumber;
  String? email;
  String? userName;
  final bool isForgotPass;

  final formKey = GlobalKey<FormState>();
  // final formKey1 = GlobalKey<FormState>();

  bool isLoading = false;

  sendOtpViaPhone(BuildContext context, String? phone, String userName) async {
    isLoading = true;
    notifyListeners();
    await APIAuth.sendOTPviaPhone(phoneNumber!).then((v) {}).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  sendOtpViaEmail(BuildContext context, String? mail, String userNa) async {
    isLoading = true;
    notifyListeners();
    if (mail != null) {
      await APIAuth.sendOtpViaEmail(mail).then(
        (data) {
          isLoading = false;
          notifyListeners();
          Utils.pushScreen(
              context,
              VerifyOTPScreen(
                isForgotPass: true,
                phone: '',
                name: userNa,
                pass: '',
                email: mail,
                isPhone: false,
              ));
          if (data != null) {}
        },
      );
    }
  }

  getEmailAndPhone(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        phoneValidate = null;
        isLoading = true;
        userName = phoneController.text.trim();
        if (RegexText.isEmail(phoneController.text.trim())) {
          var userNameByEmail =
              await APIAuth.findUserNameByEmail(email: userName!);
          if (userNameByEmail != null) {
            userName = userNameByEmail;
          }
        }
        var userInfoResponseData =
            await APIAuth.getUserInformationByUsername(userName!);

        var userInfoResponse = Account.fromJson(userInfoResponseData);
        if (userInfoResponse == null) {
          isLoading = false;
          notifyListeners();
          throw (S.of(context).not_found_account);
        } else {
          var userInfo = userInfoResponse;
          phoneNumber = userInfo.phone_number;
          email = userInfo.email;
          isLoading = false;
          notifyListeners();

          Utils.pushScreen(
              context,
              (OptionSendOtp(
                userName: userName,
                isForgotPass: true,
                email: email,
                phone: phoneNumber,
              )));
        }
      } catch (e) {
        isLoading = false;
        notifyListeners();
        Utils.showErrorMessage(context, e.toString());
      }
    }
  }

  sendVerify(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      phoneValidate = null;
      isLoading = true;
      notifyListeners();
    } else {
      if (phoneController.text.isEmpty) {
        phoneValidate = 'S.of(context).can_not_empty';
      } else {
        phoneValidate = null;
      }
      notifyListeners();
    }
  }
}
