import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/payment/payment_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var isResident =
        //context.read<ResidentInfoPrv>().residentId != null &&
        context.read<ResidentInfoPrv>().selectedApartment != null;
    return HomeTitleWidget(
      title: S.of(context).bills,
      onTapShowAll: () {
        Navigator.of(context).pushNamed(
          PaymentListScreen.routeName,
          arguments: {'year': null, 'month': null, 'index': null},
        );
        // Utils.pushScreen(context, const BillsScreen());
      },
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        shrinkWrap: true,
        childAspectRatio: 1,
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
                        color: demepro2.withOpacity(0.25),
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: PrimaryIcon(
                    icons: PrimaryIcons.dollar,
                    style: PrimaryIconStyle.gradient,
                    gradients: PrimaryIconGradient.primary,
                    color: demepro3,
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
                ),
              ],
            ),
          ),
          if (isResident)
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
                          color: demepro2.withOpacity(0.25),
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: PrimaryIcon(
                      icons: PrimaryIcons.water,
                      style: PrimaryIconStyle.gradient,
                      gradients: PrimaryIconGradient.primary,
                      color: demepro3,
                      padding: const EdgeInsets.all(12),
                      size: 32,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          WaterScreen.routeName,
                          arguments: {
                            'year': null,
                            'month': null,
                            'index': null,
                          },
                        );
                      },
                    ),
                  ),
                  vpad(12),
                  Text(
                    S.of(context).water,
                    textAlign: TextAlign.center,
                    style: txtBodySmallBold(color: grayScaleColorBase),
                  ),
                ],
              ),
            ),
          if (isResident)
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
                          color: demepro2.withOpacity(0.25),
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: PrimaryIcon(
                      icons: PrimaryIcons.electricity,
                      style: PrimaryIconStyle.gradient,
                      gradients: PrimaryIconGradient.primary,
                      color: demepro3,
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
                  ),
                ],
              ),
            ),
        ],
      ),

      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [

      //   ],
      // ),
    );
  }
}
