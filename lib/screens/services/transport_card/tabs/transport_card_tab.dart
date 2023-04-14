import 'package:app_cudan/screens/services/transport_card/manage_card_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../models/manage_card.dart';
import '../../../../models/transportation_card.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_loading.dart';
import '../../../auth/prv/resident_info_prv.dart';
import '../prv/transport_card_prv.dart';
import '../transport_letter_details_screen.dart';

class TransportCardTab extends StatefulWidget {
  const TransportCardTab({super.key});

  @override
  State<TransportCardTab> createState() => _TransportCardTabState();
}

class _TransportCardTabState extends State<TransportCardTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<TransportCardPrv>().getTransportCardList(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: PrimaryLoading());
        } else if (snapshot.connectionState == ConnectionState.none) {
          return PrimaryErrorWidget(
            code: snapshot.hasError ? "err" : "1",
            message: snapshot.data.toString(),
            onRetry: () async {
              // await context.read<ParkingCardProvider>().getTrasportCardList(
              //     context,
              //     context.read<ResidentInfoPrv>().residentId ?? '');
            },
          );
        }

        var cardList = context.watch<TransportCardPrv>().cardList;
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

        List<ManageCard> list = active + inActive + lock + lost + destroy;

        if (list.isEmpty) {
          return SmartRefresher(
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
              setState(() {});
              _refreshController.refreshCompleted();
            },
            child: PrimaryEmptyWidget(
              emptyText: S.of(context).no_card,
              icons: PrimaryIcons.car,
              action: () {
                // Utils.pushScreen(context, const RegisterParkingCard());
              },
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
            setState(() {});
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
                      title: S.of(context).card_num,
                      content: list[index].serial_lot,
                      contentStyle: txtBold(16, primaryColor1),
                    ),
                    InfoContentView(
                      title: S.of(context).full_name,
                      content: context
                                  .watch<ResidentInfoPrv>()
                                  .userInfo!
                                  .info_name !=
                              null
                          ? context
                              .watch<ResidentInfoPrv>()
                              .userInfo!
                              .info_name!
                              .toUpperCase()
                          : '',
                      contentStyle: txtBold(14),
                    ),
                    // InfoContentView(
                    //   title: S.of(context).transportation,
                    //   content: list[index].vehicleType?.name ?? '',
                    //   contentStyle: txtBold(14),
                    // ),
                    // if (list[index].type != "BICYCLE")
                    //   InfoContentView(
                    //     title: S.of(context).licene_plate,
                    //     content: list[index].number_plate,
                    //     contentStyle: txtBold(14),
                    //   ),
                    InfoContentView(
                      title: S.of(context).transport,
                      content: list[index]
                          .t
                          ?.transports_list
                          ?.map((o) => o.vehicleType?.name)
                          .join(", "),
                      contentStyle: txtBold(
                        14,
                        genStatusColor(
                          list[index].s?.name ?? "",
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
                          ManageCardDetailsScreen.routeName,
                          arguments: {
                            "card": list[index],
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
                                color: genStatusColor(list[index].status ?? ""),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              child: Text(
                                // list[index].card_status == "ACTIVE"
                                //     ? S.of(context).active
                                //     :
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
                                1: FlexColumnWidth(3)
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
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (list[index].status != "OST")
                            Row(
                              children: [
                                hpad(12),
                                PrimaryButton(
                                  buttonSize: ButtonSize.small,
                                  buttonType: ButtonType.secondary,
                                  secondaryBackgroundColor: primaryColor5,
                                  textColor: primaryColor1,
                                  text: S.of(context).report_lost,
                                  onTap: () {
                                    context
                                        .read<TransportCardPrv>()
                                        .missingReport(context, list[index]);
                                    // return cancelRegister(list[index]);
                                  },
                                ),
                              ],
                            ),
                          // if (list[index].status == "NEW")
                          //   Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     children: [
                          //       PrimaryButton(
                          //         buttonSize: ButtonSize.xsmall,
                          //         buttonType: ButtonType.secondary,
                          //         secondaryBackgroundColor: greenColor7,
                          //         text: S.of(context).send_request,
                          //         textColor: greenColor8,
                          //         onTap: () {
                          //           // sendRequest(list[index]);
                          //         },
                          //       ),
                          //       PrimaryButton(
                          //         buttonSize: ButtonSize.xsmall,
                          //         buttonType: ButtonType.secondary,
                          //         secondaryBackgroundColor: primaryColor5,
                          //         text: S.of(context).edit,
                          //         textColor: primaryColor1,
                          //         onTap: () {
                          //           //   Navigator.pushNamed(
                          //           //       context,
                          //           //       RegisterTransportationCard
                          //           //           .routeName,
                          //           //       arguments: {
                          //           //         "isEdit": true,
                          //           //         "data": list[index]
                          //           //       },);
                          //         },
                          //       ),
                          //       PrimaryButton(
                          //         buttonSize: ButtonSize.xsmall,
                          //         buttonType: ButtonType.secondary,
                          //         secondaryBackgroundColor: redColor4,
                          //         textColor: redColor,
                          //         text: S.of(context).delete_letter,
                          //         onTap: () {
                          //           // return deleteLetter(list[index]);
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          vpad(12)
                        ],
                      ),
                    ),
                  );
                },
              ),
              vpad(60)
            ],
          ),
        );
      },
    );
  }
}
