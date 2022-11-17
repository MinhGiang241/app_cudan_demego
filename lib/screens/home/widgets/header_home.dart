import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/response_apartment.dart';
import '../../../models/response_resident_own.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';
import '../../auth/prv/auth_prv.dart';
import '../../auth/prv/resident_info_prv.dart';
import 'choose_apartment_bottom_sheet.dart';

var fakeApartments = ResponseApartment(
  apartments: [
    Apartments(
      detail: 'detail',
      floorPlan: [
        FloorPlan(detail: "detail", floorPlan: 1, id: '1', name: 'giang'),
        FloorPlan(detail: "detail", floorPlan: 1, id: '1', name: 'giang'),
        FloorPlan(detail: "detail", floorPlan: 1, id: '1', name: 'giang'),
      ],
      id: '1',
      name: 'giang',
    )
  ],
);

class HeaderHome extends StatefulWidget {
  const HeaderHome({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderHome> createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  @override
  Widget build(BuildContext context) {
    var userInfo = context.read<ResidentInfoPrv>().userInfo;
    var selectedApartment =
        context.read<ResidentInfoPrv>().selectedApartment?.apartment;
    var selectedBulding =
        context.read<ResidentInfoPrv>().selectedApartment?.building;
    var selectedFloor =
        context.read<ResidentInfoPrv>().selectedApartment?.floor;
    var listOwn = context.read<ResidentInfoPrv>().listOwn;

    selectApartment(ResponseResidentOwn select) {
      setState(() {
        context.read<ResidentInfoPrv>().selectApartment(select);
      });
    }

    return Column(
      children: [
        Row(
          children: [
            hpad(21),
            const Icon(
              Icons.favorite,
              color: primaryColor4,
            ),
            hpad(12),
            Text('${S.of(context).hello}, ',
                style: txtBodySmallRegular(color: grayScaleColor2)),
            Text(
              userInfo?.info_name ?? '',
              style: txtLinkMedium(),
            )
          ],
        ),
        vpad(30),
        RepaintBoundary(
          child: Row(children: [
            PrimaryCard(
              width: dvWidth(context) - 48,
              onTap: () {
                Utils.showBottomSheet(
                    context: context,
                    child: ChooseAparmentBottomSheet(
                        selectApartment: selectApartment,
                        list: listOwn //context.read<AuthPrv>().apartments!,
                        ));
              },
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const PrimaryIcon(
                      padding: EdgeInsets.all(9),
                      icons: PrimaryIcons.home_smile,
                      color: primaryColor4,
                      backgroundColor: primaryColor5,
                      style: PrimaryIconStyle.round,
                    ),
                    hpad(12),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(selectedApartment?.name ?? "Test",
                              style: txtLinkMedium()),
                          Text(selectedBulding?.name ?? "Test",
                              style:
                                  txtBodySmallRegular(color: grayScaleColor2)),
                        ]),
                    const Spacer(),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        color: grayScaleColor2)
                  ],
                ),
              ),
            ),
            // const Spacer(),
            // PrimaryIcon(
            //     icons: PrimaryIcons.bell_outline,
            //     style: PrimaryIconStyle.gradient,
            //     color: grayScaleColor2,
            //     //badge: "2",
            //     onTap: () {
            //       // Utils.pushScreen(context, const NotificationScreen());
            //     }),
          ]),
        ),
      ],
    );
  }
}
