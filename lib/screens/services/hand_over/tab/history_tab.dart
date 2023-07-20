import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/screens/services/hand_over/prv/hand_over_prv.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:flutter/material.dart';
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

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<HandOverPrv>().getHanOverHistory(
            context,
          ),
      builder: (context, snapshot) {
        List<HandOver> listH = context.watch<HandOverPrv>().listHandOver;
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
        } else if (listH.isEmpty) {
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

        List<HandOver> complete = [];
        List<HandOver> wait = [];
        List<HandOver> handing = [];
        List<HandOver> cancel = [];
        for (var i in listH) {
          if (i.status == "COMPLETE") {
            complete.add(i);
          } else if (i.status == "WAIT") {
            wait.add(i);
          } else if (i.status == "HANDING") {
            handing.add(i);
          } else if (i.status == "CANCEL") {
            cancel.add(i);
          }
        }

        complete.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        wait.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        handing.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        cancel.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        List<HandOver> list = wait + handing + complete + cancel;

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
                  return Stack(
                    children: [
                      PrimaryCard(
                        margin: const EdgeInsets.only(
                          bottom: 16,
                          left: 12,
                          right: 12,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AcceptHandOverScreen.routeName,
                            arguments: {
                              "status": e.status,
                              "handover": e,
                              'vote': false
                            },
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
                                      e.label ?? "",
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
                                              Utils.dateFormat(
                                                e.schedule_time ?? '',
                                                1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(children: [vpad(2), vpad(2)]),
                                        TableRow(
                                          children: [
                                            Text('${S.of(context).hand_time}:'),
                                            Text(
                                              e.schedule_hour ?? '',
                                            ),
                                          ],
                                        ),
                                        TableRow(children: [vpad(2), vpad(2)]),
                                        TableRow(
                                          children: [
                                            Text('${S.of(context).status}:'),
                                            Text(
                                              // e.s?.name ?? "",
                                              genStatusHandOver(e.status),
                                              style: txtBold(
                                                14,
                                                genStatusColorHandOver(
                                                  e.status as String,
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
                      ),
                      if (e.status_error != null && e.status_error != '')
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: (genStatusColorHandOver(
                                e.status_error as String,
                              )),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              e.se?.name ?? "",
                              style: txtSemiBold(12, Colors.white),
                            ),
                          ),
                        ),
                    ],
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
