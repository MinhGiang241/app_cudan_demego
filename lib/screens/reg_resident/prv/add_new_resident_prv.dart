import 'package:flutter/material.dart';

class AddNewResidentPrv extends ChangeNotifier {
  int activeStep = 0;
  bool isDisableRightCroll = true;
  bool autoValidStep1 = false;
  bool autoValidStep2 = false;
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final PageController controller = PageController();
  validate1(BuildContext context) {}
  validate2(BuildContext context) {}
  onPageChanged(v) {
    activeStep = v;
    notifyListeners();
  }

  onStep1Next(BuildContext context) {
    FocusScope.of(context).unfocus();
    autoValidStep1 = true;
    if (formKey1.currentState!.validate()) {
      isDisableRightCroll = false;
      notifyListeners();
      controller
          .animateToPage(++activeStep,
              duration: const Duration(milliseconds: 250),
              curve: Curves.bounceInOut)
          .then((_) {
        isDisableRightCroll = true;
        notifyListeners();
      });
    }
  }
}
