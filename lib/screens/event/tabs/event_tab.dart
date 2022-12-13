import 'package:app_cudan/screens/event/prv/event_list_prv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/event.dart';
import '../../../services/api_event.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../home/widgets/events_widget.dart';
import '../event_details_screen.dart';
import '../prv/event_tab_prv.dart';
import '../widget/event_widget.dart';

class EventTab extends StatefulWidget {
  EventTab({super.key, required this.type});

  String type;

  @override
  State<EventTab> createState() => _EventTabState();
}

class _EventTabState extends State<EventTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventTabPrv(type: widget.type),
        builder: (context, builder) {
          return FutureBuilder(
              future: context.read<EventTabPrv>().getEventList(context, true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: PrimaryLoading());
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return PrimaryErrorWidget(
                      code: snapshot.hasError ? "err" : "1",
                      message: snapshot.data.toString(),
                      onRetry: () async {
                        setState(() {});
                      });
                } else if (context.watch<EventTabPrv>().listEvent.isEmpty) {
                  return SafeArea(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () {
                        context.read<EventTabPrv>().getEventList(context, true);
                        _refreshController.refreshCompleted();
                      },
                      onLoading: () {
                        context
                            .read<EventTabPrv>()
                            .getEventList(context, false);
                        _refreshController.loadComplete();
                      },
                      controller: _refreshController,
                      header: WaterDropMaterialHeader(
                          backgroundColor: Theme.of(context).primaryColor),
                      child: PrimaryEmptyWidget(
                        emptyText: S.of(context).no_event,
                        icons: PrimaryIcons.event,
                        action: () {
                          // Utils.pushScreen(context, const RegisterParkingCard());
                        },
                      ),
                    ),
                  );
                } else {
                  return SafeArea(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () {
                        context.read<EventTabPrv>().getEventList(context, true);
                        _refreshController.refreshCompleted();
                      },
                      controller: _refreshController,
                      header: WaterDropMaterialHeader(
                          backgroundColor: Theme.of(context).primaryColor),
                      onLoading: () {
                        context
                            .read<EventTabPrv>()
                            .getEventList(context, false);
                        _refreshController.loadComplete();
                      },
                      child: ListView(
                        children: [
                          vpad(24),
                          ...context
                              .watch<EventTabPrv>()
                              .listEvent
                              .map((e) => EventCardWidget(
                                    type: widget.type,
                                    onPart: () {
                                      Utils.showConfirmMessage(
                                          context: context,
                                          title: S
                                              .of(context)
                                              .confirm_participate_event,
                                          content: S
                                              .of(context)
                                              .confirm_par_ques_event(
                                                  e.title != null
                                                      ? e.title!.toLowerCase()
                                                      : ''),
                                          onConfirm: () {
                                            context
                                                .read<EventTabPrv>()
                                                .participateEvent(context, e);
                                            setState(() {});
                                          });
                                    },
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, EventDetailsScreen.routeName,
                                          arguments: e);
                                    },
                                    participate: e.e,
                                    timeStatus: e.time_status,
                                    isPaticipation: e.isParticipation ?? false,
                                    title: e.title,
                                    endDate: e.due_regist,
                                    endEvent: e.end_time,
                                    startEvent: e.start_time,
                                    location: e.location,
                                    isShowButtonParticipate:
                                        e.isShowButtonParticipate ?? true,
                                  )),
                        ],
                      ),
                    ),
                  );
                }
              });
        });
  }
}
