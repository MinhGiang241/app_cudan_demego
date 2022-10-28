import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
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

  signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      phoneValidate = passValidate = null;
      isLoading = true;
      notifyListeners();
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
    } else {
      if (nameController.text.isEmpty) {
        nameValidate = S.of(context).can_not_empty;
      } else {
        nameValidate = null;
      }
      if (phoneController.text.isEmpty) {
        phoneValidate = S.of(context).can_not_empty;
      } else {
        phoneValidate = null;
      }
      if (passController.text.isEmpty) {
        passValidate = S.of(context).can_not_empty;
      } else {
        passValidate = null;
      }
      if (cPassController.text.isEmpty) {
        cPassValidate = S.of(context).can_not_empty;
      } else {
        if (cPassController.text != passController.text) {
          cPassValidate = S.of(context).rgstr_code_2;
        } else {
          cPassValidate = null;
        }
      }
      notifyListeners();
    }
  }
}
