import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../models/response_apartment.dart';
import '../../../widgets/primary_bottom_sheet.dart';
import '../../../widgets/primary_icon.dart';
import '../../auth/prv/auth_prv.dart';

class ChooseAparmentBottomSheet extends StatelessWidget {
  const ChooseAparmentBottomSheet({
    Key? key,
    required this.list,
  }) : super(key: key);

  final ResponseApartment list;

  @override
  Widget build(BuildContext context) {
    return PrimaryBottomSheet(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...list.apartments!
              .map<Widget>((e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      vpad(8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(e.name ?? "", style: txtLinkXSmall()),
                      ),
                      vpad(4),
                      ...List.generate(
                          e.floorPlan!.length,
                          (index) => InkWell(
                                onTap: () {
                                  context.read<AuthPrv>().onChangeApartment(
                                      context, e.floorPlan![index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 16),
                                  child: Row(
                                    children: [
                                      const PrimaryIcon(
                                        icons: PrimaryIcons.home_smile,
                                        style: PrimaryIconStyle.round,
                                        backgroundColor: primaryColor5,
                                        color: primaryColor4,
                                      ),
                                      hpad(12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(e.floorPlan![index].name ?? "",
                                              style: txtLinkMedium()),
                                          Text(e.floorPlan![index].detail ?? "",
                                              style: txtBodySmallRegular(
                                                  color: grayScaleColor2))
                                        ],
                                      ),
                                      const Spacer(),
                                      if (context
                                              .read<AuthPrv>()
                                              .selectedApartment
                                              ?.id ==
                                          e.floorPlan![index].id)
                                        const PrimaryIcon(
                                            icons: PrimaryIcons.check,
                                            size: 32,
                                            color: primaryColor3)
                                    ],
                                  ),
                                ),
                              )).toList(),
                      const Divider(color: grayScaleColor4, height: 1)
                    ],
                  ))
              .toList(),
          vpad(MediaQuery.of(context).padding.bottom)
        ],
      ),
    ));
  }
}
