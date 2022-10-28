import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../prv/forgot_pass_prv.dart';
import '../verify_otp_screen.dart';

class PhoneNumForgotPassScreen extends StatelessWidget {
  const PhoneNumForgotPassScreen({Key? key}) : super(key: key);
  static const routeName = '/forgot';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPassPrv>(
        create: (context) => ForgotPassPrv(),
        builder: (context, snapshot) {
          return PrimaryScreen(
            appBar: PrimaryAppbar(title: S.of(context).forgot_pass),
            body: Form(
              key: context.read<ForgotPassPrv>().formKey,
              child: SafeArea(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  children: [
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
                          Utils.pushScreen(
                              context,
                              VerifyOTPScreen(
                                  phone: '',
                                  name: "",
                                  pass: "",
                                  isForgotPass: true));
                          // await context
                          //     .read<ForgotPassPrv>()
                          //     .sendVerify(context);
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
