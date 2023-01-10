import 'package:app_cudan/screens/home/home_screen.dart';
import 'package:app_cudan/screens/services/gym_card/gym_card_list_screen.dart';
import 'package:app_cudan/screens/services/missing_object/missing_object_screen.dart';
import 'package:app_cudan/screens/services/parcel/parcel_list_screen.dart';
import 'package:app_cudan/screens/services/pet/pet_list_screen.dart';

import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:app_cudan/widgets/primary_image_netword.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../constants/api_constant.dart';
import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../widgets/search_bar.dart';
import 'construction/construction_list_screen.dart';
import 'delivery/delivery_list_screen.dart';
import 'extra_service/extra_service_card_list.dart';
import 'hand_over/hand_over_screen.dart';
import 'parking_card/transport_card_list_screen.dart';
import 'resident_card/resident_card_screen.dart';
import 'service_prv.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});
  static const routeName = '/services';

  @override
  Widget build(BuildContext context) {
    var data = [
      {
        "color": primaryColorBase,
        "background": gradientBlue,
        "icon": PrimaryIcons.inbox,
        "title": S.current.res_card,
        "navigator": ResidentCardListScreen.routeName,
      },
      {
        "color": turquoiseColor,
        "background": gradientTurquoise,
        "icon": PrimaryIcons.car_bg,
        "title": S.current.parking_card,
        "navigator": TransportationCardListScreen.routeName,
      },
      {
        "color": greenColorBase,
        "background": gradientGreen,
        "icon": PrimaryIcons.bone,
        "title": S.current.pet,
        "navigator": PetListScreen.routeName,
      },
      {
        "color": pinkColorBase,
        "background": gradientPink,
        "icon": PrimaryIcons.wrench,
        "title": S.current.construction,
        "navigator": ConstructionListScreen.routeName,
      },
      {
        "color": yellowColorBase,
        "background": gradientYellow,
        "icon": PrimaryIcons.box,
        "title": S.current.reg_deliver,
        "navigator": DeliveryListScreen.routeName,
      },
      {
        "color": primaryColorBase,
        "background": gradientBlue,
        "icon": PrimaryIcons.package,
        "title": S.current.parcel,
        "navigator": ParcelListScreen.routeName,
      },
      {
        "color": greenColor,
        "background": gradientGreen,
        "icon": PrimaryIcons.user_detail,
        "title": S.current.info_reception,
        "navigator": GymCardListScreen.routeName,
      },
      {
        "color": turquoiseColor,
        "background": gradientTurquoise,
        "icon": PrimaryIcons.binoculars,
        "title": S.current.missing_obj,
        "navigator": MissingObectScreen.routeName,
      },
      {
        "color": purpleColorBase,
        "background": gradientPurple,
        "icon": PrimaryIcons.credit_card_alt,
        "title": S.current.follow_ser,
        "navigator": GymCardListScreen.routeName,
      },
      {
        "color": yellowColorBase,
        "background": gradientYellow,
        "icon": PrimaryIcons.home,
        "title": S.current.hand_over,
        "navigator": HandOverScreen.routeName,
      },
      // {
      //   "color": purpleColorBase,
      //   "background": gradientPurple,
      //   "icon": PrimaryIcons.gym_bg,
      //   "title": S.current.gym_card,
      //   "navigator": GymCardListScreen.routeName,
      // },

      // {
      //   "color": yellowColor7,
      //   "background": gradientBrow,
      //   "icon": PrimaryIcons.package,
      //   "title": S.current.parcel,
      //   "navigator": GymCardListScreen.routeName,
      // },

      // {
      //   "color": pinkColorBase,
      //   "background": gradientPink,
      //   "icon": PrimaryIcons.birthday,
      //   "title": S.current.pool,
      //   "navigator": GymCardListScreen.routeName,
      // },
      // {
      //   "color": greenColorBase,
      //   "background": gradientGreen,
      //   "icon": PrimaryIcons.credit_card_alt,
      //   "title": S.current.pool,
      //   "navigator": GymCardListScreen.routeName,
      // },
    ];
    return ChangeNotifierProvider(
        create: (context) => ServicePrv(),
        builder: (context, state) {
          return PrimaryScreen(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: BackButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context,
                        HomeScreen.routeName, (route) => route.isCurrent)),
              ),
              body: FutureBuilder(
                  future: context.read<ServicePrv>().getExtraService(context),
                  builder: (context, builder) {
                    return Padding(
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
                            // SearchBar(),
                            vpad(12),
                            SizedBox(
                              height: dvHeight(context) - 100,
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
                                        Navigator.of(context).pushNamed(
                                            e["navigator"] as String);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12)),
                                            // gradient: gradientW,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.7),
                                                spreadRadius: 1,
                                                blurRadius: 4,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurStyle:
                                                            BlurStyle.normal,
                                                        spreadRadius: 1,
                                                        blurRadius: 24,
                                                        color: (e['color']
                                                                as Color)
                                                            .withOpacity(0.25),
                                                        offset:
                                                            const Offset(0, 16))
                                                  ],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(24)),
                                                  gradient: e['background']
                                                      as Gradient),
                                              child: PrimaryIcon(
                                                icons:
                                                    e['icon'] as PrimaryIcons,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                            vpad(12),
                                            Text(
                                              e['title'] as String,
                                              overflow: TextOverflow.ellipsis,
                                              style: txtBold(13),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  ...context
                                      .watch<ServicePrv>()
                                      .listExtraService
                                      .map((e) => InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  ExtraServiceCardListScreen
                                                      .routeName,
                                                  arguments: {
                                                    "service": e,
                                                    "year": DateTime.now().year,
                                                    "month":
                                                        DateTime.now().month
                                                  });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                  // gradient: gradientW,
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.7),
                                                      spreadRadius: 1,
                                                      blurRadius: 4,
                                                      offset: const Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ]),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                                blurStyle:
                                                                    BlurStyle
                                                                        .normal,
                                                                spreadRadius: 1,
                                                                blurRadius: 24,
                                                                color: (primaryColorBase)
                                                                    .withOpacity(
                                                                        0.25),
                                                                offset:
                                                                    const Offset(
                                                                        0, 16))
                                                          ],
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          24)),
                                                          gradient:
                                                              gradientBlue),
                                                      child:
                                                          PrimaryImageNetwork(
                                                        canShowPhotoView: false,
                                                        fit: BoxFit.contain,
                                                        path:
                                                            "${ApiConstants.uploadURL}?load=${e.service_icon!.id ?? ""}",
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    24)),
                                                      )

                                                      // Image.network(

                                                      //     fit: BoxFit.contain,
                                                      //     width: 20,
                                                      //     height: 20,
                                                      //     "${ApiConstants.uploadURL}?load=${e.service_icon!.id ?? ""}"),

                                                      ),
                                                  vpad(12),
                                                  Text(
                                                    e.name ?? "",
                                                    style: txtBold(13),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                  vpad(0),
                                  vpad(0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }));
        });
  }
}
