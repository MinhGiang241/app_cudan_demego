import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import 'prv/change_pass_prv.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  @override
  Widget build(BuildContext context) {
    var accountId = context.read<ResidentInfoPrv>().userInfo?.account?.id;
    return ChangeNotifierProvider<ChangePassPrv>(
      create: (context) => ChangePassPrv(),
      builder: (context, snapshot) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).change_pass,
            // actions: [
            //   if (!context.watch<ChangePassPrv>().isLoading)
            //     TextButton(
            //         onPressed: () async {
            //           // final phoneNum =
            //           //     context.read<AuthPrv>().userInfo!.phone!;
            //           await context
            //               .read<ChangePassPrv>()
            //               .changePass(context, accountId);
            //         },
            //         child: Text(S.of(context).save,
            //             style: txtLinkMedium(color: primaryColorBase)))
            //   else
            //     const SizedBox(
            //       width: 64,
            //       child: Center(
            //           child: Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 10),
            //         child: PrimaryLoading(height: 20, width: 20),
            //       )),
            //     ),
            // ],
          ),
          body: ListView(
            children: [
              vpad(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Form(
                  onChanged: () =>
                      context.read<ChangePassPrv>().validate(context),
                  autovalidateMode: context.watch<ChangePassPrv>().autoValidate
                      ? AutovalidateMode.onUserInteraction
                      : null,
                  key: context.read<ChangePassPrv>().formKey,
                  child: Column(
                    children: [
                      PrimaryTextField(
                        onTap: () {},
                        controller:
                            context.read<ChangePassPrv>().currentPassController,
                        label: S.of(context).current_pass,
                        hint: S.of(context).current_pass,
                        obscureText: true,
                        isRequired: true,
                        validateString:
                            context.watch<ChangePassPrv>().validateCurrentPass,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                      ),
                      vpad(16),
                      PrimaryTextField(
                        controller:
                            context.read<ChangePassPrv>().newPassController,
                        label: S.of(context).new_pass,
                        hint: S.of(context).new_pass,
                        obscureText: true,
                        isRequired: true,
                        maxLines: 1,
                        validateString:
                            context.watch<ChangePassPrv>().validateNewPass,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "";
                          } else if (v ==
                              context
                                  .read<ChangePassPrv>()
                                  .currentPassController
                                  .text) {
                            return "";
                          }
                          return null;
                        },
                      ),
                      vpad(16),
                      PrimaryTextField(
                        controller:
                            context.read<ChangePassPrv>().cNewPassController,
                        label: S.of(context).c_new_pass,
                        hint: S.of(context).c_new_pass,
                        obscureText: true,
                        isRequired: true,
                        validateString:
                            context.watch<ChangePassPrv>().validateCNewPass,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "";
                          } else if (v !=
                              context
                                  .read<ChangePassPrv>()
                                  .newPassController
                                  .text) {
                            return "";
                          }
                          return null;
                        },
                      ),
                      vpad(30),
                      PrimaryButton(
                        onTap: () async {
                          await context
                              .read<ChangePassPrv>()
                              .changePass(context, accountId);
                        },
                        width: double.infinity,
                        isLoading: context.watch<ChangePassPrv>().isLoading,
                        text: S.of(context).confirm,
                      ),
                      vpad(40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
