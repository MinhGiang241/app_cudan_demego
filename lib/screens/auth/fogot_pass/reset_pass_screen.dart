import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';

import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';

import '../prv/reset_pass_prv.dart';

class ResetPassScreen extends StatelessWidget {
  const ResetPassScreen({Key? key, required this.user, required this.token})
      : super(key: key);
  static const routeName = '/reset-password';
  final String user;
  final String token;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResetPassPrv>(
      create: (context) => ResetPassPrv(user, token),
      builder: (context, snapshot) {
        return PrimaryScreen(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
            child: Form(
              key: context.read<ResetPassPrv>().formKey,
              child: ListView(
                // padding: const EdgeInsets.all(24),
                children: [
                  vpad(24),
                  Center(
                    child: Text(
                      S.of(context).reset_pass,
                      style: txtDisplayMedium(),
                    ),
                  ),
                  vpad(45),
                  PrimaryTextField(
                    blockSpace: true,
                    controller: context.read<ResetPassPrv>().newPassController,
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
                    blockSpace: true,
                    controller: context.read<ResetPassPrv>().cNewPassController,
                    obscureText: true,
                    isRequired: true,
                    label: S.of(context).c_new_pass,
                    hint: S.of(context).enter_pas,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "";
                      } else if (v !=
                          context.read<ResetPassPrv>().newPassController.text) {
                        return "";
                      }
                      return null;
                    },
                    validateString:
                        context.watch<ResetPassPrv>().validateCNewPass,
                  ),
                  vpad(30),
                  PrimaryButton(
                    isLoading: context.watch<ResetPassPrv>().isLoading,
                    onTap: context.watch<ResetPassPrv>().isLoading
                        ? () {}
                        : () async {
                            FocusScope.of(context).unfocus();

                            await context
                                .read<ResetPassPrv>()
                                .resetPass(context);
                          },
                    text: S.of(context).confirm,
                    // isLoading: context.watch<ResetPassPrv>().isLoading,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
