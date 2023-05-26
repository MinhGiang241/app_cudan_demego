import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/hand_over.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_loading.dart';
import '../accept_hand_over_screen.dart';
import '../booking_screen.dart';
import '../prv/booking_prv.dart';
import '../prv/hand_over_prv.dart';

class BookingTab extends StatefulWidget {
  const BookingTab({super.key});

  @override
  State<BookingTab> createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    var listSchedule = context.watch<HandOverPrv>().listHandOverSchedule;
    return FutureBuilder(
      future:
          context.read<HandOverPrv>().getHandOverBookingByResidentId(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: PrimaryLoading());
        } else if (snapshot.connectionState == ConnectionState.none) {
          return PrimaryErrorWidget(
            code: snapshot.hasError ? "err" : "1",
            message: snapshot.data.toString(),
            onRetry: () async {
              setState(() {});
            },
          );
        } else if (listSchedule.isEmpty) {
          return SafeArea(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              controller: _refreshController,
              onRefresh: () {
                setState(() {});
                _refreshController.refreshCompleted();
              },
              child: PrimaryEmptyWidget(
                emptyText: S.of(context).no_hand_over,
                icons: PrimaryIcons.home,
                action: () {},
              ),
            ),
          );
        }

        List<AppointmentSchedule> newL = [];
        List<AppointmentSchedule> wait = [];
        List<AppointmentSchedule> app1 = [];
        List<AppointmentSchedule> app2 = [];
        List<AppointmentSchedule> cancel = [];
        for (var i in listSchedule) {
          if (i.status == "WAIT") {
            wait.add(i);
          } else if (i.status == "NEW") {
            newL.add(i);
          } else if (i.status == "APPROVEDFIRST") {
            app1.add(i);
          } else if (i.status == "APPROVEDSECOND") {
            app2.add(i);
          } else if (i.status == "CANCEL") {
            cancel.add(i);
          }
        }

        newL.sort((a, b) => b.createdTime!.compareTo(a.createdTime!));
        wait.sort((a, b) => b.createdTime!.compareTo(a.createdTime!));
        app1.sort((a, b) => b.createdTime!.compareTo(a.createdTime!));
        app2.sort((a, b) => b.createdTime!.compareTo(a.createdTime!));
        cancel.sort((a, b) => b.createdTime!.compareTo(a.createdTime!));

        List<AppointmentSchedule> list = newL + wait + app1 + app2 + cancel;

        return SafeArea(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropMaterialHeader(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            controller: _refreshController,
            onRefresh: () {
              setState(() {});
              _refreshController.refreshCompleted();
            },
            child: ListView(
              children: [
                vpad(24),
                ...list.map((e) {
                  return PrimaryCard(
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 12, right: 12),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        BookingScreen.routeName,
                        arguments: {"book": false, "schedule": e},
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          const PrimaryIcon(
                            icons: PrimaryIcons.home,
                            style: PrimaryIconStyle.gradient,
                            gradients: PrimaryIconGradient.yellow,
                            size: 32,
                            padding: EdgeInsets.all(12),
                            color: Colors.white,
                          ),
                          hpad(16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                vpad(10),
                                Text(
                                  "${e.a?.name}-${e.a?.f?.name}-${e.a?.b?.name}",
                                  style: txtBold(16),
                                ),
                                vpad(4),
                                Table(
                                  textBaseline: TextBaseline.ideographic,
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.baseline,
                                  columnWidths: const {
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(2)
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        Text('${S.of(context).hand_date}:'),
                                        Text(
                                          Utils.dateFormat(e.date ?? "", 1),
                                        ),
                                      ],
                                    ),
                                    TableRow(children: [vpad(2), vpad(2)]),
                                    TableRow(
                                      children: [
                                        Text('${S.of(context).hand_time}:'),
                                        Text(
                                          e.hour ?? "",
                                        ),
                                      ],
                                    ),
                                    TableRow(children: [vpad(2), vpad(2)]),
                                    TableRow(
                                      children: [
                                        Text('${S.of(context).status}:'),
                                        Text(
                                          genStatus(e.status ?? ""),
                                          style: txtBold(
                                            14,
                                            genStatusColor(
                                              e.status,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
                vpad(60)
              ],
            ),
          ),
        );
      },
    );
  }
}
