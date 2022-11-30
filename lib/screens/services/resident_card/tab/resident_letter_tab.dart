import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../models/resident_card.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../register_resident_card.dart';
import '../resident_card_details.dart';

class ResidentLetterTab extends StatelessWidget {
  ResidentLetterTab({
    super.key,
    required this.cardList,
    this.residentId,
    required this.cancelRegister,
    required this.sendRequest,
    required this.edit,
    required this.deleteLetter,
  });

  final List<ResidentCard> cardList;
  String? residentId;
  Function(ResidentCard) cancelRegister;
  Function(ResidentCard) sendRequest;
  Function() edit;
  Function(String) deleteLetter;

  @override
  Widget build(BuildContext context) {
    var newLetter = [];
    var approvedLetter = [];
    var waitLetter = [];
    var cancelLetter = [];
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

    var list = newLetter + approvedLetter + waitLetter + cancelLetter;
    return (list.isEmpty)
        ? PrimaryEmptyWidget(
            emptyText: S.of(context).no_letter,
            icons: PrimaryIcons.identity_bg,
            action: () {
              // Utils.pushScreen(context, const RegisterParkingCard());
            },
          )
        : Stack(
            children: [
              SafeArea(
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
                            contentStyle: txtBold(16, primaryColor1),
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
                            contentStyle: txtBold(16, grayScaleColorBase),
                          ),
                          InfoContentView(
                            title: S.of(context).apartment,
                            content: list[index].apartment != null
                                ? "${list[index].apartment!.name}, ${list[index].floor!.name}, ${list[index].building!.name}"
                                : "",
                            contentStyle: txtBold(16, grayScaleColorBase),
                          ),
                          InfoContentView(
                            title: S.of(context).status,
                            content: genStatus(list[index].ticket_status ?? ''),
                            contentStyle: txtBold(
                                14,
                                genStatusColor(
                                    list[index].ticket_status ?? '')),
                          ),
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 16),
                          child: PrimaryCard(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ResidentCardDetails.routeName,
                                arguments: {"card": list[index]},
                              );
                            },
                            child: Column(
                              children: [
                                vpad(16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Table(
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
                                              style: txtMedium(
                                                  12, grayScaleColor2),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: Text(e.content ?? "",
                                                  style: e.contentStyle),
                                            )
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
                                      PrimaryButton(
                                        buttonSize: ButtonSize.xsmall,
                                        buttonType: ButtonType.secondary,
                                        secondaryBackgroundColor: greenColor7,
                                        text: S.of(context).send_request,
                                        textColor: greenColor8,
                                        onTap: () => sendRequest(list[index]),
                                      ),
                                      PrimaryButton(
                                        buttonSize: ButtonSize.xsmall,
                                        buttonType: ButtonType.secondary,
                                        secondaryBackgroundColor: primaryColor5,
                                        text: S.of(context).edit,
                                        textColor: primaryColor1,
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RegisterResidentCard.routeName,
                                              arguments: {
                                                "isEdit": true,
                                                "data": list[index]
                                              });
                                        },
                                      ),
                                      PrimaryButton(
                                        buttonSize: ButtonSize.xsmall,
                                        buttonType: ButtonType.secondary,
                                        secondaryBackgroundColor: redColor4,
                                        textColor: redColor,
                                        text: S.of(context).delete_letter,
                                        onTap: () => deleteLetter(
                                          list[index].id!,
                                        ),
                                      ),
                                    ],
                                  ),
                                vpad(12)
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
            ],
          );
  }
}
