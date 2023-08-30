import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/models/construction.dart';
import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_loading.dart';
import '../construction_extend_screen.dart';
import '../prv/construction_list_prv.dart';

class ConstructionExtendWaitTab extends StatefulWidget {
  const ConstructionExtendWaitTab({
    super.key,
    required this.getList,
    required this.list,
  });

  final List<ConstructionExtension> list;
  final Function(BuildContext) getList;

  @override
  State<ConstructionExtendWaitTab> createState() =>
      _ConstructionExtendWaitTabState();
}

class _ConstructionExtendWaitTabState extends State<ConstructionExtendWaitTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.getList(context),
      builder: (context, snapshot) {
        List<ConstructionExtension> waitOwnerLetter = [];
        List<ConstructionExtension> waitTechLetter = [];
        List<ConstructionExtension> waitManagerLetter = [];
        List<ConstructionExtension> approvedLetter = [];
        List<ConstructionExtension> cancelLetter = [];
        for (var i in widget.list) {
          if (i.status == "WAIT_OWNER") {
            waitOwnerLetter.add(i);
          }
          if (i.status == "WAIT_TECHNICAL") {
            waitTechLetter.add(i);
          }
          if (i.status == "WAIT_MANAGER") {
            waitTechLetter.add(i);
          }
          if (i.status == 'APPROVED') {
            approvedLetter.add(i);
          }
          if (i.status == 'CANCEL') {
            cancelLetter.add(i);
          }
        }
        waitOwnerLetter
            .sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        waitTechLetter.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        waitManagerLetter
            .sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        approvedLetter.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        cancelLetter.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        var list = waitOwnerLetter +
            waitTechLetter +
            waitManagerLetter +
            approvedLetter +
            cancelLetter;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: PrimaryLoading());
        } else if (snapshot.connectionState == ConnectionState.none) {
          return PrimaryErrorWidget(
            code: snapshot.hasError ? 'err' : '1',
            message: snapshot.data.toString(),
            onRetry: () async {
              setState(() {});
            },
          );
        } else if (list.isEmpty) {
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
                emptyText: S.of(context).no_extend_letter,
                icons: PrimaryIcons.wrench,
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
                      title: "${S.of(context).code_file}: ",
                      content: e.d?.code ?? '',
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      title: "${S.of(context).letter_num}: ",
                      content: e.code ?? '',
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      title: "${S.of(context).start_date_extend}: ",
                      content: Utils.dateFormat(e.time_start ?? '', 1),
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      title: '${S.of(context).end_date_extend}: ',
                      content: Utils.dateFormat(e.time_end ?? '', 1),
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      title: '${S.of(context).letter_status}: ',
                      content: (e.status == 'WAIT_TECHNICAL' ||
                              e.status == 'WAIT_MANAGER' ||
                              e.status == "WAIT_OWNER")
                          ? S.of(context).wait_approve
                          : (e.s!.name ?? ''),
                      contentStyle: txtBold(
                        14,
                        (e.status == 'WAIT_TECHNICAL' ||
                                e.status == 'WAIT_MANAGER' ||
                                e.status == "WAIT_OWNER")
                            ? greenColor9
                            : genStatusColor(e.status ?? ''),
                      ),
                    ),
                  ];

                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 16),
                    child: PrimaryCard(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ConstructionExtendScreen.routeName,
                          arguments: {
                            'edit': false,
                            'letter': e,
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
                                        e.t?.name ?? '',
                                        style: txtBold(
                                          14,
                                          grayScaleColorBase,
                                        ),
                                      ),
                                      vpad(4),
                                      Wrap(
                                        children: [
                                          Text(
                                            '${S.of(context).reg_date}: ',
                                            style: txtMedium(
                                              12,
                                              grayScaleColor2,
                                            ),
                                          ),
                                          Text(
                                            Utils.dateTimeFormat(
                                              e.createdTime ?? '',
                                              1,
                                            ),
                                            style: txtMedium(
                                              12,
                                              greenColorBase,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: grayScaleColor4, height: 2),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Table(
                              textBaseline: TextBaseline.ideographic,
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.baseline,
                              columnWidths: const {
                                0: FlexColumnWidth(5),
                                1: FlexColumnWidth(4),
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
                                          i.content ?? '',
                                          style: i.contentStyle,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              hpad(10),
                              PrimaryButton(
                                onTap: () {
                                  context
                                      .read<ConstructionListPrv>()
                                      .changeStatus(context, false, e);
                                },
                                text: S.of(context).refuse,
                                buttonSize: ButtonSize.xsmall,
                                buttonType: ButtonType.secondary,
                                secondaryBackgroundColor: redColor5,
                                textColor: redColorBase,
                              ),
                              hpad(10),
                              PrimaryButton(
                                onTap: () {
                                  context
                                      .read<ConstructionListPrv>()
                                      .changeStatus(context, true, e);
                                },
                                text: S.of(context).confirm,
                                buttonSize: ButtonSize.xsmall,
                                buttonType: ButtonType.secondary,
                                secondaryBackgroundColor: greenColor7,
                                textColor: greenColor8,
                              ),
                            ],
                          ),
                          vpad(16),
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
