import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../services/api_auth.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_dialog.dart';
import '../verify_otp_screen.dart';

class ForgotPassPrv extends ChangeNotifier {
  final phoneController = TextEditingController();

  String? phoneValidate;

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  sendVerify(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      phoneValidate = null;
      isLoading = true;
      notifyListeners();
      await APIAuth.forgotPass(phoneNum: phoneController.text).then((value) {
        isLoading = false;
        notifyListeners();
        if (value.status == null) {
          if (value.code == 6) {
            Utils.pushScreen(
                context,
                VerifyOTPScreen(
                    phone: phoneController.text,
                    name: "",
                    pass: "",
                    isForgotPass: true));
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
                    PrimaryDialog.error(msg: 'S.of(context).network_error'));
          } else {
            Utils.showDialog(
                context: context,
                dialog: PrimaryDialog.error(
                    msg: 'S.of(context).err_x(value.message ?? "")'));
          }
        }
      });
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
