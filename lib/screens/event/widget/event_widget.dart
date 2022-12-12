import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../event_details_screen.dart';

class EventCardWidget extends StatelessWidget {
  EventCardWidget({
    super.key,
    this.title,
    this.endDate,
    this.endEvent,
    this.location,
    this.startEvent,
    required this.onTap,
    this.onPart,
  });
  String? title;
  String? endDate;
  String? startEvent;
  String? endEvent;
  String? location;
  Function() onTap;
  Function()? onPart;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      // onTap: onTap,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      background: Colors.white,
      child: Column(children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: const BoxDecoration(
                color: greenColorBase,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(8))),
            child: Text(
              S.of(context).coming_soon,
              style: txtSemiBold(12, Colors.white),
            ),
          ),
        ),
        vpad(2),
        Text(title ?? '', style: txtBold(18, primaryColor6)),
        vpad(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            children: [
              const PrimaryIcon(
                icons: PrimaryIcons.calendar,
                color: grayScaleColor4,
              ),
              hpad(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).end_time_reg,
                    style: txtRegular(12, grayScaleColorBase),
                  ),
                  Text(Utils.dateFormat(endDate ?? "", 1),
                      style: txtRegular(12, grayScaleColorBase))
                ],
              )
            ],
          ),
        ),
        vpad(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            children: [
              const PrimaryIcon(
                icons: PrimaryIcons.calendar,
                color: grayScaleColor4,
              ),
              hpad(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).time_event_happening,
                    style: txtRegular(12, grayScaleColorBase),
                  ),
                  Text(
                      "${Utils.dateFormat(startEvent ?? '', 1)} - ${Utils.dateFormat(endEvent ?? "", 1)}",
                      style: txtRegular(12, grayScaleColorBase))
                ],
              )
            ],
          ),
        ),
        vpad(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            children: [
              const PrimaryIcon(
                icons: PrimaryIcons.mappin,
                color: grayScaleColor4,
              ),
              hpad(12),
              Expanded(
                child: Text(
                  location ?? '',
                  maxLines: 2,
                  style: txtRegular(12, grayScaleColorBase),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
        vpad(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PrimaryButton(
              buttonSize: ButtonSize.small,
              buttonType: ButtonType.primary,
              text: S.of(context).detail_view,
              onTap: onTap,
            ),
            PrimaryButton(
              buttonSize: ButtonSize.small,
              buttonType: ButtonType.green,
              text: S.of(context).participate,
              onTap: onPart,
            ),
          ],
        ),
        vpad(16),
      ]),
    );
  }
}
