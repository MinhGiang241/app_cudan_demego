// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:app_cudan/screens/services/delivery/package_details_screen.dart';
import 'package:app_cudan/screens/services/delivery/provider/delivery_list_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/delivery.dart';
import '../../../../models/info_content_view.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_loading.dart';

class WaitConfirmLetterTab extends StatefulWidget {
  const WaitConfirmLetterTab({super.key});

  @override
  State<WaitConfirmLetterTab> createState() => _WaitConfirmLetterTabState();
}

class _WaitConfirmLetterTabState extends State<WaitConfirmLetterTab> {
  @override
  Widget build(BuildContext context) {
    final RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    return FutureBuilder(
      future: context.read<DeliveryListPrv>().getWaitConfirmLetter(context),
      builder: (context, snapshot) {
        List<Delivery> newLetter = [];
        List<Delivery> approvedLetter = [];
        List<Delivery> waitOwnerLetter = [];
        List<Delivery> waitManagerLetter = [];
        List<Delivery> cancelLetter = [];
        for (var i in context.read<DeliveryListPrv>().listWaitItems) {
          if (i.status == "NEW") {
            newLetter.add(i);
          } else if (i.status == "APPROVED") {
            approvedLetter.add(i);
          } else if (i.status == "WAIT_OWNER") {
            waitOwnerLetter.add(i);
          } else if (i.status == "WAIT_MANAGER") {
            waitManagerLetter.add(i);
          } else if (i.status == "CANCEL") {
            cancelLetter.add(i);
          }
        }
        newLetter.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        approvedLetter.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        waitOwnerLetter
            .sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        waitManagerLetter
            .sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        cancelLetter.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));

        List<Delivery> list = newLetter +
            waitOwnerLetter +
            waitManagerLetter +
            approvedLetter +
            cancelLetter;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: PrimaryLoading());
        } else if (snapshot.connectionState == ConnectionState.none) {
          return PrimaryErrorWidget(
            code: snapshot.hasError ? "err" : "1",
            message: snapshot.data.toString(),
            onRetry: () async {
              setState(() {});
            },
          );
        } else if (list.isEmpty) {
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
            child: PrimaryEmptyWidget(
              emptyText: S.of(context).no_delivery,
              // buttonText: S.of(context).add_trans_card,
              icons: PrimaryIcons.box,
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
              ...list.map(
                (e) {
                  var listContent = [
                    InfoContentView(
                      title: "${S.of(context).letter_num}:",
                      content: e.code,
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      title: "${S.of(context).package}:",
                      content:
                          e.item_added_list!.map((x) => x.item_name).join(', '),
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      title: "${S.of(context).start_time}:",
                      content:
                          '${(e.start_hour != null ? "${e.start_hour!.substring(0, 5)} " : "")}${Utils.dateFormat(e.start_time ?? "", 1)}',
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      title: "${S.of(context).end_time}:",
                      content:
                          '${(e.end_hour != null ? "${e.end_hour!.substring(0, 5)} " : "")}${Utils.dateFormat(e.end_time ?? "", 1)}',
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      title: "${S.of(context).status}:",
                      content: e.status == "WAIT_MANAGER"
                          ? S.of(context).wait_approve
                          : e.s?.name ?? '',
                      contentStyle: txtBold(
                        14,
                        genStatusColor(
                          e.status == "WAIT_MANAGER" ? "WAIT" : e.status ?? '',
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
                        Navigator.pushNamed(
                          context,
                          PackageDetailScreen.routeName,
                          arguments: {
                            "card": e,
                            "isOwner": true,
                            "accept":
                                context.read<DeliveryListPrv>().acceptLetter,
                            "refuse":
                                context.read<DeliveryListPrv>().refuseLetter
                          },
                        );
                      },
                      child: Column(
                        children: [
                          vpad(12),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                e.type_transfer == 'IN'
                                    ? S.of(context).tranfer_in_reg
                                    : S.of(context).tranfer_out_reg,
                                textAlign: TextAlign.right,
                                style: txtMedium(12, grayScaleColor2),
                              ),
                            ),
                          ),
                          vpad(12),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Table(
                              textBaseline: TextBaseline.ideographic,
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.baseline,
                              columnWidths: const {
                                0: FlexColumnWidth(9),
                                1: FlexColumnWidth(12)
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
                                          i.content ?? "",
                                          style: i.contentStyle,
                                        ),
                                      )
                                    ],
                                  );
                                })
                              ],
                            ),
                          ),
                          if (e.status == "WAIT_OWNER") vpad(12),
                          if (e.status == "WAIT_OWNER")
                            Row(
                              children: [
                                hpad(16),
                                PrimaryButton(
                                  onTap: () {
                                    context
                                        .read<DeliveryListPrv>()
                                        .refuseLetter(
                                          context,
                                          e,
                                        );
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
                                        .read<DeliveryListPrv>()
                                        .acceptLetter(
                                          context,
                                          e,
                                        );
                                  },
                                  text: S.of(context).confirm,
                                  buttonSize: ButtonSize.xsmall,
                                  buttonType: ButtonType.secondary,
                                  secondaryBackgroundColor: greenColor7,
                                  textColor: greenColor8,
                                )
                              ],
                            ),
                          vpad(16),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
