import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_dialog.dart';
import '../../../../generated/l10n.dart';
import 'package:flutter/material.dart';

class ChangePassPrv extends ChangeNotifier {
  final TextEditingController currentPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController cNewPassController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? validateCurrentPass;
  String? validateNewPass;
  String? validateCNewPass;

  bool isLoading = false;

  changePass(BuildContext context, String phoneNum) async {
    if (formKey.currentState!.validate()) {
      validateCurrentPass = null;
      validateNewPass = null;
      validateCNewPass = null;
      isLoading = true;
      notifyListeners();
      await APIAuth.changePass(
              phoneNum: phoneNum,
              oldPass: currentPassController.text,
              newPass: newPassController.text)
          .then((value) async {
        isLoading = false;
        notifyListeners();
        // if (value.status == null) {
        //   if (value.success == true) {
        //     await Utils.showDialog(
        //         context: context,
        //         dialog: PrimaryDialog.success(
        //           msg: "", // S.of(context).update_success,
        //         )).then((value) {
        //       // Utils.pop(context);
        //     });
        //   } else {
        //     Utils.showDialog(
        //         context: context,
        //         dialog: PrimaryDialog.error(
        //           msg: "", //S.of(context).err_x(value.message ?? ""),
        //         ));
        //   }
        // } else {
        //   Utils.showDialog(
        //       context: context,
        //       dialog: PrimaryDialog.error(
        //         msg: "", // S.of(context).err_x(value.message ?? ""),
        //       ));
        // }
      });
    } else {
      if (currentPassController.text.isEmpty) {
        validateCurrentPass = ""; // S.of(context).can_not_be_empty;
      } else {
        validateCurrentPass = null;
      }

      if (newPassController.text.isEmpty) {
        validateNewPass = ""; //S.of(context).can_not_be_empty;
      } else {
        validateNewPass = null;
      }

      if (cNewPassController.text.isEmpty) {
        validateCNewPass = ""; // S.of(context).can_not_be_empty;
      } else if (cNewPassController.text != newPassController.text) {
        validateCNewPass = ""; //S.of(context).rgstr_code_2;
      } else {
        validateCNewPass = null;
      }
      notifyListeners();
    }
  }
}
