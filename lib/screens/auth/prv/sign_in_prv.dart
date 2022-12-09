import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../services/prf_data.dart';
import '../../../utils/utils.dart';
import 'auth_prv.dart';

class SingInPrv extends ChangeNotifier {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? accountValidate;
  String? passValidate;

  final AuthPrv authPrv;
  SingInPrv({required this.authPrv});

  bool isLoading = false;

  initAccountSave() async {
    var acc = await PrfData.shared.getSignInStore();
    if (acc != null && acc['acc'] != null && acc['pass'] != null) {
      accountController.text = acc['acc'];
      passController.text = acc['pass'];
    }
  }

  signIn(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      accountValidate = passValidate = null;
      isLoading = true;
      notifyListeners();
      await authPrv
          .onSignIn(context, accountController.text, passController.text)
          .then((value) {
        isLoading = false;
        notifyListeners();
      }).catchError((e) {
        isLoading = false;
        notifyListeners();
        Utils.showErrorMessage(context, e);
      });
    } else {
      context.read<AuthPrv>().authStatus = AuthStatus.unauthen;
      isLoading = false;
      if (accountController.text.isEmpty) {
        accountValidate = S.current.can_not_empty;
      } else {
        accountValidate = null;
      }
      if (passController.text.isEmpty) {
        passValidate = S.current.can_not_empty;
      } else {
        passValidate = null;
      }
      notifyListeners();
    }
  }
}
