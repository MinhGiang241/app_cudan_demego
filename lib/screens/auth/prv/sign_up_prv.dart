import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../services/api_auth.dart';
import '../../../utils/utils.dart';
import '../sign_in_screen.dart';
import '../verify_otp_screen.dart';
import 'auth_prv.dart';

class SignUpPrv extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController cPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? nameValidate;
  String? phoneValidate;
  String? emailValidate;
  String? passValidate;
  String? cPassValidate;

  final AuthPrv authPrv;
  SignUpPrv({required this.authPrv});

  bool isLoading = false;

  sendOtpViaPhone(BuildContext context, String? phone) async {
    isLoading = true;
    notifyListeners();
    await APIAuth.sendOTPviaPhone(phoneController.text.trim()).then((v) {
      Utils.pushScreen(
          context,
          VerifyOTPScreen(
              isPhone: false,
              phone: phoneController.text.trim(),
              name: "",
              pass: "",
              email: '',
              isForgotPass: false));
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      cPassValidate =
          emailValidate = phoneValidate = passValidate = nameValidate = null;
      onSignUp() async {
        await authPrv
            .onCreateAccount(
          context,
          phoneController.text.trim(),
          nameController.text.trim(),
          emailController.text.trim(),
          passController.text.trim(),
          cPassController.text.trim(),
        )
            .then((value) {
          isLoading = false;
          notifyListeners();
        });
      }

      Utils.pushScreen(
          context,
          VerifyOTPScreen(
            isForgotPass: false,
            phone: phoneController.text.trim(),
            name: phoneController.text.trim(),
            pass: passController.text.trim(),
            email: emailController.text.trim(),
            verify: onSignUp,
            isPhone: true,
          ));
    } else {
      if (nameController.text.trim().isEmpty) {
        nameValidate = S.of(context).can_not_empty;
      } else {
        nameValidate = null;
      }
      if (phoneController.text.trim().isEmpty) {
        phoneValidate = S.of(context).can_not_empty;
      } else {
        phoneValidate = null;
      }
      if (passController.text.trim().isEmpty) {
        passValidate = S.of(context).can_not_empty;
      } else {
        passValidate = null;
      }
      if (cPassController.text.trim().isEmpty) {
        cPassValidate = S.of(context).can_not_empty;
      } else {
        if (cPassController.text.trim() != passController.text.trim()) {
          cPassValidate = S.of(context).rgstr_code_2;
        } else {
          cPassValidate = null;
        }
      }
      notifyListeners();
    }
  }
}
