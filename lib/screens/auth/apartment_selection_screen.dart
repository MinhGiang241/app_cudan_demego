import 'package:app_cudan/screens/auth/prv/auth_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/response_apartment.dart';
import '../../services/api_tower.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_screen.dart';
import '../../widgets/primary_text_field.dart';
import '../home/home_screen.dart';
import 'prv/resident_info_prv.dart';

class ApartmentSeletionScreen extends StatefulWidget {
  const ApartmentSeletionScreen(
      {Key? key, this.listProject, required this.context})
      : super(key: key);
  static const routeName = '/selection';
  final ResponseApartment? listProject;
  final BuildContext context;
  @override
  State<ApartmentSeletionScreen> createState() =>
      _ApartmentSeletionScreenState();
}

// Fake data
var apartments = [
  Apartments(detail: "test", id: '1', name: "test1", floorPlan: [
    FloorPlan(id: 'f1', name: 'loor', detail: "df1"),
    FloorPlan(id: 'f2', name: 'loor', detail: "df1"),
  ]),
  Apartments(detail: "test", id: '2', name: "test2", floorPlan: [
    FloorPlan(id: 'f1', name: 'loor', detail: "df2"),
    FloorPlan(id: 'f2', name: 'loor', detail: "df2"),
  ]),
];

class _ApartmentSeletionScreenState extends State<ApartmentSeletionScreen> {
  @override
  void initState() {
    // final arg = ModalRoute.of(widget.context)!.settings.arguments as Map;
    // widget.context.read<ResidentInfoPrv>().listOwn;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listOwn = widget.context.read<ResidentInfoPrv>().listOwn;
    var listProject = [];
    for (var e in listOwn) {
      if (e.apartment?.name != null) {
        listProject.add(e.apartment?.name);
      }
    }

    listProject.toSet().toList();
    return PrimaryScreen(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthPrv>().onSignOut(context);
              },
              icon: const Icon(Icons.logout)),
          hpad(12)
        ],
      ),
      body: Column(
        children: [
          vpad(24 +
              AppBar().preferredSize.height +
              MediaQuery.of(context).padding.top),
          Center(
              child: Text(S.of(context).choose_an_apartment,
                  style: txtDisplayMedium())),
          vpad(36),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: PrimaryTextField(
              hint: S.of(context).search_aparment,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(12.0),
                child: PrimaryIcon(
                    icons: PrimaryIcons.search_outline, color: grayScaleColor2),
              ),
            ),
          ),
          vpad(16),
          Expanded(
              child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            children: [
              // ...widget.listProject!.apartments!
              // ...listProject.map((e) => Text(e)),
              ...listOwn.map((e) => PrimaryCard(
                        onTap: () {
                          widget.context
                              .read<ResidentInfoPrv>()
                              .selectedApartment = e;
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              HomeScreen.routeName, (route) => false);
                        },
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(children: [
                            const PrimaryIcon(
                              icons: PrimaryIcons.home_smile,
                              color: primaryColor4,
                              backgroundColor: primaryColor5,
                              style: PrimaryIconStyle.round,
                              padding: EdgeInsets.all(12),
                            ),
                            hpad(16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.building?.name ?? '',
                                    style: txtLinkSmall()),
                                vpad(4),
                                Text(e.apartment?.name ?? '',
                                    style: txtBodySmallBold()),
                              ],
                            )
                          ]),
                        ),
                      )

                  // Text(e.apartment?.name ?? ""),
                  ),
              // .map<Widget>((e) => Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(e.building?.name ?? "", style: txtLinkMedium()),
              //         Text(e.building?.code ?? "", style: txtBodySmallBold()),
              //         vpad(12),
              //         ...e.a!
              //             .map<Widget>((e) => Padding(
              //                   padding: const EdgeInsets.only(bottom: 16),
              //                   child: PrimaryCard(
              //                     onTap: () {
              //                       Navigator.of(context)
              //                           .pushNamedAndRemoveUntil(
              //                               HomeScreen.routeName,
              //                               (route) => false);
              //                       // context
              //                       //     .read<AuthPrv>()
              //                       //     .onSelectApartment(context, e);
              //                     },
              //                     child: Padding(
              //                       padding: const EdgeInsets.all(15),
              //                       child: Row(
              //                         children: [
              //                           const PrimaryIcon(
              //                             icons: PrimaryIcons.home_smile,
              //                             color: primaryColor4,
              //                             backgroundColor: primaryColor5,
              //                             style: PrimaryIconStyle.round,
              //                             padding: EdgeInsets.all(12),
              //                           ),
              //                           hpad(16),
              //                           Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                             children: [
              //                               Text(e.name ?? "",
              //                                   style: txtLinkSmall()),
              //                               vpad(4),
              //                               Text(e.detail ?? "",
              //                                   style: txtBodySmallBold()),
              //                             ],
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ))
              //             .toList()
              //       ],
              //     )),
              vpad(50)
            ],
          )),
        ],
      ),
    );
  }
}
