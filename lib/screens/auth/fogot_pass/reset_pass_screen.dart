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

import '../prv/reset_pass_prv.dart';

class ResetPassScreen extends StatelessWidget {
  const ResetPassScreen({Key? key, required this.phone, required this.token})
      : super(key: key);
  final String phone;
  final String token;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResetPassPrv>(
        create: (context) => ResetPassPrv(phone, token),
        builder: (context, snapshot) {
          return PrimaryScreen(
            appBar: PrimaryAppbar(title: S.of(context).reset_pass),
            body: SafeArea(
              child: Form(
                key: context.read<ResetPassPrv>().formKey,
                child: ListView(
                  // padding: const EdgeInsets.all(24),
                  children: [
                    vpad(24),
                    PrimaryTextField(
                      controller:
                          context.read<ResetPassPrv>().newPassController,
                      obscureText: true,
                      isRequired: true,
                      label: S.of(context).new_pass,
                      hint: S.of(context).enter_pas,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      validateString:
                          context.watch<ResetPassPrv>().validateNewPass,
                    ),
                    vpad(16),
                    PrimaryTextField(
                      controller:
                          context.read<ResetPassPrv>().cNewPassController,
                      obscureText: true,
                      isRequired: true,
                      label: S.of(context).c_new_pass,
                      hint: S.of(context).enter_pas,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "";
                        } else if (v !=
                            context
                                .read<ResetPassPrv>()
                                .newPassController
                                .text) {
                          return "";
                        }
                        return null;
                      },
                      validateString:
                          context.watch<ResetPassPrv>().validateCNewPass,
                    ),
                    vpad(30),
                    PrimaryButton(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          Utils.showDialog(
                                  context: context,
                                  dialog: PrimaryDialog.success(
                                      msg: "S.of(context).update_success"))
                              .then((value) {
                            int count = 3;
                            Navigator.popUntil(
                                context, (route) => count-- == 0);
                          });
                          await context.read<ResetPassPrv>().resetPass(context);
                        },
                        text: S.of(context).reset_pass,
                        // isLoading: context.watch<ResetPassPrv>().isLoading,
                        width: double.infinity)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
