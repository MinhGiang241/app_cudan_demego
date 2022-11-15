// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../services/api_auth.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_dialog.dart';
import '../verify_otp_screen.dart';

class ForgotPassPrv extends ChangeNotifier {
  final phoneController = TextEditingController();

  String? phoneValidate;

  String? phoneNumber;
  String? email;

  final formKey = GlobalKey<FormState>();
  // final formKey1 = GlobalKey<FormState>();

  bool isLoading = false;

  sendOtpViaEmail(BuildContext context, String? mail) async {
    isLoading = true;
    notifyListeners();
    if (mail != null) {
      await APIAuth.sendOtpViaEmail(mail).then(
        (data) {
          isLoading = false;
          notifyListeners();
          if (data == null) {
            Utils.showConnectionError(context);
          }
          if (data['authorization_generate_otp']['code'] != 0) {
            Utils.showErrorMessage(
                context, data['authorization_generate_otp']['message']);
          }
        },
      ).catchError((e) {
        isLoading = false;
        notifyListeners();
        Utils.showErrorMessage(context, e);
      });
    }
  }

  getEmailAndPhone(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      phoneValidate = null;
      isLoading = true;
      var userInfoResponse = await APIAuth.getUserInformationByUsername(
          phoneController.text.trim());
      if (userInfoResponse == null) {
        isLoading = false;
        notifyListeners();
        throw (S.of(context).err_conn);
      } else if (userInfoResponse['response']['data'] != null) {
        var userInfo = userInfoResponse['response']['data'];
        phoneNumber = userInfo['phone_number'];
        email = userInfo['email'];
        isLoading = false;
        notifyListeners();
      } else {
        var mess = userInfoResponse['response']['message'];
        isLoading = false;
        notifyListeners();
        throw (mess);
      }
    }
  }

  sendVerify(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      phoneValidate = null;
      isLoading = true;
      notifyListeners();
      await APIAuth.forgotPass(
              phoneNum: phoneController.text.trim(), context: context)
          .then((value) {
        isLoading = false;
        notifyListeners();
        // if (value.status == null) {
        //   if (value.code == 6) {
        //     Utils.pushScreen(
        //         context,
        //         VerifyOTPScreen(
        //             phone: phoneController.text,
        //             name: "",
        //             pass: "",
        //             isForgotPass: true));
        //   } else {
        //     Utils.showDialog(
        //         context: context,
        //         dialog: PrimaryDialog.errorCode(code: value.code));
        //   }
        // } else {
        //   if (value.status == 'internet_error') {
        //     Utils.showDialog(
        //         context: context,
        //         dialog:
        //             PrimaryDialog.error(msg: 'S.of(context).network_error'));
        //   } else {
        //     Utils.showDialog(
        //         context: context,
        //         dialog: PrimaryDialog.error(
        //             msg: 'S.of(context).err_x(value.message ?? "")'));
        //   }
        // }
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
