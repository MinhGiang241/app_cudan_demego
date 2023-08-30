import 'package:app_cudan/screens/services/resident_card/prv/resident_card_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../models/resident_card.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../register_resident_card.dart';
import '../resident_letter_details .dart';

// ignore: must_be_immutable
class ResidentLetterTab extends StatelessWidget {
  ResidentLetterTab({
    super.key,
    required this.cardList,
    this.residentId,
    required this.cancelRegister,
    required this.sendRequest,
    required this.edit,
    required this.deleteLetter,
    required this.onRefresh,
  });

  final List<ResidentCard> cardList;
  String? residentId;
  Function(ResidentCard) cancelRegister;
  Function(ResidentCard) sendRequest;
  Function() edit;
  Function(ResidentCard) deleteLetter;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    List<ResidentCard> newLetter = [];
    List<ResidentCard> approvedLetter = [];
    List<ResidentCard> waitLetter = [];
    List<ResidentCard> cancelLetter = [];
    for (var i in cardList) {
      if (i.ticket_status == "NEW") {
        newLetter.add(i);
      } else if (i.ticket_status == "APPROVED") {
        approvedLetter.add(i);
      } else if (i.ticket_status == "WAIT") {
        waitLetter.add(i);
      } else if (i.ticket_status == "CANCEL") {
        cancelLetter.add(i);
      }
    }

    newLetter.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
    approvedLetter.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
    waitLetter.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
    cancelLetter.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));

    List<ResidentCard> list =
        newLetter + waitLetter + approvedLetter + cancelLetter;
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
                emptyText: S.of(context).no_letter,
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
                  onRefresh: () {
                    onRefresh();
                    _refreshController.refreshCompleted();
                  },
                  child: ListView(
                    children: [
                      vpad(24),
                      ...List.generate(
                        list.length,
                        (index) {
                          var listContent = [
                            InfoContentView(
                              title: S.of(context).letter_num,
                              content: list[index].code,
                              contentStyle: txtBold(14, purpleColorBase),
                            ),
                            InfoContentView(
                              title: S.of(context).full_name,
                              content: list[index].resident != null
                                  ? list[index].resident!.info_name != null
                                      ? list[index]
                                          .resident!
                                          .info_name!
                                          .toUpperCase()
                                      : ''
                                  : "",
                              contentStyle: txtBold(14),
                            ),
                            InfoContentView(
                              title: S.of(context).address,
                              content: list[index].apartment != null
                                  ? "${list[index].apartment?.name ?? ""}, ${list[index].apartment?.f?.name ?? ""}, ${list[index].apartment?.b?.name ?? ""}"
                                  : "",
                              contentStyle: txtBold(12),
                            ),
                            InfoContentView(
                              title: S.of(context).status,
                              content: list[index].s?.name ?? "",
                              contentStyle: txtBold(
                                12,
                                genStatusColor(
                                  list[index].ticket_status ?? '',
                                ),
                              ),
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
                                  ResidentLetterDetails.routeName,
                                  arguments: {
                                    "card": list[index],
                                    'cancel': context
                                        .read<ResidentCardPrv>()
                                        .cancelLetter,
                                    'send': context
                                        .read<ResidentCardPrv>()
                                        .sendRequest,
                                  },
                                );
                              },
                              child: Column(
                                children: [
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
                                                "${e.title}:",
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
                                  if (list[index].ticket_status == "WAIT")
                                    Row(
                                      children: [
                                        hpad(12),
                                        PrimaryButton(
                                          buttonSize: ButtonSize.small,
                                          buttonType: ButtonType.secondary,
                                          secondaryBackgroundColor: redColor4,
                                          textColor: redColor,
                                          text: S.of(context).cancel_register,
                                          onTap: () =>
                                              cancelRegister(list[index]),
                                        ),
                                      ],
                                    ),
                                  if (list[index].ticket_status == "NEW")
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: PrimaryButton(
                                            buttonSize: ButtonSize.xsmall,
                                            buttonType: ButtonType.secondary,
                                            secondaryBackgroundColor:
                                                greenColor7,
                                            text: S.of(context).send_request,
                                            textColor: greenColor8,
                                            onTap: () =>
                                                sendRequest(list[index]),
                                          ),
                                        ),
                                        hpad(5),
                                        Expanded(
                                          child: PrimaryButton(
                                            buttonSize: ButtonSize.xsmall,
                                            buttonType: ButtonType.secondary,
                                            secondaryBackgroundColor:
                                                primaryColor5,
                                            text: S.of(context).edit,
                                            textColor: primaryColor1,
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                RegisterResidentCard.routeName,
                                                arguments: {
                                                  "isEdit": true,
                                                  "data": list[index],
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        hpad(5),
                                        Expanded(
                                          child: PrimaryButton(
                                            buttonSize: ButtonSize.xsmall,
                                            buttonType: ButtonType.secondary,
                                            secondaryBackgroundColor: redColor4,
                                            textColor: redColor,
                                            text: S.of(context).delete,
                                            onTap: () => deleteLetter(
                                              list[index],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  vpad(12),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      vpad(60),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
