import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../models/response_apartment.dart';
import '../../../models/response_resident_own.dart';
import '../../../widgets/primary_bottom_sheet.dart';
import '../../../widgets/primary_icon.dart';
import '../../auth/prv/auth_prv.dart';
import '../../auth/prv/resident_info_prv.dart';

class ChooseAparmentBottomSheet extends StatefulWidget {
  const ChooseAparmentBottomSheet({
    Key? key,
    required this.list,
    required this.selectApartment,
  }) : super(key: key);

  final List<ResponseResidentOwn> list;
  final Function(MapEntry<int, ResponseResidentOwn>) selectApartment;

  @override
  State<ChooseAparmentBottomSheet> createState() =>
      _ChooseAparmentBottomSheetState();
}

class _ChooseAparmentBottomSheetState extends State<ChooseAparmentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return PrimaryBottomSheet(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...widget.list.asMap().entries.map((e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  // FocusScope.of(context).unfocus();
                                  widget.selectApartment(e);
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 16),
                                  child: ListTile(
                                    leading: const PrimaryIcon(
                                      icons: PrimaryIcons.home_smile,
                                      style: PrimaryIconStyle.round,
                                      backgroundColor: primaryColor5,
                                      color: primaryColor4,
                                    ),

                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.value.apartment?.name ?? "",
                                            style: txtLinkMedium()),
                                        Text(
                                            '${e.value.floor?.name ?? ""}- ${e.value.building?.name ?? ""}',
                                            style: txtBodySmallRegular(
                                                color: grayScaleColor2))
                                      ],
                                    ),

                                    // const PrimaryIcon(
                                    //     icons: PrimaryIcons.check,
                                    //     size: 32,
                                    //     color: primaryColor3)
                                  ),
                                ),
                              ),
                            ]))
                  ]),
            )
            // ...list.apartments!
            //     .map<Widget>((e) => Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             vpad(8),
            //             Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //               child: Text(e.name ?? "", style: txtLinkXSmall()),
            //             ),
            //             vpad(4),
            //             ...List.generate(
            //                 e.floorPlan!.length,
            //                 (index) => InkWell(
            //                       onTap: () {
            //                         context.read<AuthPrv>().onChangeApartment(
            //                             context, e.floorPlan![index]);
            //                       },
            //                       child: Padding(
            //                         padding: const EdgeInsets.symmetric(
            //                             vertical: 16, horizontal: 16),
            //                         child: Row(
            //                           children: [
            //                             const PrimaryIcon(
            //                               icons: PrimaryIcons.home_smile,
            //                               style: PrimaryIconStyle.round,
            //                               backgroundColor: primaryColor5,
            //                               color: primaryColor4,
            //                             ),
            //                             hpad(12),
            //                             Column(
            //                               crossAxisAlignment:
            //                                   CrossAxisAlignment.start,
            //                               children: [
            //                                 Text(e.floorPlan![index].name ?? "",
            //                                     style: txtLinkMedium()),
            //                                 Text(e.floorPlan![index].detail ?? "",
            //                                     style: txtBodySmallRegular(
            //                                         color: grayScaleColor2))
            //                               ],
            //                             ),
            //                             const Spacer(),
            //                             if (context
            //                                     .read<AuthPrv>()
            //                                     .selectedApartment
            //                                     ?.id ==
            //                                 e.floorPlan![index].id)
            //                               const PrimaryIcon(
            //                                   icons: PrimaryIcons.check,
            //                                   size: 32,
            //                                   color: primaryColor3)
            //                           ],
            //                         ),
            //                       ),
            //                     )).toList(),
            //             const Divider(color: grayScaleColor4, height: 1)
            //           ],
            //         ))
            //     .toList(),
            // vpad(MediaQuery.of(context).padding.bottom)

            ));
  }
}
