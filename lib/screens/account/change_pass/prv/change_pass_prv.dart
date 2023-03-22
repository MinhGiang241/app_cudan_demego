// ignore_for_file: require_trailing_commas, use_build_context_synchronously

import 'package:app_cudan/screens/auth/sign_in_screen.dart';
import 'package:app_cudan/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_dialog.dart';
import '../../../../generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../auth/prv/auth_prv.dart';
import '../../../auth/prv/resident_info_prv.dart';

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
    if (currentPassController.text.trim().isEmpty) {
      validateCurrentPass = S.current.not_blank; // S.current.can_not_be_empty;
    } else {
      validateCurrentPass = null;
    }

    if (newPassController.text.isEmpty) {
      validateNewPass = S.current.not_blank; //S.current.can_not_be_empty;
    } else if (currentPassController.text.trim() !=
        newPassController.text.trim()) {
      validateNewPass = S.current.pass_not_same;
    } else {
      validateNewPass = null;
    }

    if (cNewPassController.text.trim().isEmpty) {
      validateCNewPass = S.current.not_blank; // S.current.can_not_be_empty;
    } else if (cNewPassController.text.trim() !=
        newPassController.text.trim()) {
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
            onClose: () async {
              await APIAuth.signOut(context: context);
              context.read<AuthPrv>().authStatus = AuthStatus.unauthen;
              context.read<ResidentInfoPrv>().clearData();
              context.read<AuthPrv>().account = null;
              context.read<AuthPrv>().clearData();
              Navigator.pushNamedAndRemoveUntil(
                  context, SignInScreen.routeName, (route) => route.isFirst);
            });
      }).catchError((e) {
        isLoading = false;
        notifyListeners();
        Utils.showErrorMessage(context, e);
      });
    } else {
      genValidate();
    }
  }
}
