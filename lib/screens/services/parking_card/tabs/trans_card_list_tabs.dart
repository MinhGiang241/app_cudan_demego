import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../constants/constants.dart';
import '../../../../../models/info_content_view.dart';
import '../../../../../models/transportation_card.dart';
import '../../../../generated/l10n.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_loading.dart';

class TransportationCardListTab extends StatelessWidget {
  TransportationCardListTab({
    super.key,
    required this.cardList,
    this.residentId,
  });
  final List<TransportationCard> cardList;
  String? residentId;

  @override
  Widget build(BuildContext context) {
    return (cardList.isEmpty)
        ? PrimaryEmptyWidget(
            emptyText: S.of(context).no_trans_card,
            buttonText: S.of(context).add_trans_card,
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
                        ...cardList.map(
                          (e) => InfoContentView(
                              title: "test",
                              content: "reee",
                              contentStyle: txtBold(16, primaryColor1)),
                        )
                      ];
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 16),
                        child: PrimaryCard(
                          onTap: () {},
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: const BoxDecoration(
                                      color: greenColorBase,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(8))),
                                  child: Text(
                                    "dddd",
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
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
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
                ],
              ),
            ),
          ]);
  }
}
