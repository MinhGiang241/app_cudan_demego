// ignore_for_file: use_build_context_synchronously

import 'package:app_cudan/constants/regex_text.dart';
import 'package:app_cudan/screens/auth/prv/auth_prv.dart';
import 'package:app_cudan/screens/auth/prv/sign_in_prv.dart';
import 'package:app_cudan/screens/auth/sign_up_screen.dart';
import 'package:app_cudan/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../services/prf_data.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_screen.dart';
import '../../widgets/primary_text_field.dart';
import 'apartment_selection_screen.dart';
import 'fogot_pass/phone_num_forgot_pass.dart';

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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<SingInPrv>(
    //   create: (context) => SingInPrv(context.read<AuthPrv>()),
    //   builder: (context, state) {
    Provider.of<SingInPrv>(context).initAccountSave();
    final arg = ModalRoute.of(context)!.settings.arguments as bool?;
    if (arg != null) {
      widget.isFromSignUp = arg;
    }
    return PrimaryScreen(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
            onPressed: () => Navigator.pushReplacementNamed(
                context, SplashScreen.routeName)),
      ),
      body: Form(
        key: context.read<SingInPrv>().formKey,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            vpad(24 + topSafePad(context) + appbarHeight(context)),
            Center(
                child: Text(S.of(context).wellcome_back,
                    style: txtDisplayMedium())),
            vpad(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).no_acc,
                    style: txtMedium(14, grayScaleColor2)),
                hpad(14),
                InkWell(
                    onTap: () {
                      if (widget.isFromSignUp) {
                        Utils.pop(context);
                      } else {
                        Utils.pushScreen(
                            context, const SignUpScreen(isFromSignIn: true));
                      }
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Text(S.of(context).sign_up,
                        style: txtLinkSmall(color: primaryColorBase)))
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
                      onTap: context.watch<SingInPrv>().isLoading
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              await context.read<SingInPrv>().signIn(context);

                              // Navigator.pushNamed(
                              //     context, ApartmentSeletionScreen.routeName);
                            },
                      text: S.of(context).sign_in,
                      isLoading: context.watch<SingInPrv>().isLoading,
                      width: double.infinity)
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
