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

  String phone;
  String token;

  ResetPassPrv(this.phone, this.token);

  resetPass(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      validateNewPass = validateCNewPass = null;
      isLoading = true;
      notifyListeners();
      await APIAuth.resetPass(
              phoneNum: phone,
              token: token,
              newPass: newPassController.text,
              confirmPass: cNewPassController.text)
          .then((value) {
        isLoading = false;
        notifyListeners();
        if (value.status == null) {
          if (value.code == 0) {
            Utils.showDialog(
                    context: context,
                    dialog: PrimaryDialog.success(
                        msg: "S.of(context).update_success"))
                .then((value) {
              int count = 3;
              Navigator.popUntil(context, (route) => count-- == 0);
            });
          } else {
            Utils.showDialog(
                context: context,
                dialog: PrimaryDialog.errorCode(code: value.code));
          }
        } else {
          if (value.status == 'internet_error') {
            Utils.showDialog(
                context: context,
                dialog:
                    PrimaryDialog.error(msg: "S.of(context).network_error"));
          } else {
            Utils.showDialog(
                context: context,
                dialog: PrimaryDialog.error(
                    msg: "S.of(context).err_x(value.message ?? " ")"));
          }
        }
      });
    } else {
      if (newPassController.text.isEmpty) {
        validateNewPass = S.of(context).can_not_empty;
      } else {
        validateNewPass = null;
      }
      if (cNewPassController.text.isEmpty) {
        validateCNewPass = S.of(context).can_not_empty;
      } else if (cNewPassController.text != newPassController.text) {
        validateCNewPass = "S.of(context).rgstr_code_2";
      } else {
        validateCNewPass = null;
      }
      notifyListeners();
    }
  }
}
