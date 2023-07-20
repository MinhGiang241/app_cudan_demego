import 'package:app_cudan/models/construction.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_loading.dart';
import '../construction_doc_details_screen.dart';

// ignore: must_be_immutable
class ConstructionFileTab extends StatefulWidget {
  ConstructionFileTab({super.key, required this.getList, required this.list});
  List<ConstructionDocument> list = [];
  Function(BuildContext) getList;

  @override
  State<ConstructionFileTab> createState() => _ConstructionFileTabState();
}

class _ConstructionFileTabState extends State<ConstructionFileTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.getList(context),
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
        } else if (widget.list.isEmpty) {
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
                emptyText: S.of(context).no_cons_file,
                icons: PrimaryIcons.wrench,
                action: () {},
              ),
            ),
          );
        }
        List<ConstructionDocument> waitCons = [];
        List<ConstructionDocument> underCons = [];
        List<ConstructionDocument> pauseCons = [];
        List<ConstructionDocument> waitAcc = [];
        List<ConstructionDocument> underAcc = [];
        List<ConstructionDocument> complete = [];
        for (var i in widget.list) {
          if (i.status == "WAIT_CONSTRUCTION") {
            waitCons.add(i);
          } else if (i.status == "UNDER_CONSTRUCTION") {
            underCons.add(i);
          } else if (i.status == "PAUSE_CONSTRUCTION") {
            pauseCons.add(i);
          } else if (i.status == "WAIT_ACCEPTANCE") {
            waitAcc.add(i);
          } else if (i.status == "UNDER_ACCEPTANCE") {
            underAcc.add(i);
          } else if (i.status == "COMPLETE") {
            complete.add(i);
          }
        }

        waitCons.sort((a, b) => b.createdTime!.compareTo(a.createdTime!));
        underCons.sort((a, b) => b.createdTime!.compareTo(a.createdTime!));
        pauseCons.sort((a, b) => b.createdTime!.compareTo(a.createdTime!));
        waitAcc.sort((a, b) => b.createdTime!.compareTo(a.createdTime!));
        underAcc.sort((a, b) => b.createdTime!.compareTo(a.createdTime!));
        complete.sort((a, b) => b.createdTime!.compareTo(a.createdTime!));

        List<ConstructionDocument> list =
            waitCons + underCons + pauseCons + waitAcc + underAcc + complete;
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
                  var listContent = [
                    InfoContentView(
                      title: "${S.of(context).code_file}:",
                      content: e.code,
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      title: "${S.of(context).file_status}:",
                      content: e.s!.name ?? "",
                      contentStyle: txtBold(14, genStatusColor(e.status ?? "")),
                    ),
                  ];
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 16,
                    ),
                    child: PrimaryCard(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ConstructionDocumentDetailsScreen.routeName,
                          arguments: {
                            "cons": e,
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              children: [
                                const PrimaryIcon(
                                  icons: PrimaryIcons.wrench,
                                  size: 28,
                                  padding: EdgeInsets.all(10),
                                  style: PrimaryIconStyle.round,
                                  backgroundColor: primaryColor5,
                                  color: primaryColor4,
                                ),
                                hpad(20),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.constructionType!.name ?? "",
                                        style: txtBold(14, grayScaleColorBase),
                                      ),
                                      vpad(4),
                                      Table(
                                        textBaseline: TextBaseline.ideographic,
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.baseline,
                                        columnWidths: const {
                                          0: FlexColumnWidth(4),
                                          1: FlexColumnWidth(5)
                                        },
                                        children: [
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Text(
                                                  '${S.of(context).reg_date}:',
                                                  style: txtMedium(
                                                    12,
                                                    grayScaleColor2,
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Text(
                                                  Utils.dateTimeFormat(
                                                    e.reg_date ?? "",
                                                    1,
                                                  ),
                                                  style: txtMedium(
                                                    12,
                                                    greenColorBase,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Text(
                                                  '${S.of(context).approved_date}:',
                                                  style: txtMedium(
                                                    12,
                                                    grayScaleColor2,
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Text(
                                                  Utils.dateTimeFormat(
                                                    e.createdTime ?? "",
                                                    1,
                                                  ),
                                                  style: txtMedium(
                                                    12,
                                                    greenColorBase,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(color: grayScaleColor4, height: 2),
                          vpad(12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Table(
                              textBaseline: TextBaseline.ideographic,
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.baseline,
                              columnWidths: const {
                                0: FlexColumnWidth(4),
                                1: FlexColumnWidth(6)
                              },
                              children: [
                                ...listContent.map<TableRow>((i) {
                                  return TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 16),
                                          child: Text(
                                            i.title,
                                            style:
                                                txtMedium(12, grayScaleColor2),
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
                          )
                        ],
                      ),
                    ),
                  );
                }),
                vpad(60),
              ],
            ),
          ),
        );
      },
    );
  }
}
