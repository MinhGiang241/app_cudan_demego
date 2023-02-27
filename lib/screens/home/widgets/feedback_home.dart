import 'package:app_cudan/screens/reg_resident/register_resident_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_icon.dart';
import '../../services/reflection/reflection_screen.dart';
import 'home_title_widget.dart';

class FeedbackHome extends StatelessWidget {
  const FeedbackHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTitleWidget(
      title: S.of(context).res_reaction,
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
                    icons: PrimaryIcons.mail,
                    style: PrimaryIconStyle.gradient,
                    gradients: PrimaryIconGradient.yellow,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    size: 32,
                    onTap: () {
                      // Utils.pushScreen(context, const ResidentCardListScreen());
                      Navigator.pushNamed(context, ReflectionScreen.routeName);
                    },
                  ),
                ),
                vpad(12),
                Text(S.of(context).reflex,
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
                          color: greenColorBase.withOpacity(0.25),
                          offset: const Offset(0, 16))
                    ],
                  ),
                  child: PrimaryIcon(
                    icons: PrimaryIcons.avatar,
                    style: PrimaryIconStyle.gradient,
                    gradients: PrimaryIconGradient.green,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    size: 32,
                    onTap: () {
                      // Utils.pushScreen(context, const ParkingCardListScreen());
                      Navigator.pushNamed(
                          context, RegisterResidentScreen.routeName);
                    },
                  ),
                ),
                vpad(12),
                Text(
                  S.of(context).resident_reg,
                  textAlign: TextAlign.center,
                  style: txtBodySmallBold(color: grayScaleColorBase),
                )
              ],
            ),
          ),
          hpad(85)
        ],
      ),
    );
  }
}
