// ignore_for_file: use_build_context_synchronously

import 'package:app_cudan/screens/auth/prv/auth_prv.dart';
import 'package:app_cudan/screens/auth/prv/sign_in_prv.dart';
import 'package:app_cudan/screens/auth/sign_up_screen.dart';
import 'package:app_cudan/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_screen.dart';
import '../../widgets/primary_text_field.dart';
import '../account/language/cubit/lang_cubit.dart';
import 'fogot_pass/phone_num_forgot_pass.dart';

// ignore: must_be_immutable
class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key, this.isFromSignUp = false, this.context})
      : super(key: key);
  static const routeName = '/sign-in';
  bool isFromSignUp;
  final BuildContext? context;
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final arg = ModalRoute.of(context)!.settings.arguments as Map?;
      if (arg?['delete'] == true) {
        Utils.showSuccessMessage(
          context: context,
          e: S.of(context).already_delete_acc,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<SingInPrv>(
    //   create: (context) => SingInPrv(context.read<AuthPrv>()),
    //   builder: (context, state) {

    // final arg = ModalRoute.of(context)!.settings.arguments as bool?;
    // if (arg != null) {
    //   widget.isFromSignUp = arg;
    //   if (arg) {
    //     Provider.of<SingInPrv>(context, listen: false)
    //         .initAccountSave()
    //         .then((v) {
    //       PrfData.shared.deleteSignInStore();
    //     });
    //   }
    // }

    // final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    // if (arg != null && arg['c'] != null && arg['p'] != null) {
    //   Provider.of<SingInPrv>(context).initAccountSave().then((e) {
    //     // return PrfData.shared.deleteSignInStore();
    //   });
    // }
    return PrimaryScreen(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () => Navigator.pushReplacementNamed(
            context,
            SplashScreen.routeName,
            arguments: {'not-auto': true},
          ),
        ),
      ),
      body: Form(
        key: context.read<SingInPrv>().formKey,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            vpad(24 + topSafePad(context) + appbarHeight(context)),
            Center(
              child: Text(
                S.of(context).wellcome_back,
                style: txtDisplayMedium(),
              ),
            ),
            vpad(15),
            SelectableText(context.watch<LangPrv>().fcmToken ?? "sss"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).no_acc,
                  style: txtMedium(14, grayScaleColor2),
                ),
                hpad(14),
                InkWell(
                  onTap: () {
                    if (widget.isFromSignUp) {
                      Utils.pop(context);
                    } else {
                      Utils.pushScreen(
                        context,
                        const SignUpScreen(isFromSignIn: true),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(5),
                  child: Text(
                    S.of(context).sign_up,
                    style: txtLinkSmall(color: primaryColorBase),
                  ),
                )
              ],
            ),
            vpad(34),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  PrimaryTextField(
                    blockSpace: true,
                    controller: context.read<SingInPrv>().accountController,
                    label: S.of(context).account_name,
                    hint: S.of(context).enter_email_phone,
                    isRequired: true,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    validateString: context.watch<SingInPrv>().accountValidate,
                  ),
                  vpad(16),
                  PrimaryTextField(
                    blockSpace: true,
                    controller: context.read<SingInPrv>().passController,
                    obscureText: true,
                    isRequired: true,
                    label: S.of(context).password,
                    hint: S.of(context).enter_pas,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    validateString: context.watch<SingInPrv>().passValidate,
                  ),
                  vpad(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 22.0,
                              height: 22.0,
                              child: Checkbox(
                                fillColor:
                                    MaterialStateProperty.all(primaryColorBase),
                                value: context.read<AuthPrv>().remember,
                                onChanged: (_) {
                                  setState(() {
                                    context.read<AuthPrv>().remember =
                                        !context.read<AuthPrv>().remember;
                                  });
                                },
                              ),
                            ),
                            hpad(10),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  context.read<AuthPrv>().remember =
                                      !context.read<AuthPrv>().remember;
                                });
                              },
                              child: Text(
                                S.of(context).remember_acc,
                                style: txtLinkSmall(color: primaryColorBase),
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(PhoneNumForgotPassScreen.routeName);
                        },
                        child: Text(
                          S.of(context).forgot_pass,
                          style: txtLinkSmall(color: primaryColorBase),
                        ),
                      ),
                    ],
                  ),
                  vpad(32),
                  PrimaryButton(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      // return await context.read<HOAccountServicePrv>().loginHO(
                      //       context
                      //           .read<SingInPrv>()
                      //           .accountController
                      //           .text
                      //           .trim(),
                      //       context
                      //           .read<SingInPrv>()
                      //           .passController
                      //           .text
                      //           .trim(),
                      //       context,
                      //       context.read<AuthPrv>().remember,
                      //     );
                      // return await context
                      //     .read<SingInPrv>()
                      //     .signInHO(context, context.read<AuthPrv>().remember);
                      return await context
                          .read<SingInPrv>()
                          .signIn(context, context.read<AuthPrv>().remember);
                    },
                    text: S.of(context).sign_in,
                    isLoading: context.watch<SingInPrv>().isLoading,
                    // context.watch<HOAccountServicePrv>().isLoginLoading,
                    width: double.infinity,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    //   },
    // );
  }
}
