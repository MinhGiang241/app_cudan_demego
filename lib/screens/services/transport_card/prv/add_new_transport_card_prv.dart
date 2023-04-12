import 'package:flutter/material.dart';

class AddNewTransportCardPrv extends ChangeNotifier {
  int activeStep = 0;
  final PageController pageController = PageController();
  bool isDisableRightCroll = true;
  onPageChanged(v) {
    activeStep = v;
    notifyListeners();
  }

  addTransport() {
    isDisableRightCroll = false;
    notifyListeners();
    pageController
        .animateToPage(
      ++activeStep,
      duration: const Duration(milliseconds: 250),
      curve: Curves.bounceInOut,
    )
        .then((v) {
      isDisableRightCroll = true;
      notifyListeners();
    });
  }
}
