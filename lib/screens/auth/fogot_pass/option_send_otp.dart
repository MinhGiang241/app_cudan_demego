import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_screen.dart';
import '../prv/forgot_pass_prv.dart';
import '../verify_otp_screen.dart';

class OptionSendOtp extends StatefulWidget {
  const OptionSendOtp({super.key});

  @override
  State<OptionSendOtp> createState() => _OptionSendOtpState();
}

class _OptionSendOtpState extends State<OptionSendOtp> {
  var _selectedOption = 1;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPassPrv>(
      create: (context) => ForgotPassPrv(),
      builder: (context, snapshot) => PrimaryScreen(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  vpad(24 + topSafePad(context) + appbarHeight(context)),
                  Center(
                    child: Text(
                      "Đặt lại mật khẩu",
                      style: txtDisplayMedium(),
                    ),
                  ),
                  vpad(20),
                  Text(
                    'Bạn muốn nhận mã để đặt lại mật khẩu bằng cách nào?',
                    style: txtBodySmallRegular(color: grayScaleColorBase),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  vpad(42),
                  RadioListTile<int>(
                    title: Text(
                      'Gửi mã về SDT +840123456789',
                      style: txtBodySmallRegular(color: grayScaleColorBase),
                    ),
                    value: 1,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: Text(
                      'Gửi mã về Email dung****23@gmail.com',
                      style: txtBodySmallRegular(color: grayScaleColorBase),
                    ),
                    value: 2,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                ],
              ),
              Positioned(
                bottom: 240,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: PrimaryButton(
                    width: dvWidth(context) - 48,
                    text: S.of(context).next,
                    onTap: () {
                      Utils.pushScreen(
                          context, ConfirmChoice(choice: _selectedOption));
                      // await context
                      //     .read<ForgotPassPrv>()
                      //     .sendVerify(context);
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class ConfirmChoice extends StatelessWidget {
  const ConfirmChoice({super.key, this.choice});
  final int? choice;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPassPrv>(
      create: (context) => ForgotPassPrv(),
      builder: (context, snapshot) => PrimaryScreen(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(0),
              children: [
                vpad(24 + topSafePad(context) + appbarHeight(context)),
                Center(
                  child: Text(
                    "Đặt lại mật khẩu",
                    style: txtDisplayMedium(),
                  ),
                ),
                vpad(50),
                Text(
                  "Gửi mã để đặt lại mật khẩu về",
                  style: txtBodySmallRegular(color: grayScaleColorBase),
                  textAlign: TextAlign.center,
                ),
                vpad(45),
                Text(
                  choice == 1
                      ? 'SDT +840123456789'
                      : 'Email dung****23@gmail.com',
                  style: txtBodySmallRegular(color: grayScaleColorBase),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ],
            ),
            Positioned(
              bottom: 240,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PrimaryButton(
                  width: dvWidth(context) - 48,
                  text: S.of(context).next,
                  onTap: () {
                    Utils.pushScreen(
                        context,
                        VerifyOTPScreen(
                            phone: '',
                            name: "",
                            pass: "",
                            email: '',
                            isForgotPass: true));
                    // await context
                    //     .read<ForgotPassPrv>()
                    //     .sendVerify(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
