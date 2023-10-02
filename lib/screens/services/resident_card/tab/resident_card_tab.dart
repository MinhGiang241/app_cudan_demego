import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../models/manage_card.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../resident_card_details.dart';

// ignore: must_be_immutable
class ResidentCardTab extends StatelessWidget {
  ResidentCardTab({
    super.key,
    required this.cardList,
    this.residentId,
    required this.extend,
    required this.missingReport,
    required this.cancel,
    required this.onRefresh,
  });

  final List<ManageCard> cardList;
  String? residentId;
  Function() extend;
  Function missingReport;
  Function cancel;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    List<ManageCard> active = [];
    List<ManageCard> inActive = [];
    List<ManageCard> lock = [];
    List<ManageCard> lost = [];
    List<ManageCard> destroy = [];
    for (var i in cardList) {
      if (i.status == "ACTIVED") {
        active.add(i);
      } else if (i.status == "INACTIVED") {
        inActive.add(i);
      } else if (i.status == "LOCK") {
        lock.add(i);
      } else if (i.status == "LOST") {
        lost.add(i);
      } else if (i.status == "DESTROY") {
        destroy.add(i);
      }
    }

    active.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
    inActive.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
    lock.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
    lost.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
    destroy.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));

    List<ManageCard> list = active + lock + destroy + lost + inActive;

    return (list.isEmpty)
        ? SafeArea(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              controller: _refreshController,
              onLoading: () {
                _refreshController.loadComplete();
                // _refreshController.refreshCompleted();
              },
              onRefresh: () {
                onRefresh();
                _refreshController.refreshCompleted();
              },
              child: PrimaryEmptyWidget(
                emptyText: S.of(context).no_card,
                icons: PrimaryIcons.identity_bg,
                action: () {
                  // Utils.pushScreen(context, const RegisterParkingCard());
                },
              ),
            ),
          )
        : Stack(
            children: [
              SafeArea(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropMaterialHeader(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  controller: _refreshController,
                  onLoading: () {
                    _refreshController.loadComplete();
                    // _refreshController.refreshCompleted();
                  },
                  onRefresh: () {
                    onRefresh();
                    _refreshController.refreshCompleted();
                  },
                  child: ListView(
                    children: [
                      vpad(24),
                      ...List.generate(list.length, (index) {
                        var listContent = [
                          InfoContentView(
                            title: S.of(context).card_num,
                            content: list[index].as?.serial,
                            contentStyle: txtBold(14, primaryColor1),
                          ),
                          InfoContentView(
                            title: S.of(context).full_name,
                            content: list[index].re != null
                                ? list[index].re!.info_name != null
                                    ? list[index].re!.info_name!.toUpperCase()
                                    : ''
                                : "",
                            contentStyle: txtBold(14),
                          ),
                          InfoContentView(
                            title: S.of(context).address,
                            content: list[index].res_card?.apartment != null
                                ? "${list[index].res_card?.apartment!.name ?? ""}, ${list[index].res_card?.apartment?.f?.name ?? ""}, ${list[index].res_card?.apartment?.b?.name}"
                                : "",
                            contentStyle: txtBold(12),
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
                              Navigator.of(context).pushNamed(
                                ResidentCardDetails.routeName,
                                arguments: {
                                  "card": list[index],
                                  "lockCard": cancel,
                                },
                              );
                            },
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: genStatusColor(
                                        list[index].status ?? "",
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      list[index].s?.name ?? "",
                                      style: txtSemiBold(12, Colors.white),
                                    ),
                                  ),
                                ),
                                vpad(16),
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
                                      1: FlexColumnWidth(3),
                                    },
                                    children: [
                                      ...listContent.map<TableRow>(
                                        (e) => TableRow(
                                          children: [
                                            Text(
                                              '${e.title}:',
                                              style: txtMedium(
                                                12,
                                                grayScaleColor2,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 16,
                                              ),
                                              child: Text(
                                                e.content ?? "",
                                                style: e.contentStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // if (
                                //     (list[index].status != "LOST" &&
                                //         list[index].status != "INACTIVE"))
                                //   Row(
                                //     children: [
                                //       hpad(12),
                                //       PrimaryButton(
                                //         buttonSize: ButtonSize.xsmall,
                                //         buttonType: ButtonType.secondary,
                                //         secondaryBackgroundColor: primaryColor5,
                                //         text: S.of(context).missing_report,
                                //         textColor: primaryColor1,
                                //         onTap: () {
                                //           missingReport(context, list[index]);
                                //         },
                                //       ),
                                //     ],
                                //   ),
                                vpad(12),
                              ],
                            ),
                          ),
                        );
                      }),
                      vpad(60),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
