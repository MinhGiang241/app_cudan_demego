import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_icon.dart';
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
        // Utils.pushScreen(context, const BillsScreen());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 85,
            child: Column(
              children: [
                PrimaryIcon(
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
                vpad(12),
                Text(S.of(context).electricity,
                    textAlign: TextAlign.center,
                    style: txtBodySmallBold(color: grayScaleColorBase))
              ],
            ),
          ),
          SizedBox(
            width: 85,
            child: Column(
              children: [
                PrimaryIcon(
                  icons: PrimaryIcons.water,
                  style: PrimaryIconStyle.gradient,
                  gradients: PrimaryIconGradient.turquoise,
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  size: 32,
                  onTap: () {
                    // Utils.pushScreen(context, const BillsScreen());
                  },
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
                PrimaryIcon(
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
