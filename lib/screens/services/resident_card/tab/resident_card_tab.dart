import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../models/resident_card.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../resident_card_details.dart';

class ResidentCardTab extends StatelessWidget {
  ResidentCardTab({
    super.key,
    required this.cardList,
    this.residentId,
    required this.extend,
    required this.lockCard,
    required this.missingReport,
    required this.onRefresh,
  });

  final List<ResidentCard> cardList;
  String? residentId;
  Function() extend;
  Function() missingReport;
  Function(ResidentCard) lockCard;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    var activeCard = [];
    var inactiveCard = [];
    for (var i in cardList) {
      if (i.card_status == 'ACTIVE') {
        activeCard.add(i);
      } else {
        inactiveCard.add(i);
      }
    }

    activeCard.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
    inactiveCard.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));

    var list = activeCard + inactiveCard;

    return (list.isEmpty)
        ? PrimaryEmptyWidget(
            emptyText: S.of(context).no_card,
            icons: PrimaryIcons.identity_bg,
            action: () {
              // Utils.pushScreen(context, const RegisterParkingCard());
            },
          )
        : Stack(children: [
            SafeArea(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropMaterialHeader(
                    backgroundColor: Theme.of(context).primaryColor),
                controller: _refreshController,
                onRefresh: () {
                  onRefresh();
                  _refreshController.loadComplete();
                },
                child: ListView(children: [
                  vpad(24),
                  ...List.generate(list.length, (index) {
                    var listContent = [
                      InfoContentView(
                        title: S.of(context).card_num,
                        content: list[index].code,
                        contentStyle: txtBold(16, primaryColor1),
                      ),
                      InfoContentView(
                        title: S.of(context).full_name,
                        content: list[index].resident != null
                            ? list[index].resident!.info_name != null
                                ? list[index].resident!.info_name!.toUpperCase()
                                : ''
                            : "",
                        contentStyle: txtBold(16, grayScaleColorBase),
                      ),
                      InfoContentView(
                        title: S.of(context).apartment,
                        content: list[index].apartment != null
                            ? "${list[index].apartment!.name}, ${list[index].floor!.name}, ${list[index].building!.name}"
                            : "",
                        contentStyle: txtBold(16, grayScaleColorBase),
                      ),
                    ];

                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 16),
                      child: PrimaryCard(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ResidentCardDetails.routeName,
                            arguments: {
                              "card": list[index],
                              "lockCard": () => lockCard(list[index])
                            },
                          );
                        },
                        child: Column(children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                  color: list[index].card_status == "ACTIVE"
                                      ? greenColorBase
                                      : redColor2,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(8))),
                              child: Text(
                                list[index].card_status == "ACTIVE"
                                    ? S.of(context).active
                                    : S.of(context).lock,
                                style: txtSemiBold(12, Colors.white),
                              ),
                            ),
                          ),
                          vpad(16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Table(
                              textBaseline: TextBaseline.ideographic,
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.baseline,
                              columnWidths: const {
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(3)
                              },
                              children: [
                                ...listContent.map<TableRow>(
                                  (e) => TableRow(
                                    children: [
                                      Text(
                                        e.title,
                                        style: txtMedium(12, grayScaleColor2),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16),
                                        child: Text(e.content ?? "",
                                            style: e.contentStyle),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (list[index].card_status == "ACTIVE")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                PrimaryButton(
                                  buttonSize: ButtonSize.xsmall,
                                  buttonType: ButtonType.secondary,
                                  secondaryBackgroundColor: yellowColor4,
                                  text: S.of(context).extend,
                                  textColor: yellowColor1,
                                  onTap: () {},
                                ),
                                PrimaryButton(
                                  buttonSize: ButtonSize.xsmall,
                                  buttonType: ButtonType.secondary,
                                  secondaryBackgroundColor: primaryColor5,
                                  text: S.of(context).missing_report,
                                  textColor: primaryColor1,
                                  onTap: () {},
                                ),
                                PrimaryButton(
                                  buttonSize: ButtonSize.xsmall,
                                  buttonType: ButtonType.secondary,
                                  secondaryBackgroundColor: redColor4,
                                  textColor: redColor,
                                  text: S.of(context).lock_card,
                                  onTap: () => lockCard(list[index]),
                                ),
                              ],
                            ),
                          vpad(12)
                        ]),
                      ),
                    );
                  }),
                  vpad(60)
                ]),
              ),
            ),
          ]);
  }
}
