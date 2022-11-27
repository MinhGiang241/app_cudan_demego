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
    return (cardList.isEmpty)
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
                      cardList.length,
                      (index) {
                        var listContent = [
                          InfoContentView(
                            title: S.of(context).card_num,
                            content: cardList[index].code,
                            contentStyle: txtBold(16, primaryColor1),
                          ),
                          InfoContentView(
                            title: S.of(context).full_name,
                            content: cardList[index].resident != null
                                ? cardList[index].resident!.info_name != null
                                    ? cardList[index]
                                        .resident!
                                        .info_name!
                                        .toUpperCase()
                                    : ''
                                : "",
                            contentStyle: txtBold(16, grayScaleColorBase),
                          ),
                          InfoContentView(
                            title: S.of(context).apartment,
                            content: cardList[index].apartment != null
                                ? "${cardList[index].apartment!.name}, ${cardList[index].floor!.name}, ${cardList[index].building!.name}"
                                : "",
                            contentStyle: txtBold(16, grayScaleColorBase),
                          ),
                          InfoContentView(
                            title: S.of(context).status,
                            content:
                                genStatus(cardList[index].ticket_status ?? ''),
                            contentStyle: txtBold(
                                14,
                                genStatusColor(
                                    cardList[index].ticket_status ?? '')),
                          ),
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 16),
                          child: PrimaryCard(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ResidentCardDetails.routeName,
                                arguments: cardList[index],
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
                                if (cardList[index].ticket_status == "WAIT")
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
                                            cancelRegister(cardList[index]),
                                      ),
                                    ],
                                  ),
                                if (cardList[index].ticket_status == "NEW")
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      PrimaryButton(
                                        buttonSize: ButtonSize.xsmall,
                                        buttonType: ButtonType.secondary,
                                        secondaryBackgroundColor: greenColor4,
                                        text: S.of(context).send_request,
                                        textColor: greenColor1,
                                        onTap: () =>
                                            sendRequest(cardList[index]),
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
                                                "data": cardList[index]
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
                                          cardList[index].id!,
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
