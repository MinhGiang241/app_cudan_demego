import 'package:app_cudan/screens/services/gym_card/gym_card_list_screen.dart';
import 'package:app_cudan/screens/services/parcel/parcels_list_screen.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../widgets/search_bar.dart';
import 'parking_card/parking_card_list_screen.dart';
import 'resident_card/resident_card_screen.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});
  static const routeName = '/services';

  @override
  Widget build(BuildContext context) {
    var data = [
      {
        "background": gradientBlue,
        "icon": PrimaryIcons.car_bg,
        "title": S.current.parking_card,
        "navigator": ParkingCardListScreen.routeName,
      },
      {
        "background": gradientPink,
        "icon": PrimaryIcons.elevator_bg,
        "title": S.current.elevator_card,
        "navigator": GymCardListScreen.routeName,
      },
      {
        "background": gradientPurple,
        "icon": PrimaryIcons.gym_bg,
        "title": S.current.gym_card,
        "navigator": GymCardListScreen.routeName,
      },
      {
        "background": gradientGreen,
        "icon": PrimaryIcons.identity_bg,
        "title": S.current.res_card,
        "navigator": ResidentCardListScreen.routeName,
      },
      {
        "background": gradientYellow,
        "icon": PrimaryIcons.dog_bg,
        "title": S.current.pet,
        "navigator": ParcelListScreen.routeName,
      },
      {
        "background": gradientTurquoise,
        "icon": PrimaryIcons.swim_bg,
        "title": S.current.pool,
        "navigator": GymCardListScreen.routeName,
      },
    ];
    return PrimaryScreen(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: ListView(
              children: [
                vpad(12),
                Center(
                  child: Text(
                    S.of(context).services,
                    style: txtDisplayMedium(),
                  ),
                ),
                SearchBar(),
                vpad(12),
                SizedBox(
                  height: dvHeight(context) - 215,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.4,
                    children: [
                      ...data.map(
                        (e) => InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(e["navigator"] as String);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              gradient: e['background'] as Gradient,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                PrimaryIcon(
                                  icons: e['icon'] as PrimaryIcons,
                                  size: 80,
                                  color: Colors.white,
                                ),
                                Text(
                                  e['title'] as String,
                                  style:
                                      txtBodyMediumRegular(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
