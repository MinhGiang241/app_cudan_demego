import 'package:app_cudan/screens/event/event_details_screen.dart';
import 'package:app_cudan/screens/event/event_list_screen.dart';
import 'package:app_cudan/screens/home/prv/home_prv.dart';
import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
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
          context.watch<HomePrv>().isEventLoading
              ? const PrimaryLoading()
              : PrimaryCard(
                  onTap: () {
                    Navigator.pushNamed(context, EventDetailsScreen.routeName,
                        arguments: context.read<HomePrv>().event);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 30, left: 24, right: 24),
                    child: Row(
                      children: [
                        const EventWidget(),
                        hpad(24),
                        SizedBox(
                          // width: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.watch<HomePrv>().event!.title ?? "",
                                  style: txtLinkMedium()),
                              vpad(4),
                              Text(
                                  Utils.dateFormat(
                                      context
                                              .watch<HomePrv>()
                                              .event!
                                              .start_time ??
                                          "",
                                      1),
                                  style: txtBodyXSmallRegular(
                                      color: grayScaleColor2)),
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
