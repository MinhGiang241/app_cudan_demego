import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_dialog.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../prv/forgot_pass_prv.dart';
import '../verify_otp_screen.dart';
import 'option_send_otp.dart';

class PhoneNumForgotPassScreen extends StatefulWidget {
  PhoneNumForgotPassScreen({Key? key}) : super(key: key);
  static const routeName = '/forgot';

  @override
  State<PhoneNumForgotPassScreen> createState() =>
      _PhoneNumForgotPassScreenState();
}

class _PhoneNumForgotPassScreenState extends State<PhoneNumForgotPassScreen> {
  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  next() {
    if (pageIndex <= 4) {
      pageController.animateToPage(pageIndex++,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPassPrv>(
        create: (context) => ForgotPassPrv(),
        builder: (context, snapshot) {
          return PrimaryScreen(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: Form(
              key: context.read<ForgotPassPrv>().formKey,
              child: SafeArea(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  children: [
                    // vpad(24 + topSafePad(context) + appbarHeight(context)),
                    Center(
                      child: Text(
                        S.of(context).forgot_pass,
                        style: txtDisplayMedium(),
                      ),
                    ),
                    vpad(45),
                    PrimaryTextField(
                      controller: context.read<ForgotPassPrv>().phoneController,
                      label: S.of(context).phone_num,
                      hint: S.of(context).enter_phone,
                      keyboardType: TextInputType.phone,
                      isRequired: true,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      validateString:
                          context.watch<ForgotPassPrv>().phoneValidate,
                    ),
                    vpad(30),
                    PrimaryButton(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          await context
                              .read<ForgotPassPrv>()
                              .getEmailAndPhone(context)
                              .then((value) {
                            var email = context.read<ForgotPassPrv>().email;
                            var phone =
                                context.read<ForgotPassPrv>().phoneNumber;
                            Utils.pushScreen(
                                context,
                                (OptionSendOtp(
                                  email: email,
                                  phone: phone,
                                )));
                          }).catchError((e) {
                            Utils.showDialog(
                                context: context,
                                dialog: PrimaryDialog.error(
                                  msg: S.of(context).err_x(e),
                                ));
                          });
                        },
                        text: S.of(context).send_verify,
                        isLoading: context.watch<ForgotPassPrv>().isLoading,
                        width: double.infinity)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
