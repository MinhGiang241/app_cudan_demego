import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../electricity/electricity_screen.dart';
import '../event/event_list_screen.dart';
import '../payment/payment_list_screen.dart';
import '../reg_resident/register_resident_screen.dart';
import '../services/reflection/reflection_screen.dart';
import '../services/service_screen.dart';
import '../services/ultilty/utility_service_list_screen.dart';
import '../water/water_screen.dart';

class HomeServices extends StatelessWidget {
  const HomeServices({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {
        "icon": PrimaryIcons.dollar,
        "text": S.of(context).pay,
        "tap": () {
          Navigator.of(context).pushNamed(
            PaymentListScreen.routeName,
            arguments: {'year': null, 'month': null, 'index': null},
          );
        }
      },
      {
        "icon": PrimaryIcons.water,
        "text": S.of(context).water,
        'tap': () {
          Navigator.of(context).pushNamed(
            WaterScreen.routeName,
            arguments: {'year': null, 'month': null, 'index': null},
          );
        }
      },
      {
        "icon": PrimaryIcons.electricity,
        "text": S.of(context).electricity,
        "tap": () {
          Navigator.of(context).pushNamed(
            ElectricityScreen.routeName,
          );
        }
      },
      {
        "icon": PrimaryIcons.car,
        "text": S.of(context).services,
        'tap': () {
          Navigator.pushNamed(context, ServiceScreen.routeName);
        }
      },
      {
        "icon": PrimaryIcons.gym,
        "text": "Tiện ích",
        "tap": () {
          Navigator.of(context).pushNamed(
            UtilityServiceListScreen.routeName,
            arguments: {'year': null, 'month': null, 'index': null},
          );
        }
      },
      {
        "icon": PrimaryIcons.mail,
        "text": S.of(context).reflex,
        "tap": () {
          Navigator.pushNamed(context, ReflectionScreen.routeName);
        }
      },
      {
        "icon": PrimaryIcons.avatar,
        "text": S.of(context).resident_reg,
        "tap": () {
          Navigator.pushNamed(
            context,
            RegisterResidentScreen.routeName,
          );
        }
      },
      {
        "icon": PrimaryIcons.news,
        "text": S.of(context).event,
        "tap": () {
          Navigator.pushNamed(context, EventListScreen.routeName);
        }
      },
    ];

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Danh mục",
            style: txtLinkSmall(color: grayScaleColor2)
                .copyWith(decoration: TextDecoration.underline),
          ),
        ),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.6,
          children: [
            ...data.map(
              (e) => PrimaryCard(
                // decoration: BoxDecoration(

                // boxShadow: [
                //   BoxShadow(
                //     blurStyle: BlurStyle.normal,
                //     spreadRadius: 1,
                //     blurRadius: 24,
                //     color: demepro2.withOpacity(0.25),
                //     offset: const Offset(0, 16),
                //   )
                // ],
                // ),
                onTap: () {
                  (e['tap'] as Function)();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: PrimaryIcon(
                        icons: e['icon'] as PrimaryIcons,
                        // style: PrimaryIconStyle.gradient,
                        // gradients: PrimaryIconGradient.primary,
                        color: primaryColorBase,
                        padding: const EdgeInsets.all(8),
                        size: 32,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            PaymentListScreen.routeName,
                            arguments: {
                              'year': null,
                              'month': null,
                              'index': null
                            },
                          );
                        },
                      ),
                    ),
                    Flexible(
                      child: Text(
                        e['text'] as String,
                        textAlign: TextAlign.center,
                        style: txtBodySmallBold(color: grayScaleColorBase),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
