// ignore_for_file: require_trailing_commas

import 'package:app_cudan/screens/auth/sign_in_screen.dart';
import 'package:app_cudan/screens/home/home_screen.dart';

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
  bool autoValidate = false;

  genValidate() {
    if (currentPassController.text.isEmpty) {
      validateCurrentPass = S.current.not_blank; // S.current.can_not_be_empty;
    } else {
      validateCurrentPass = null;
    }

    if (newPassController.text.isEmpty) {
      validateNewPass = S.current.not_blank; //S.current.can_not_be_empty;
    } else {
      validateNewPass = null;
    }

    if (cNewPassController.text.isEmpty) {
      validateCNewPass = S.current.not_blank; // S.current.can_not_be_empty;
    } else if (cNewPassController.text != newPassController.text) {
      validateCNewPass = S.current.rgstr_code_2; //S.current.rgstr_code_2;
    } else {
      validateCNewPass = null;
    }
    notifyListeners();
  }

  clearValidate() {
    validateCurrentPass = null;
    validateNewPass = null;
    validateCNewPass = null;
    notifyListeners();
  }

  validate(BuildContext context) {
    if (autoValidate) {
      if (formKey.currentState!.validate()) {
        clearValidate();
      } else {
        genValidate();
      }
    }

    notifyListeners();
  }

  changePass(BuildContext context, String? accountId) async {
    FocusScope.of(context).unfocus();
    autoValidate = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      isLoading = true;

      clearValidate();
      await APIAuth.changePassword(
              currentPassController.text.trim(),
              newPassController.text.trim(),
              cNewPassController.text.trim(),
              accountId)
          .then((v) {
        isLoading = false;
        notifyListeners();
        Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_change_pass,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => route.isFirst);
            });
      }).catchError((e) {
        isLoading = false;
        notifyListeners();
        Utils.showErrorMessage(context, e);
      });
      // await APIAuth.changePass(
      //         context: context,
      //         phoneNum: phoneNum,
      //         oldPass: currentPassController.text,
      //         newPass: newPassController.text)
      //     .then((value) async {
      //   isLoading = false;
      //   notifyListeners();
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
      // });
    } else {
      genValidate();
    }
  }
}
