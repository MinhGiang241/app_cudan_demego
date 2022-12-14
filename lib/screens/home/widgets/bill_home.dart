import 'package:app_cudan/screens/payment/payment_list_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_icon.dart';
import '../../bills/bills_screen.dart';
import 'home_title_widget.dart';

class BillsHome extends StatelessWidget {
  const BillsHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTitleWidget(
      title: S.of(context).bills,
      onTapShowAll: () {
        Navigator.of(context).pushNamed(PaymentListScreen.routeName);
        // Utils.pushScreen(context, const BillsScreen());
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 85,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 1,
                          blurRadius: 24,
                          color: greenColor.withOpacity(0.25),
                          offset: const Offset(0, 16))
                    ],
                  ),
                  child: PrimaryIcon(
                    icons: PrimaryIcons.dollar,
                    style: PrimaryIconStyle.gradient,
                    gradients: PrimaryIconGradient.green,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    size: 32,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(PaymentListScreen.routeName);
                    },
                  ),
                ),
                vpad(12),
                Text(S.of(context).pay,
                    textAlign: TextAlign.center,
                    style: txtBodySmallBold(color: grayScaleColorBase))
              ],
            ),
          ),
          SizedBox(
            width: 85,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 1,
                          blurRadius: 24,
                          color: yellowColor.withOpacity(0.25),
                          offset: const Offset(0, 16))
                    ],
                  ),
                  child: PrimaryIcon(
                    icons: PrimaryIcons.electricity,
                    style: PrimaryIconStyle.gradient,
                    gradients: PrimaryIconGradient.yellow,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    size: 32,
                    onTap: () {
                      // Utils.pushScreen(context, const BillsScreen());
                    },
                  ),
                ),
                vpad(12),
                Text(S.of(context).water,
                    textAlign: TextAlign.center,
                    style: txtBodySmallBold(color: grayScaleColorBase))
              ],
            ),
          ),
          SizedBox(
            width: 85,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 1,
                          blurRadius: 24,
                          color: greenColor.withOpacity(0.25),
                          offset: const Offset(0, 16))
                    ],
                  ),
                  child: PrimaryIcon(
                    icons: PrimaryIcons.internet,
                    style: PrimaryIconStyle.gradient,
                    gradients: PrimaryIconGradient.green,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    size: 32,
                    onTap: () {
                      // Utils.pushScreen(context, const BillsScreen());
                    },
                  ),
                ),
                vpad(12),
                Text(S.of(context).internet,
                    textAlign: TextAlign.center,
                    style: txtBodySmallBold(color: grayScaleColorBase))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
