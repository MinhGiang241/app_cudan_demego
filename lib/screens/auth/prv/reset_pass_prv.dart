import 'package:app_cudan/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../services/api_auth.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_dialog.dart';

class ResetPassPrv extends ChangeNotifier {
  final newPassController = TextEditingController();
  final cNewPassController = TextEditingController();

  String? validateNewPass;
  String? validateCNewPass;

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String user;
  String token;

  ResetPassPrv(this.user, this.token);

  resetPass(BuildContext context) async {
    if (formKey.currentState!.validate() &&
        newPassController.text.trim() == cNewPassController.text.trim()) {
      validateNewPass = validateCNewPass = null;
      isLoading = true;
      notifyListeners();
      await APIAuth.resetPassword(user, newPassController.text.trim())
          .then((v) {
        isLoading = false;
        notifyListeners();
        Utils.showSuccessMessage(
            context: context,
            e: S.of(context).reset_pass_success,
            onClose: () {
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            });
      }).catchError((e) {
        isLoading = false;
        notifyListeners();
        Utils.showErrorMessage(context, e);
      });
    } else {
      if (newPassController.text.isEmpty) {
        validateNewPass = S.of(context).not_blank;
      } else {
        validateNewPass = null;
      }
      if (cNewPassController.text.isEmpty) {
        validateCNewPass = S.of(context).not_blank;
      } else if (newPassController.text.trim() !=
          cNewPassController.text.trim()) {
        validateCNewPass = S.of(context).rgstr_code_2;
      } else {
        validateCNewPass = null;
      }
    }
  }
}
