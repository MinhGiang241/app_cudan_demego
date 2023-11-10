import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/booking_services/booking_services_screen.dart';
import 'package:app_cudan/screens/receipts/receipt_screen.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../electricity/electricity_screen.dart';
import '../event/event_list_screen.dart';
import '../reg_resident/register_resident_screen.dart';
import '../revenues/revenues_screen.dart';
import '../services/reflection/reflection_screen.dart';
import '../services/service_screen.dart';
import '../services/ultilty/utility_service_list_screen.dart';
import '../water/water_screen.dart';

class HomeServices extends StatelessWidget {
  const HomeServices({super.key});

  @override
  Widget build(BuildContext context) {
    var isResient = context.read<ResidentInfoPrv>().residentId != null &&
        context.read<ResidentInfoPrv>().selectedApartment != null;
    final data = [
      // {
      //   "icon": PrimaryIcons.dollar,
      //   "text": S.current.pay,
      //   "page": PaymentListScreen.routeName,
      //   "arg": {'year': null, 'month': null, 'index': null},
      //   "tap": () {
      //     Navigator.of(context).pushNamed(
      //       PaymentListScreen.routeName,
      //       arguments: {'year': null, 'month': null, 'index': null},
      //     );
      //   },
      // },
      if (isResient)
        {
          "icon": PrimaryIcons.dollar,
          "text": S.current.receipt,
          "page": ReceiptScreen.routeName,
          "arg": {'year': null, 'month': null, 'index': null},
          "tap": () {
            Navigator.of(context).pushNamed(
              ReceiptScreen.routeName,
              arguments: {'year': null, 'month': null, 'index': null},
            );
          },
        },
      if (isResient)
        {
          "icon": PrimaryIcons.credit_card_alt,
          "text": S.current.revenues,
          "page": RevenuesScreen.routeName,
          "arg": {'year': null, 'month': null, 'index': null},
          "tap": () {
            Navigator.of(context).pushNamed(
              RevenuesScreen.routeName,
              arguments: {'year': null, 'month': null, 'index': null},
            );
          },
        },
      if (isResient)
        {
          "icon": PrimaryIcons.water,
          "text": S.current.water,
          "page": WaterScreen.routeName,
          "arg": {'year': null, 'month': null, 'index': null},
          'tap': () {
            Navigator.of(context).pushNamed(
              WaterScreen.routeName,
              arguments: {'year': null, 'month': null, 'index': null},
            );
          },
        },
      if (isResient)
        {
          "icon": PrimaryIcons.electricity,
          "text": S.current.electricity,
          "page": ElectricityScreen.routeName,
          "arg": null,
          "tap": () {
            Navigator.of(context).pushNamed(
              ElectricityScreen.routeName,
            );
          },
        },
      {
        "icon": PrimaryIcons.service_feedback,
        "text": S.current.services,
        "page": ServiceScreen.routeName,
        "arg": null,
        'tap': () {
          Navigator.of(context).pushNamed(ServiceScreen.routeName);
        },
      },
      // {
      //   "icon": PrimaryIcons.gym,
      //   "text": S.current.covenient_service,
      //   "page": UtilityServiceListScreen.routeName,
      //   "arg": {'year': null, 'month': null, 'index': null},
      //   "tap": () {
      //     Navigator.of(context).pushNamed(
      //       UtilityServiceListScreen.routeName,
      //       arguments: {'year': null, 'month': null, 'index': null},
      //     );
      //   },
      // },
      {
        "icon": PrimaryIcons.gym,
        "text": S.current.covenient_service,
        "page": BookingServicesScreen.routeName,
        "arg": {'year': null, 'month': null, 'index': null},
        "tap": () {
          Navigator.of(context).pushNamed(
            UtilityServiceListScreen.routeName,
            arguments: {'year': null, 'month': null, 'index': null},
          );
        },
      },
      if (isResient)
        {
          "icon": PrimaryIcons.comment,
          "text": S.current.reflex,
          "page": ReflectionScreen.routeName,
          "arg": null,
          "tap": () {
            Navigator.of(context).pushNamed(ReflectionScreen.routeName);
          },
        },
      if (isResient)
        {
          "icon": PrimaryIcons.new_user,
          "text": S.current.resident_reg,
          "page": RegisterResidentScreen.routeName,
          "arg": null,
          "tap": () {
            Navigator.of(context).pushNamed(
              RegisterResidentScreen.routeName,
            );
          },
        },
      {
        "icon": PrimaryIcons.news,
        "text": S.current.event,
        "page": EventListScreen.routeName,
        "arg": null,
        "tap": () {
          Navigator.of(context).pushNamed(EventListScreen.routeName);
        },
      },
    ];

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.current.category,
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
                  Navigator.of(context).pushNamed(
                    e["page"] as String,
                    arguments: e['arg'],
                  );
                  print(e);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: PrimaryIcon(
                        icons: e['icon'] as PrimaryIcons,
                        color: primaryColorBase,
                        padding: const EdgeInsets.all(8),
                        size: 32,
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
