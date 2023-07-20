import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/event.dart';
import '../../../utils/utils.dart';

// ignore: must_be_immutable
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
    this.type,
    this.timeStatus,
    this.participate,
    this.isPaticipation = false,
    this.isShowButtonParticipate = true,
  });
  String? title;
  String? endDate;
  String? startEvent;
  String? endEvent;
  String? location;
  String? type;
  String? timeStatus;
  bool isPaticipation;
  bool isShowButtonParticipate;
  EventParticipation? participate;
  Function() onTap;
  Function()? onPart;

  genStatus(String status) {
    switch (status) {
      case "COMING":
        return S.current.coming_soon;
      case "HAPPENING":
        return S.current.happening;
      case "HAPPENED":
        return S.current.happened;
      default:
        return S.current.coming_soon;
    }
  }

  genColor(String status) {
    switch (status) {
      case "COMING":
        return pinkColorBase;
      case "HAPPENING":
        return yellowColorBase;
      case "HAPPENED":
        return greenColorBase;
      default:
        return grayScaleColorBase;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      // onTap: onTap,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      background: Colors.white,
      child: Column(
        children: [
          if (type == "HISTORY")
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: genColor(timeStatus ?? ""),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Text(
                  genStatus(timeStatus ?? ""),
                  style: txtSemiBold(12, Colors.white),
                ),
              ),
            ),
          type == "HISTORY" ? vpad(2) : vpad(24),
          Text(
            title ?? '',
            style: txtBold(18, primaryColor6),
            textAlign: TextAlign.center,
          ),
          if (endDate != null) vpad(16),
          if (endDate != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  const PrimaryIcon(
                    icons: PrimaryIcons.calendar,
                    color: grayScaleColor4,
                  ),
                  hpad(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type != "HISTORY"
                              ? '${S.of(context).end_time_reg}:'
                              : '${S.of(context).reg_time}:',
                          style: txtRegular(12, grayScaleColorBase),
                          overflow: TextOverflow.visible,
                        ),
                        Text(
                          Utils.dateFormat(
                            type != "HISTORY"
                                ? (endDate ?? "")
                                : (participate!.createdTime ?? ""),
                            1,
                          ),
                          style: txtRegular(12, grayScaleColorBase),
                          overflow: TextOverflow.visible,
                        )
                      ],
                    ),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${S.of(context).time_event_happening}:',
                        style: txtRegular(12, grayScaleColorBase),
                        overflow: TextOverflow.visible,
                      ),
                      Text(
                        "${Utils.dateFormat(startEvent ?? '', 1)} - ${Utils.dateFormat(endEvent ?? "", 1)}",
                        style: txtRegular(12, grayScaleColorBase),
                        overflow: TextOverflow.visible,
                      )
                    ],
                  ),
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
                width: 130,
              ),
              if (type == "COMING" &&
                  !isPaticipation &&
                  isShowButtonParticipate)
                PrimaryButton(
                  buttonSize: ButtonSize.small,
                  buttonType: ButtonType.green,
                  text: S.of(context).participate,
                  onTap: onPart,
                  width: 130,
                ),
            ],
          ),
          vpad(16),
        ],
      ),
    );
  }
}
