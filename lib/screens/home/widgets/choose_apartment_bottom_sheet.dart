import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../models/response_resident_own.dart';
import '../../../widgets/primary_bottom_sheet.dart';
import '../../../widgets/primary_icon.dart';

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
              ...widget.list.asMap().entries.map(
                    (e) => Column(
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
                              vertical: 16,
                              horizontal: 16,
                            ),
                            child: ListTile(
                              leading: const PrimaryIcon(
                                icons: PrimaryIcons.home_smile,
                                style: PrimaryIconStyle.round,
                                backgroundColor: primaryColor5,
                                color: primaryColor4,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.value.apartment?.name ?? "",
                                    style: txtLinkMedium(),
                                  ),
                                  Text(
                                    '${e.value.floor?.name ?? ""}- ${e.value.building?.name ?? ""}',
                                    style: txtBodySmallRegular(
                                      color: grayScaleColor2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
