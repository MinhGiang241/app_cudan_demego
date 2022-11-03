import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_icon.dart';
import '../../services/gym_card/gym_card_list_screen.dart';
import '../../services/parking_card/parking_card_list_screen.dart';
import '../../services/service_screen.dart';
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
        Navigator.pushNamed(context, ServiceScreen.routeName);
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
                          color: primaryColorBase.withOpacity(0.25),
                          offset: const Offset(0, 16))
                    ],
                  ),
                  child: PrimaryIcon(
                    icons: PrimaryIcons.car,
                    style: PrimaryIconStyle.gradient,
                    gradients: PrimaryIconGradient.blue,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    size: 32,
                    onTap: () {
                      Navigator.pushNamed(
                          context, ParkingCardListScreen.routeName);
                      // Utils.pushScreen(context, const ParkingCardListScreen());
                    },
                  ),
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
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 1,
                          blurRadius: 24,
                          color: pinkColor.withOpacity(0.25),
                          offset: const Offset(0, 16))
                    ],
                  ),
                  child: PrimaryIcon(
                    icons: PrimaryIcons.elevator,
                    style: PrimaryIconStyle.gradient,
                    gradients: PrimaryIconGradient.pink,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    size: 32,
                    onTap: () {
                      // Utils.pushScreen(context, const ResidentCardListScreen());
                    },
                  ),
                ),
                vpad(12),
                Text(S.of(context).elevator_card,
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
                          color: purpleColor.withOpacity(0.25),
                          offset: const Offset(0, 16))
                    ],
                  ),
                  child: PrimaryIcon(
                    icons: PrimaryIcons.gym,
                    style: PrimaryIconStyle.gradient,
                    gradients: PrimaryIconGradient.purple,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    size: 32,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(GymCardListScreen.routeName);
                      // Utils.pushScreen(context, const ServicesTrackingScreen());
                    },
                  ),
                ),
                vpad(12),
                Text(S.of(context).gym_card,
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
