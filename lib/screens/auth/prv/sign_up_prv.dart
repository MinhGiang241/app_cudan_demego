import 'package:app_cudan/constants/regex_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../services/api_auth.dart';
import '../../../utils/utils.dart';
import '../../ho/prv/ho_account_service_prv.dart';
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

  bool isAuto = false;

  String? nameValidate;
  String? phoneValidate;
  String? emailValidate;
  String? passValidate;
  String? cPassValidate;

  final AuthPrv authPrv;
  SignUpPrv({required this.authPrv});

  bool isLoading = false;

  validate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      cPassValidate =
          emailValidate = phoneValidate = passValidate = nameValidate = null;
    } else {
      genValidateString(context);
    }
    notifyListeners();
  }

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

  genValidateString(context) {
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
    } else if (passController.text.trim().length < 8) {
      passValidate = S.of(context).pass_min_length;
    } else if (!RegexText.requiredSpecialChar(passController.text.trim())) {
      passValidate = S.of(context).pass_special;
    } else {
      passValidate = null;
    }
    if (cPassController.text.trim().isEmpty) {
      cPassValidate = S.of(context).can_not_empty;
    } else if (cPassController.text.trim().length < 8) {
      cPassValidate = S.of(context).pass_min_length;
    } else if (cPassController.text.trim() != passController.text.trim()) {
      cPassValidate = S.of(context).rgstr_code_2;
    } else {
      cPassValidate = null;
    }
    if (emailController.text.trim().isEmpty) {
      emailValidate = S.of(context).not_blank;
    } else if (!RegexText.isEmail(emailController.text.trim())) {
      emailValidate = S.of(context).not_email;
    } else {
      emailValidate = null;
    }
    notifyListeners();
  }

  signUp(BuildContext context) async {
    isAuto = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      cPassValidate =
          emailValidate = phoneValidate = passValidate = nameValidate = null;
      notifyListeners();

      await context.read<HOAccountServicePrv>().createAccount(
            phoneController.text.trim(),
            passController.text.trim(),
            emailController.text.trim(),
            nameController.text.trim(),
            context,
          );

      onSignUp() async {
        // await authPrv.onCreateAccount(
        //   context,
        //   phoneController.text.trim(),
        //   nameController.text.trim(),
        //   emailController.text.trim(),
        //   passController.text.trim(),
        //   cPassController.text.trim(),
        // );

        Utils.showSuccessMessage(
          context: context,
          e: S.of(context).success_sign_up,
          onClose: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              SignInScreen.routeName,
              ((route) => route.isCurrent),
            );
          },
        );

        await APIAuth.createResidentAccount(
                context: context,
                user: phoneController.text.trim(),
                name: nameController.text.trim(),
                email: emailController.text.trim(),
                passWord: passController.text.trim(),
                confirmPassword: cPassController.text.trim())
            .then((value) {
          Utils.showSuccessMessage(
              context: context,
              e: S.of(context).success_sign_up,
              onClose: () {
                Navigator.pushReplacementNamed(context, SignInScreen.routeName);
              });
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });

        isLoading = false;
        notifyListeners();
      }

      // Utils.pushScreen(
      //     context,
      //     VerifyOTPScreen(
      //       isForgotPass: false,
      //       phone: phoneController.text.trim(),
      //       name: phoneController.text.trim(),
      //       pass: passController.text.trim(),
      //       email: emailController.text.trim(),
      //       verify: onSignUp,
      //       isPhone: true,
      //     ));
    } else {
      genValidateString(context);
    }
  }
}
