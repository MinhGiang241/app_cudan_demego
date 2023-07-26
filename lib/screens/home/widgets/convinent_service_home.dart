import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_icon.dart';
import 'home_title_widget.dart';

class ConvinientServiceHome extends StatelessWidget {
  const ConvinientServiceHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTitleWidget(
      title: S.of(context).covenient_service,
      onTapShowAll: () {
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
                        color: yellowColor.withOpacity(0.25),
                        offset: const Offset(0, 16),
                      )
                    ],
                  ),
                  child: PrimaryIcon(
                    icons: PrimaryIcons.shopping_cart,
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
                Text(
                  S.of(context).shopping_represent,
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
                        color: turquoiseColor.withOpacity(0.25),
                        offset: const Offset(0, 16),
                      )
                    ],
                  ),
                  child: PrimaryIcon(
                    icons: PrimaryIcons.store_front,
                    style: PrimaryIconStyle.gradient,
                    gradients: PrimaryIconGradient.turquoise,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    size: 32,
                    onTap: () {
                      // Utils.pushScreen(context, const BillsScreen());
                    },
                  ),
                ),
                vpad(12),
                Text(
                  S.of(context).shopping_online,
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
                        color: greenColor.withOpacity(0.25),
                        offset: const Offset(0, 16),
                      )
                    ],
                  ),
                  child: PrimaryIcon(
                    icons: PrimaryIcons.housework,
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
                Text(
                  S.of(context).housework,
                  textAlign: TextAlign.center,
                  style: txtBodySmallBold(color: grayScaleColorBase),
                )
              ],
            ),
          ),
        ],
      ),
      //  Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [

      //   ],
      // ),
    );
  }
}
