import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../services/prf_data.dart';
import '../../ho/prv/ho_account_service_prv.dart';
import 'auth_prv.dart';

class SingInPrv extends ChangeNotifier {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? accountValidate;
  String? passValidate;

  final AuthPrv authPrv;
  SingInPrv({required this.authPrv}) {
    initAccountSave();
  }

  bool isLoading = false;

  initAccountSave() async {
    var acc = await PrfData.shared.getSignInStore();
    if (acc != null && acc['acc'] != null && acc['pass'] != null) {
      final a = acc['acc'];
      final p = acc['pass'];
      accountController.text = a;
      passController.text = p;
      notifyListeners();
    }
    return 0;
  }

  signIn(BuildContext context, bool remember) async {
    if (formKey.currentState!.validate()) {
      accountValidate = passValidate = null;
      isLoading = true;
      notifyListeners();

      var acc = await PrfData.shared.getSignInStore();
      if (acc != null && acc['acc'] != null && acc['pass'] != null) {
        final a = acc['acc'];
        final p = acc['pass'];
        if (accountController.text != a || passController.text != p) {
          PrfData.shared.deleteProject();
          PrfData.shared.deleteSignInStore();
          PrfData.shared.deleteApartment();
        }
        notifyListeners();
      }
      // await authPrv
      //     .onSignIn(context, accountController.text, passController.text)
      await context
          .read<HOAccountServicePrv>()
          .loginHO(
            accountController.text.trim(),
            passController.text.trim(),
            context,
            remember,
          )
          .then((value) async {
        isLoading = false;
        notifyListeners();
        return;
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
      return;
    }
  }
}
