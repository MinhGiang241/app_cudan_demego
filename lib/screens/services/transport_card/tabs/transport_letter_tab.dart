// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:app_cudan/screens/services/transport_card/prv/transport_card_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../models/transportation_card.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_loading.dart';
import '../../../auth/prv/resident_info_prv.dart';
import '../add_new_transport_card.dart';
import '../transport_letter_details_screen.dart';

class TransportLetterTab extends StatefulWidget {
  TransportLetterTab({super.key});

  @override
  State<TransportLetterTab> createState() => _TransportLetterTabState();
}

class _TransportLetterTabState extends State<TransportLetterTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<TransportCardPrv>().getTransportLetterList(context),
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

        var letterList = context.watch<TransportCardPrv>().letterList;
        List<TransportCard> newLetter = [];
        List<TransportCard> approvedLetter = [];
        List<TransportCard> waitLetter = [];
        List<TransportCard> cancelLetter = [];
        for (var i in letterList) {
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

        List<TransportCard> list =
            newLetter + waitLetter + approvedLetter + cancelLetter;

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
              emptyText: S.of(context).no_letter,
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
                      title: S.of(context).letter_num,
                      content: list[index].code,
                      contentStyle: txtBold(16, primaryColor1),
                    ),
                    InfoContentView(
                      title: S.of(context).full_name,
                      content: list[index].name_resident ??
                          list[index].name ??
                          list[index].re?.info_name ??
                          context.read<ResidentInfoPrv>().userInfo?.info_name ??
                          context
                              .read<ResidentInfoPrv>()
                              .userInfo
                              ?.account
                              ?.fullName ??
                          "",
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
                          .transports_list
                          ?.map((o) => o.vehicleType?.name)
                          .join("/ "),
                      contentStyle: txtBold(
                        12,
                        genStatusColor(
                          list[index].s?.name ?? "",
                        ),
                      ),
                    ),
                    InfoContentView(
                      title: S.of(context).status,
                      content: genStatus(list[index].ticket_status ?? ''),
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
                          TransportLetterDetailsScreen.routeName,
                          arguments: {
                            "card": list[index],
                            "sendRequest":
                                context.read<TransportCardPrv>().sendApprove,
                            "cancel":
                                context.read<TransportCardPrv>().cancelLetter
                          },
                        );
                      },
                      child: Column(
                        children: [
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 10, vertical: 4),
                          //     decoration: BoxDecoration(
                          //         color: cardList[index].card_status ==
                          //                 "ACTIVE"
                          //             ? greenColorBase
                          //             : pinkColorBase,
                          //         borderRadius: const BorderRadius.only(
                          //             topRight: Radius.circular(12),
                          //             bottomLeft: Radius.circular(8))),
                          //     child: Text(
                          //       cardList[index].card_status == "ACTIVE"
                          //           ? S.of(context).active
                          //           : S.of(context).lock,
                          //       style: txtSemiBold(12, Colors.white),
                          //     ),
                          //   ),
                          // ),
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
                                  onTap: () {
                                    context
                                        .read<TransportCardPrv>()
                                        .cancelLetter(context, list[index]);
                                  },
                                ),
                              ],
                            ),
                          if (list[index].ticket_status == "NEW")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                PrimaryButton(
                                  buttonSize: ButtonSize.xsmall,
                                  buttonType: ButtonType.secondary,
                                  secondaryBackgroundColor: greenColor7,
                                  text: S.of(context).send_request,
                                  textColor: greenColor8,
                                  onTap: () {
                                    context
                                        .read<TransportCardPrv>()
                                        .sendApprove(context, list[index]);
                                    // sendRequest(list[index]);
                                  },
                                ),
                                PrimaryButton(
                                  buttonSize: ButtonSize.xsmall,
                                  buttonType: ButtonType.secondary,
                                  secondaryBackgroundColor: primaryColor5,
                                  text: S.of(context).edit,
                                  textColor: primaryColor1,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AddNewTransportCardScreen.routeName,
                                      arguments: {
                                        "isEdit": true,
                                        "data": list[index],
                                      },
                                    );
                                  },
                                ),
                                PrimaryButton(
                                  buttonSize: ButtonSize.xsmall,
                                  buttonType: ButtonType.secondary,
                                  secondaryBackgroundColor: redColor4,
                                  textColor: redColor,
                                  text: S.of(context).delete,
                                  onTap: () {
                                    // return deleteLetter(list[index]);
                                    context
                                        .read<TransportCardPrv>()
                                        .deleteLetter(context, list[index]);
                                  },
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
              vpad(60)
            ],
          ),
        );
      },
    );
  }
}
