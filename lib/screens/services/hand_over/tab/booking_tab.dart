import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_loading.dart';
import '../accept_hand_over_screen.dart';
import '../booking_screen.dart';

class BookingTab extends StatefulWidget {
  const BookingTab({super.key});

  @override
  State<BookingTab> createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab> {
  var list = [
    {
      "name": "Tên mặt bằng",
      "hand_date": "02/03/2023",
      "hand_time": "09:30",
      "status": "APPROVED"
    },
    {
      "name": "Tên mặt bằng",
      "hand_date": "02/03/2023",
      "hand_time": "09:30",
      "status": "WAIT"
    },
    {
      "name": "Tên mặt bằng",
      "hand_date": "02/03/2023",
      "hand_time": "09:30",
      "status": "CANCEL"
    },
    {
      "name": "Tên mặt bằng",
      "hand_date": "02/03/2023",
      "hand_time": "09:30",
      "status": "APPROVED"
    },
  ];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {}(),
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
        } else if (list.isEmpty) {
          return SafeArea(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(
                  backgroundColor: Theme.of(context).primaryColor),
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
        return SafeArea(
            child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropMaterialHeader(
              backgroundColor: Theme.of(context).primaryColor),
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
                    Navigator.pushNamed(context, BookingScreen.routeName,
                        arguments: {"book": false});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    child: Row(children: [
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
                            e['name'] as String,
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
                              TableRow(children: [
                                Text('${S.of(context).hand_date}:'),
                                Text(
                                  e['hand_date'] as String,
                                ),
                              ]),
                              TableRow(children: [vpad(2), vpad(2)]),
                              TableRow(children: [
                                Text('${S.of(context).hand_time}:'),
                                Text(
                                  e['hand_time'] as String,
                                ),
                              ]),
                              TableRow(children: [vpad(2), vpad(2)]),
                              TableRow(children: [
                                Text('${S.of(context).status}:'),
                                Text(genStatus(e['status'] as String),
                                    style: txtBold(14,
                                        genStatusColor(e['status'] as String)))
                              ]),
                            ],
                          )
                        ],
                      ))
                    ]),
                  ),
                );
              }),
              vpad(60)
            ],
          ),
        ));
      },
    );
  }
}