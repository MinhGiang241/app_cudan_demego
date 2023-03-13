import 'dart:async';

import 'package:app_cudan/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/account.dart';
import '../../../services/api_auth.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_screen.dart';
import 'provider/otp_add_email_prv.dart';

class OtpAddEmailScreen extends StatefulWidget {
  OtpAddEmailScreen({super.key, required this.acc, required this.email});
  final Account acc;
  final String email;

  @override
  State<OtpAddEmailScreen> createState() => _OtpAddEmailScreenState();
}

class _OtpAddEmailScreenState extends State<OtpAddEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OtpAddEmailPrv(email: widget.email),
      builder: (context, snapshot) => PrimaryScreen(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: SafeArea(
            child: ListView(
          children: [
            vpad(24),
            Center(
                child:
                    Text(S.of(context).code_verify, style: txtDisplayMedium())),
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
                    S.of(context).we_send_to(widget.email),
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
                controller: context.read<OtpAddEmailPrv>().otpController,
                appContext: context,
                length: 6,
                onTap: () {},
                onChanged: (v) {
                  context.read<OtpAddEmailPrv>().offTextError();
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
                    context.read<OtpAddEmailPrv>().errorAnimationController,
                enableActiveFill: true,
                animationDuration: const Duration(milliseconds: 300),
              ),
            ),
            vpad(14),
            if (context.watch<OtpAddEmailPrv>().otpValidate != null)
              Center(
                child: Text(S.of(context).otp_invalid,
                    style: txtMedium(14, redColorBase)),
              ),
            vpad(14),
            StreamBuilder<int>(
                initialData: 30,
                stream:
                    context.read<OtpAddEmailPrv>().timeResendController.stream,
                builder: (context, snapshot) {
                  final second = snapshot.data ?? 30;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).not_get_otp,
                          style: txtMedium(14, grayScaleColor2)),
                      hpad(12),
                      context.watch<OtpAddEmailPrv>().isResending
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 3))
                          : GestureDetector(
                              onTap: () async {
                                if (second <= 0) {
                                  await context
                                      .read<OtpAddEmailPrv>()
                                      .resend(context);
                                }
                              },
                              child: Text(S.of(context).resend,
                                  style: txtLinkSmall(
                                      color: (second <= 0 ||
                                              context
                                                  .watch<OtpAddEmailPrv>()
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
          ],
        )),
      ),
    );
  }
}
