import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/resident_card/prv/resident_card_prv.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/constants.dart';
import '../../../../../models/info_content_view.dart';
import '../../../../../models/transportation_card.dart';
import '../../../../generated/l10n.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_loading.dart';
import '../transportation_details_screen.dart';

class TransportationCardListTab extends StatelessWidget {
  TransportationCardListTab({
    super.key,
    required this.cardList,
    this.residentId,
    required this.extend,
    required this.lockCard,
    required this.missingReport,
  });
  final List<TransportationCard> cardList;
  String? residentId;
  Function() extend;
  Function() missingReport;
  Function(String) lockCard;

  @override
  Widget build(BuildContext context) {
    return (cardList.isEmpty)
        ? PrimaryEmptyWidget(
            emptyText: S.of(context).no_trans_card,
            // buttonText: S.of(context).add_trans_card,
            icons: PrimaryIcons.car,
            action: () {
              // Utils.pushScreen(context, const RegisterParkingCard());
            },
          )
        : Stack(children: [
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
                          content: context
                                      .read<ResidentInfoPrv>()
                                      .userInfo!
                                      .info_name !=
                                  null
                              ? context
                                  .read<ResidentInfoPrv>()
                                  .userInfo!
                                  .info_name!
                                  .toUpperCase()
                              : '',
                          contentStyle: txtBold(14),
                        ),
                        InfoContentView(
                          title: S.of(context).transportation,
                          content: cardList[index].vehicleType?.name ?? '',
                          contentStyle: txtBold(14),
                        ),
                        InfoContentView(
                          title: S.of(context).licene_plate,
                          content: cardList[index].number_plate,
                          contentStyle: txtBold(14),
                        ),
                      ];
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 16),
                        child: PrimaryCard(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              TransportationCardDetails.routeName,
                              arguments: cardList[index],
                            );
                          },
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: cardList[index].card_status ==
                                              "ACTIVE"
                                          ? greenColorBase
                                          : redColor2,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(8))),
                                  child: Text(
                                    cardList[index].card_status == "ACTIVE"
                                        ? S.of(context).active
                                        : S.of(context).lock,
                                    style: txtSemiBold(12, Colors.white),
                                  ),
                                ),
                              ),
                              vpad(16),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                            style:
                                                txtMedium(12, grayScaleColor2),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16),
                                            child: Text(e.content ?? "",
                                                style: e.contentStyle),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if (cardList[index].card_status == "ACTIVE")
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                      onTap: () =>
                                          lockCard(cardList[index].id!),
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
                  // ...listContent.map((e) => Table(
                  //       columnWidths: const {
                  //         0: FlexColumnWidth(2),
                  //         1: FlexColumnWidth(3)
                  //       },
                  //       children: [
                  //         TableRow(children: [
                  //           Text('sasa'),
                  //           Text('sasa'),
                  //         ])
                  //       ],
                  //     ))
                  vpad(60)
                ],
              ),
            ),
          ]);
  }
}
