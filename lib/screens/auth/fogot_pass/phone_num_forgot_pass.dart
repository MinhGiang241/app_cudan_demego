import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../prv/forgot_pass_prv.dart';

class PhoneNumForgotPassScreen extends StatefulWidget {
  const PhoneNumForgotPassScreen({Key? key}) : super(key: key);
  static const routeName = '/forgot';

  @override
  State<PhoneNumForgotPassScreen> createState() =>
      _PhoneNumForgotPassScreenState();
}

class _PhoneNumForgotPassScreenState extends State<PhoneNumForgotPassScreen> {
  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  next() {
    if (pageIndex <= 4) {
      pageController.animateToPage(
        pageIndex++,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPassPrv>(
      create: (context) => ForgotPassPrv(
        isForgotPass: true,
      ),
      builder: (context, snapshot) {
        return PrimaryScreen(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Form(
            key: context.read<ForgotPassPrv>().formKey,
            child: SafeArea(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                children: [
                  // vpad(24 + topSafePad(context) + appbarHeight(context)),
                  Center(
                    child: Text(
                      S.of(context).forgot_pass,
                      style: txtDisplayMedium(),
                    ),
                  ),
                  vpad(45),
                  PrimaryTextField(
                    controller: context.read<ForgotPassPrv>().phoneController,
                    label: S.of(context).username,
                    hint: S.of(context).username,
                    // keyboardType: TextInputType.phone,
                    isRequired: true,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    validateString:
                        context.watch<ForgotPassPrv>().phoneValidate,
                  ),

                  vpad(30),
                  PrimaryButton(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await context
                          .read<ForgotPassPrv>()
                          .getEmailAndPhone(context)
                          .then((value) {})
                          .catchError((e) {});
                    },
                    text: S.of(context).next,
                    isLoading: context.watch<ForgotPassPrv>().isLoading,
                    width: double.infinity,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
