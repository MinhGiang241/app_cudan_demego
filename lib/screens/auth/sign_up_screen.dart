import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_screen.dart';
import '../../widgets/primary_text_field.dart';
import 'prv/auth_prv.dart';
import 'prv/sign_up_prv.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, this.isFromSignIn = false}) : super(key: key);
  static const routeName = '/sign-up';
  final bool isFromSignIn;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<SignUpPrv>(
    //     create: (context) => SignUpPrv(context.read<AuthPrv>()),
    //     builder: (context, snapshot) {
    return PrimaryScreen(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: ListView(
        children: [
          vpad(24),
          Center(
              child: Text(S.of(context).create_acc, style: txtDisplayMedium())),
          vpad(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).have_acc,
                  style: txtMedium(14, grayScaleColor2)),
              hpad(14),
              InkWell(
                  onTap: () {
                    if (widget.isFromSignIn) {
                      Utils.pop(context);
                    } else {
                      Utils.pushScreen(
                          context, const SignInScreen(isFromSignUp: true));
                    }
                  },
                  borderRadius: BorderRadius.circular(5),
                  child: Text(S.of(context).sign_in,
                      style: txtLinkSmall(color: primaryColorBase)))
            ],
          ),
          vpad(34),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              // key: context.read<SignUpPrv>().formKey,
              child: Column(
                children: [
                  PrimaryTextField(
                    // controller: context.read<SignUpPrv>().nameController,
                    label: S.of(context).full_name,
                    hint: S.of(context).enter_name,
                    isRequired: true,
                    textCapitalization: TextCapitalization.words,
                    // validateString: context.watch<SignUpPrv>().nameValidate,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),
                  vpad(16),
                  PrimaryTextField(
                    // controller: context.read<SignUpPrv>().phoneController,
                    label: S.of(context).phone_num,
                    hint: S.of(context).enter_phone,
                    keyboardType: TextInputType.phone,
                    isRequired: true,
                    // validateString: context.watch<SignUpPrv>().phoneValidate,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),
                  vpad(16),
                  PrimaryTextField(
                    // controller: context.read<SignUpPrv>().emailController,
                    label: S.of(context).email,
                    hint: S.of(context).enter_email,
                    keyboardType: TextInputType.phone,
                    isRequired: true,
                    // validateString: context.watch<SignUpPrv>().emailValidate,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),
                  vpad(16),
                  PrimaryTextField(
                    // controller: context.read<SignUpPrv>().passController,
                    obscureText: true,
                    label: S.of(context).password,
                    hint: S.of(context).enter_pas,
                    isRequired: true,
                    // validateString: context.watch<SignUpPrv>().passValidate,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),
                  vpad(16),
                  PrimaryTextField(
                    // controller: context.read<SignUpPrv>().cPassController,s
                    obscureText: true,
                    label: S.of(context).confirm_pass,
                    hint: S.of(context).enter_pas,
                    isRequired: true,
                    // validateString: context.watch<SignUpPrv>().cPassValidate,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "";
                      } else if (v !=
                          context.read<SignUpPrv>().passController.text) {
                        return "";
                      }
                      return null;
                    },
                  ),
                  vpad(24),
                  Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: S.of(context).terms_services_msg,
                            style: txtMedium(14, grayScaleColor2)),
                        TextSpan(
                            text: S.of(context).terms_services,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // ignore: avoid_print
                                print("Tap");
                              },
                            style: txtLinkSmall(color: primaryColorBase)),
                      ]),
                      textAlign: TextAlign.center),
                  vpad(32),
                  PrimaryButton(
                    text: S.of(context).create_acc_1,
                    onTap: () async {
                      // await context.read<SignUpPrv>().signUp(context);
                    },
                    // isLoading: context.watch<SignUpPrv>().isLoading,
                    width: double.infinity,
                  ),
                  vpad(32),
                ],
              ),
            ),
          )
        ],
      ),
    );
    // });
  }
}
