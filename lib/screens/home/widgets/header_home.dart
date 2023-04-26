import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/response_resident_own.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';
import '../../auth/prv/resident_info_prv.dart';
import 'choose_apartment_bottom_sheet.dart';

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

    selectApartment(MapEntry<int, ResponseResidentOwn> select) {
      setState(() {
        context.read<ResidentInfoPrv>().selectApartment(select);
      });
    }

    return Column(
      children: [
        FittedBox(
          child: Row(
            // textBaseline: TextBaseline.ideographic,
            crossAxisAlignment: CrossAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.baseline,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hpad(21),
              const Icon(
                Icons.favorite,
                color: primaryColor4,
              ),
              Row(
                textBaseline: TextBaseline.ideographic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  hpad(12),
                  Text(
                    '${S.of(context).hello}, ',
                    style: txtBodySmallRegular(color: grayScaleColor2),
                  ),
                  if (userInfo != null)
                    Text(
                      userInfo.info_name ?? '',
                      style: txtLinkMedium(),
                      overflow: TextOverflow.ellipsis,
                    )
                ],
              ),
            ],
          ),
        ),
        vpad(30),
        if (Provider.of<ResidentInfoPrv>(context, listen: false)
            .listOwn
            .isNotEmpty)
          RepaintBoundary(
            child: Row(
              children: [
                PrimaryCard(
                  width: dvWidth(context) - 48,
                  onTap: () {
                    Utils.showBottomSheet(
                      context: context,
                      child: ChooseAparmentBottomSheet(
                        selectApartment: selectApartment,
                        list: listOwn, //context.read<AuthPrv>().apartments!,
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      leading: const PrimaryIcon(
                        padding: EdgeInsets.all(9),
                        icons: PrimaryIcons.home_smile,
                        color: primaryColor4,
                        backgroundColor: primaryColor5,
                        style: PrimaryIconStyle.round,
                      ),
                      // hpad(12),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedApartment?.name ?? "",
                            style: txtLinkMedium(),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '${selectedFloor?.name ?? ""} -${selectedBulding?.name ?? ""}',
                            style: txtBodySmallRegular(color: grayScaleColor2),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),

                      // const Spacer(),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: grayScaleColor2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
