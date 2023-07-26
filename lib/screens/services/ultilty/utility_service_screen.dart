import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import 'add_new_letter_ultility_service_screen.dart';
import 'prv/utility_list_prv.dart';

class UtilityServiceScreen extends StatefulWidget {
  UtilityServiceScreen({super.key});
  static const routeName = '/ultility-services';

  @override
  State<UtilityServiceScreen> createState() => _UtilityServiceScreenState();
}

class _UtilityServiceScreenState extends State<UtilityServiceScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UltilityListPrv(),
      builder: (context, child) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: "Dịch vụ tiện ích",
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: "Đặt chỗ",
            onPressed: () {
              Navigator.pushNamed(
                context,
                AddNewLetterUltilityScreen.routeName,
                arguments: {
                  'isEdit': false,
                },
              );
            },
            backgroundColor: primaryColorBase,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
          body: SafeArea(
            child: FutureBuilder(
              future: () {}(),
              builder: (context, snapshot) {
                var list = [
                  {'content': 'content'},
                  {'content': 'content'},
                  {'content': 'content'},
                ];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: PrimaryLoading());
                } else if (snapshot.hasError) {
                  return PrimaryErrorWidget(
                    code: snapshot.hasError ? "err" : "1",
                    message: snapshot.data.toString(),
                    onRetry: () async {
                      setState(() {});
                    },
                  );
                }
                if (list.isEmpty) {
                  return SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropMaterialHeader(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    controller: _refreshController,
                    onRefresh: () {
                      _refreshController.refreshCompleted();
                      setState(() {});
                    },
                    child: PrimaryEmptyWidget(
                      emptyText: 'Không có phiếu nào',
                      icons: PrimaryIcons.credit,
                      action: () {},
                    ),
                  );
                }

                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropMaterialHeader(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  controller: _refreshController,
                  onRefresh: () {
                    _refreshController.refreshCompleted();
                    setState(() {});
                  },
                  child: ListView(
                    children: [
                      ...list.map((i) {
                        var listContent = [
                          InfoContentView(
                            title: "title:",
                            content: i['content'],
                            contentStyle: txtBold(14),
                          ),
                          InfoContentView(
                            title: "title:",
                            content: i['content'],
                            contentStyle: txtBold(14),
                          ),
                          InfoContentView(
                            title: "title",
                            content: i['content'],
                            contentStyle: txtBold(14),
                          ),
                        ];

                        return PrimaryCard(
                          onTap: () {},
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              vpad(12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Table(
                                  textBaseline: TextBaseline.ideographic,
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.baseline,
                                  columnWidths: const {
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(3)
                                  },
                                  children: [
                                    ...listContent.map<TableRow>((i) {
                                      return TableRow(
                                        children: [
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 16,
                                              ),
                                              child: Text(
                                                i.title,
                                                style: txtMedium(
                                                  12,
                                                  grayScaleColor2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              i.content ?? "",
                                              style: i.contentStyle,
                                            ),
                                          )
                                        ],
                                      );
                                    })
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      vpad(40),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
