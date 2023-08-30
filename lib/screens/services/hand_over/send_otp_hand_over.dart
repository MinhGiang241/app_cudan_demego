// ignore_for_file: prefer_single_quotes

import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/hand_over.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_screen.dart';
import 'prv/otp_booking_prv.dart';

class OtpBookingScreen extends StatefulWidget {
  static const routeName = '/handover-otp';
  const OtpBookingScreen({
    super.key,
  });

  @override
  State<OtpBookingScreen> createState() => _OtpBookingScreenState();
}

class _OtpBookingScreenState extends State<OtpBookingScreen> {
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var schedule = arg['data'] as AppointmentSchedule;
    var name = arg['apart'] as String;

    var phone = context.read<ResidentInfoPrv>().userInfo?.account?.phone;
    return ChangeNotifierProvider(
      create: (context) => OtpBookingPrv(
        schedule: schedule,
        apartmentName: name,
      ),
      builder: (context, snapshot) => PrimaryScreen(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: SafeArea(
          child: ListView(
            children: [
              vpad(24),
              Center(
                child: Text(
                  S.of(context).code_verify,
                  style: txtDisplayMedium(),
                ),
              ),
              vpad(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Text(
                      S.of(context).otp_msg_phone,
                      style: txtMedium(14, grayScaleColor2),
                      textAlign: TextAlign.center,
                    ),
                    vpad(24),
                    Text(
                      S.of(context).we_send_to(phone ?? ""),
                      style: txtMedium(14, grayScaleColor2),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              vpad(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: PinCodeTextField(
                  controller: context.read<OtpBookingPrv>().otpController,
                  appContext: context,
                  length: 6,
                  onTap: () {},
                  onChanged: (v) {
                    context.read<OtpBookingPrv>().offTextError();
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
                    inactiveFillColor: Colors.white,
                  ),
                  errorAnimationController:
                      context.read<OtpBookingPrv>().errorAnimationController,
                  enableActiveFill: true,
                  animationDuration: const Duration(milliseconds: 300),
                ),
              ),
              vpad(14),
              if (context.watch<OtpBookingPrv>().otpValidate != null)
                Center(
                  child: Text(
                    S.of(context).otp_invalid,
                    style: txtMedium(14, redColorBase),
                  ),
                ),
              vpad(14),
              StreamBuilder<int>(
                initialData: 30,
                stream:
                    context.read<OtpBookingPrv>().timeResendController.stream,
                builder: (context, snapshot) {
                  final second = snapshot.data ?? 30;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).not_get_otp,
                        style: txtMedium(14, grayScaleColor2),
                      ),
                      hpad(12),
                      context.watch<OtpBookingPrv>().isSendLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 3),
                            )
                          : GestureDetector(
                              onTap: () async {
                                if (second <= 0) {
                                  await context
                                      .read<OtpBookingPrv>()
                                      .resend(context);
                                }
                              },
                              child: Text(
                                S.of(context).resend,
                                style: txtLinkSmall(
                                  color: (second <= 0 ||
                                          context
                                              .watch<OtpBookingPrv>()
                                              .isSendLoading)
                                      ? primaryColorBase
                                      : primaryColor4,
                                ),
                              ),
                            ),
                      hpad(8),
                      if (second > 0)
                        Text(
                          "(${second}s)",
                          style: txtMedium(14, grayScaleColor2),
                        ),
                    ],
                  );
                },
              ),
              vpad(32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PrimaryButton(
                  isLoading: context.watch<OtpBookingPrv>().isLoading,
                  text: S.of(context).confirm,
                  onTap: () {
                    context
                        .read<OtpBookingPrv>()
                        .verify(
                          context,
                        )
                        .then((v) {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
