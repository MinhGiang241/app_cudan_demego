import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_screen.dart';
import 'fogot_pass/reset_pass_screen.dart';
import 'prv/auth_prv.dart';
import 'prv/verify_otp_prv.dart';
import 'sign_in_screen.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen(
      {Key? key,
      required this.phone,
      required this.name,
      required this.pass,
      required this.email,
      required this.isPhone,
      this.verify,
      this.isForgotPass = false})
      : super(key: key);
  final String phone;
  final String name;
  final String pass;
  final String email;
  final bool isPhone;
  final bool isForgotPass;
  final Function()? verify;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VerifyOTPPrv>(
        create: (context) => VerifyOTPPrv(
            context.read<AuthPrv>(),
            widget.phone,
            widget.name,
            widget.pass,
            widget.email,
            widget.phone,
            widget.isPhone),
        builder: (context, snapshot) {
          return PrimaryScreen(
            appBar: AppBar(backgroundColor: Colors.transparent),
            body: ListView(
              children: [
                vpad(24),
                Center(
                    child: Text(
                        widget.isForgotPass
                            ? S.of(context).code_verify
                            : S.of(context).otp_verify,
                        style: txtDisplayMedium())),
                vpad(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Text(
                        S.of(context).otp_msg,
                        style: txtMedium(14, grayScaleColor2),
                        textAlign: TextAlign.center,
                      ),
                      vpad(24),
                      Text(
                        S.of(context).we_send_to(
                            widget.isPhone ? widget.phone : widget.email),
                        style: txtMedium(14, grayScaleColor2),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                vpad(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: PinCodeTextField(
                    controller: context.read<VerifyOTPPrv>().otpController,
                    appContext: context,
                    length: 6,
                    onTap: () {},
                    onChanged: (v) {
                      context.read<VerifyOTPPrv>().offTextError();
                    },
                    autoFocus: true,
                    animationType: AnimationType.fade,
                    cursorColor: grayScaleColor1,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        selectedColor: primaryColorBase,
                        selectedFillColor: Colors.white,
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 48,
                        fieldWidth: 48,
                        inactiveColor: grayScaleColor5,
                        activeFillColor: Colors.white,
                        activeColor: Colors.white,
                        inactiveFillColor: Colors.white),
                    errorAnimationController:
                        context.read<VerifyOTPPrv>().errorAnimationController,
                    enableActiveFill: true,
                    animationDuration: const Duration(milliseconds: 300),
                  ),
                ),
                vpad(14),
                if (context.watch<VerifyOTPPrv>().otpValidate != null)
                  Center(
                    child: Text(S.of(context).otp_invalid,
                        style: txtMedium(14, redColorBase)),
                  ),
                vpad(14),
                StreamBuilder<int>(
                    initialData: 30,
                    stream: context
                        .read<VerifyOTPPrv>()
                        .timeResendController
                        .stream,
                    builder: (context, snapshot) {
                      final second = snapshot.data ?? 30;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(S.of(context).not_get_otp,
                              style: txtMedium(14, grayScaleColor2)),
                          hpad(12),
                          context.watch<VerifyOTPPrv>().isResending
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 3))
                              : GestureDetector(
                                  onTap: () async {
                                    if (second <= 0) {
                                      await context
                                          .read<VerifyOTPPrv>()
                                          .resend(context);
                                    }
                                  },
                                  child: Text(S.of(context).resend,
                                      style: txtLinkSmall(
                                          color: (second <= 0 ||
                                                  context
                                                      .watch<VerifyOTPPrv>()
                                                      .isResending)
                                              ? primaryColorBase
                                              : primaryColor4)),
                                ),
                          hpad(8),
                          if (second > 0)
                            Text("(${second}s)",
                                style: txtMedium(14, grayScaleColor2)),
                        ],
                      );
                    }),
                vpad(32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: PrimaryButton(
                    isLoading: context.watch<VerifyOTPPrv>().isLoading,
                    text: !widget.isForgotPass
                        ? S.of(context).verify
                        : S.of(context).next,
                    onTap: context.watch<VerifyOTPPrv>().isLoading
                        ? () {}
                        : () {
                            // context
                            //     .read<VerifyOTPPrv>()
                            //     .verify(context, widget.isForgotPass);
                            if (widget.isForgotPass) {
                              context
                                  .read<VerifyOTPPrv>()
                                  .verify(context, widget.isForgotPass, () {});
                              // Utils.pushScreen(
                              //     context, ResetPassScreen(phone: '', token: ''));

                            } else {
                              context.read<VerifyOTPPrv>().verify(
                                  context, widget.isForgotPass, widget.verify!);
                              // widget.verify!().then((v) {
                              // Utils.showSuccessMessage(
                              //     context: context,
                              //     e: '${S.of(context).success_sign_up}, ${S.of(context).re_sign_in.toLowerCase()}',
                              //     onClose: () {
                              //       Navigator.pushReplacementNamed(context, SignInScreen.routeName);
                              //     });
                              // }).catchError((e) {});
                            }
                          },
                  ),
                )
              ],
            ),
          );
        });
  }
}
