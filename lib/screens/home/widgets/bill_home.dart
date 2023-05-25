import 'package:app_cudan/screens/payment/payment_list_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_icon.dart';
import '../../electricity/electricity_screen.dart';
import '../../water/water_screen.dart';
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
        Navigator.of(context).pushNamed(
          PaymentListScreen.routeName,
          arguments: {'year': null, 'month': null, 'index': null},
        );
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
                        offset: const Offset(0, 16),
                      )
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
                      Navigator.of(context).pushNamed(
                        PaymentListScreen.routeName,
                        arguments: {'year': null, 'month': null, 'index': null},
                      );
                    },
                  ),
                ),
                vpad(12),
                Text(
                  S.of(context).pay,
                  textAlign: TextAlign.center,
                  style: txtBodySmallBold(color: grayScaleColorBase),
                )
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
                        color: purpleColorBase.withOpacity(0.25),
                        offset: const Offset(0, 16),
                      )
                    ],
                  ),
                  child: PrimaryIcon(
                    icons: PrimaryIcons.water,
                    style: PrimaryIconStyle.gradient,
                    gradients: PrimaryIconGradient.purple,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    size: 32,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        WaterScreen.routeName,
                        arguments: {'year': null, 'month': null, 'index': null},
                      );
                    },
                  ),
                ),
                vpad(12),
                Text(
                  S.of(context).water,
                  textAlign: TextAlign.center,
                  style: txtBodySmallBold(color: grayScaleColorBase),
                )
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
                        offset: const Offset(0, 16),
                      )
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
                      Navigator.of(context).pushNamed(
                        ElectricityScreen.routeName,
                      );
                    },
                  ),
                ),
                vpad(12),
                Text(
                  S.of(context).electricity,
                  textAlign: TextAlign.center,
                  style: txtBodySmallBold(color: grayScaleColorBase),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
