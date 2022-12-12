import 'package:app_cudan/screens/event/event_list_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_card.dart';
import 'events_widget.dart';
import 'home_title_widget.dart';

class EventsHome extends StatelessWidget {
  const EventsHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        children: [
          HomeTitleWidget(
            title: S.of(context).event,
            onTapShowAll: () {
              Navigator.pushNamed(context, EventListScreen.routeName);
            },
          ),
          PrimaryCard(
              onTap: () {
                // Utils.pushScreen(context, const EventsScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 30, left: 24, right: 24),
                child: Row(
                  children: [
                    const EventWidget(),
                    hpad(24),
                    SizedBox(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).event, style: txtLinkMedium()),
                          vpad(4),
                          Text(S.of(context).event_msg,
                              style:
                                  txtBodyXSmallRegular(color: grayScaleColor2)),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
