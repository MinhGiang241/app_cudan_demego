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

class VerifyOTPScreen extends StatefulWidget {
  VerifyOTPScreen(
      {Key? key,
      required this.phone,
      required this.name,
      required this.pass,
      required this.email,
      this.isForgotPass = false})
      : super(key: key);
  final String phone;
  final String name;
  final String pass;
  final String email;
  final bool isForgotPass;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VerifyOTPPrv>(
        create: (context) => VerifyOTPPrv(context.read<AuthPrv>(), widget.phone,
            widget.name, widget.pass, widget.email),
        builder: (context, snapshot) {
          return PrimaryScreen(
            appBar: AppBar(backgroundColor: Colors.transparent),
            body: ListView(
              children: [
                vpad(24),
                Center(
                    child: Text(S.of(context).otp_verify,
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
                        "Chúng tôi đã gửi cho bạn mã đến:+84383873719",
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
                    // controller: context.read<VerifyOTPPrv>().otpController,
                    appContext: context,
                    length: 6,
                    onChanged: (v) {},
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
                    // errorAnimationController:
                    //     context.read<VerifyOTPPrv>().errorAnimationController,
                    enableActiveFill: true,
                    animationDuration: const Duration(milliseconds: 300),
                  ),
                ),
                vpad(28),
                StreamBuilder<int>(
                    initialData: 60,
                    // stream: context.read<VerifyOTPPrv>().timeResendController.stream,
                    builder: (context, snapshot) {
                      final second = snapshot.data ?? 60;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(S.of(context).not_get_otp,
                              style: txtMedium(14, grayScaleColor2)),
                          hpad(12),
                          // context.watch<VerifyOTPPrv>().isResending
                          false
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 3))
                              : GestureDetector(
                                  onTap: second == 0
                                      ? () async {
                                          // await context
                                          //     .read<VerifyOTPPrv>()
                                          //     .resend(context);
                                        }
                                      : null,
                                  child: Text(S.of(context).resend,
                                      style: txtLinkSmall(
                                          color: second == 0
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
                    text: S.of(context).verify,
                    onTap: () {
                      // context
                      //     .read<VerifyOTPPrv>()
                      //     .verify(context, widget.isForgotPass);
                      Utils.pushScreen(
                          context, ResetPassScreen(phone: '', token: ''));
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
