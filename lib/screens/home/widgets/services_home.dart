import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_icon.dart';
import 'home_title_widget.dart';

class ServicesHome extends StatelessWidget {
  const ServicesHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTitleWidget(
      title: S.of(context).services,
      onTapShowAll: () {
        // Utils.pushScreen(context, const ListServicesScreen());
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 85,
            child: Column(
              children: [
                PrimaryIcon(
                  icons: PrimaryIcons.car,
                  style: PrimaryIconStyle.gradient,
                  gradients: PrimaryIconGradient.blue,
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  size: 32,
                  onTap: () {
                    // Utils.pushScreen(context, const ParkingCardListScreen());
                  },
                ),
                vpad(12),
                Text(S.of(context).parking_card,
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
                  icons: PrimaryIcons.inbox,
                  style: PrimaryIconStyle.gradient,
                  gradients: PrimaryIconGradient.pink,
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  size: 32,
                  onTap: () {
                    // Utils.pushScreen(context, const ResidentCardListScreen());
                  },
                ),
                vpad(12),
                Text('S.of(context).resident_card',
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
                  icons: PrimaryIcons.extension,
                  style: PrimaryIconStyle.gradient,
                  gradients: PrimaryIconGradient.purple,
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  size: 32,
                  onTap: () {
                    // Utils.pushScreen(context, const ServicesTrackingScreen());
                  },
                ),
                vpad(12),
                Text('S.of(context).covenient_service',
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
