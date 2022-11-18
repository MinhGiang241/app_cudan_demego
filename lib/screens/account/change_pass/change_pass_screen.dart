import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_loading.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../../auth/prv/auth_prv.dart';
import 'prv/change_pass_prv.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePassPrv>(
        create: (context) => ChangePassPrv(),
        builder: (context, snapshot) {
          return PrimaryScreen(
            appBar: PrimaryAppbar(
              // title:  S.of(context).change_pass,
              actions: [
                if (!context.watch<ChangePassPrv>().isLoading)
                  TextButton(
                      onPressed: () async {
                        final phoneNum =
                            context.read<AuthPrv>().userInfo!.phone!;
                        await context
                            .read<ChangePassPrv>()
                            .changePass(context, phoneNum);
                      },
                      child: Text(S.of(context).save,
                          style: txtLinkMedium(color: primaryColorBase)))
                else
                  const SizedBox(
                    width: 64,
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: PrimaryLoading(height: 20, width: 20),
                    )),
                  ),
              ],
            ),
            body: ListView(
              children: [
                vpad(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Form(
                    key: context.read<ChangePassPrv>().formKey,
                    child: Column(
                      children: [
                        PrimaryTextField(
                          controller: context
                              .read<ChangePassPrv>()
                              .currentPassController,
                          label: S.of(context).current_pass,
                          hint: S.of(context).current_pass,
                          obscureText: true,
                          isRequired: true,
                          validateString: context
                              .watch<ChangePassPrv>()
                              .validateCurrentPass,
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
                              }
                              return null;
                            }),
                        vpad(16),
                        PrimaryTextField(
                            controller: context
                                .read<ChangePassPrv>()
                                .cNewPassController,
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
                            }),
                        vpad(16)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
