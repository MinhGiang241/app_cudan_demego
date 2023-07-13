import 'package:app_cudan/screens/auth/prv/auth_prv.dart';
import 'package:app_cudan/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../services/prf_data.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_loading.dart';
import '../auth/sign_in_screen.dart';
import '../auth/sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.isUnathen}) : super(key: key);
  static const routeName = '/';
  final bool isUnathen;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Provider.of<SingInPrv>(context).initAccountSave();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   var acc = await PrfData.shared.getSignInStore();
    //   var isBack = false;
    //   var arg = ModalRoute.of(context)!.settings.arguments as bool?;
    //   if (arg != null) {
    //     isBack = arg;
    //   }

    //   if (acc['acc'] != null && acc['pass'] != null && !isBack) {
    //     Provider.of<AuthPrv>(context, listen: false)
    //         .onSignIn(context, acc['acc'], acc['pass']);
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var status = context.watch<AuthPrv>().authStatus;
    // print(status);
    // if (status == AuthStatus.auth) {
    //   return const HomeScreen();
    // }
    return Material(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: gradientBackground),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Center(
                  child: SizedBox(
                    height: dvHeight(context) * 1.2,
                    width: dvWidth(context) * 1.2,
                    child: Image.asset(AppImage.splashBackground,
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).padding.top + 60,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Image.asset(AppImage.demeproLogo,
                          width: dvWidth(context) / 4),
                      vpad(16),
                      Text.rich(TextSpan(children: [
                        TextSpan(text: "DEME", style: txtBold(24)),
                        TextSpan(text: "PRO", style: txtBold(24, yellowColor1)),
                      ])),
                      vpad(8),
                      Text(
                        S.of(context).w,
                        style: txtBold(14, grayScaleColor2),
                      ),
                      vpad(8),
                      Image.asset(AppImage.illustration,
                          width: dvWidth(context) * 0.8),
                      vpad(24),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: dvWidth(context) * 0.1,
                bottom: dvHeight(context) * .03,
                child: SizedBox(
                  height: 150,
                  child: AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    switchInCurve: Curves.easeOutBack,
                    switchOutCurve: Curves.elasticIn,
                    transitionBuilder: (child, animate) {
                      return Center(
                          child: SlideTransition(
                        position: animate.drive(Tween<Offset>(
                            begin: const Offset(0, 1), end: Offset.zero)),
                        child: FadeTransition(opacity: animate, child: child),
                      ));
                    },
                    child: widget.isUnathen
                        ? Column(
                            children: [
                              PrimaryButton(
                                text: S.of(context).sign_in,
                                width: dvWidth(context) * 0.8,
                                buttonType: ButtonType.white,
                                textColor: primaryColor1,
                                onTap: () {
                                  // var auth =
                                  //     context.read<AuthPrv>().authStatus;
                                  Navigator.of(context)
                                      .pushNamed(SignInScreen.routeName);

                                  // if (auth == AuthStatus.auth) {
                                  //   Navigator.of(context)
                                  //       .pushNamed(HomeScreen.routeName);
                                  // } else {
                                  //   Navigator.of(context).pushNamed(
                                  //       SignInScreen.routeName);
                                  // }
                                },
                              ),
                              vpad(24),
                              PrimaryButton(
                                text: S.of(context).create_acc,
                                width: dvWidth(context) * 0.8,
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(SignUpScreen.routeName);
                                },
                              )
                            ],
                          )
                        : const PrimaryLoading(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
