import 'package:app_cudan/models/missing_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_dropdown.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../loot_item_details_screen.dart';
import '../lost_item_details_screen.dart';
import '../prv/missing_object_prv.dart';
import '../prv/pick_item_prv.dart';

genLostStatus(String? status) {
  switch (status) {
    case "FOUND":
      return S.current.returned;
    case "NOTFOUND":
      return S.current.wait_return;
    default:
      return '';
  }
}

genLostStyle(String? status) {
  switch (status) {
    case "WAIT_RETURN":
      return txtBold(14, redColorBase);
    case "RETURNED":
      return txtBold(14, primaryColor6);
    default:
      return txtBold(14, grayScaleColorBase);
  }
}

class PickedItemTab extends StatefulWidget {
  PickedItemTab({
    super.key,
    required this.refreshController,
    required this.list,
    required this.onRefresh,
    required this.type,
    this.changeStatus,
  });
  List<LootItem> list = [];
  String type;

  Function() onRefresh;
  Function(BuildContext, LootItem)? changeStatus;

  RefreshController refreshController = RefreshController();

  @override
  State<PickedItemTab> createState() => _PickedItemTabState();
}

class _PickedItemTabState extends State<PickedItemTab> {
  @override
  Widget build(BuildContext context) {
    List<LootItem> waitList = [];
    List<LootItem> returnedList = [];

    for (var i in widget.list) {
      if (i.status == "WAIT_RETURN") {
        waitList.add(i);
      } else {
        returnedList.add(i);
      }
    }
    waitList.sort((a, b) => b.date!.compareTo(a.date ?? ""));
    returnedList.sort((a, b) => b.date!.compareTo(a.date ?? ""));

    List<LootItem> list = [];
    var listValue = context.watch<MissingObjectPrv>().filterValuePick;
    if (listValue == 0) {
      list = waitList + returnedList;
    } else if (listValue == 1) {
      list = waitList;
    } else {
      list = returnedList;
    }
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vpad(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              S.of(context).status,
              style: txtBold(12, grayScaleColor2),
            ),
          ),
          vpad(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: PrimaryDropDown(
              value: context.watch<MissingObjectPrv>().filterValuePick,
              onChange: context.read<MissingObjectPrv>().changeStatusListPick,
              selectList: [
                DropdownMenuItem(
                  value: 0,
                  child: Text(S.of(context).all),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text(S.of(context).wait_return),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text(S.of(context).returned),
                ),
              ],
            ),
          ),
          vpad(12),
          list.isEmpty
              ? Expanded(
                  child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  onRefresh: () {
                    widget.onRefresh();
                    widget.refreshController.refreshCompleted();
                  },
                  controller: widget.refreshController,
                  header: WaterDropMaterialHeader(
                      backgroundColor: Theme.of(context).primaryColor),
                  onLoading: () {
                    widget.refreshController.loadComplete();
                  },
                  child: PrimaryEmptyWidget(
                    emptyText: S.of(context).no_pick_obj,
                    icons: PrimaryIcons.binoculars,
                    action: () {},
                  ),
                ))
              : Expanded(
                  child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  onRefresh: () {
                    widget.onRefresh();
                    widget.refreshController.refreshCompleted();
                  },
                  controller: widget.refreshController,
                  header: WaterDropMaterialHeader(
                      backgroundColor: Theme.of(context).primaryColor),
                  onLoading: () {
                    widget.refreshController.loadComplete();
                  },
                  child: ListView(
                    physics: null,
                    children: [
                      ...list.map(
                        (e) => PrimaryCard(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              LootItemDetailsScreen.routeName,
                              arguments: {
                                "lost": e,
                                "status": e.status,
                                "change": widget.changeStatus,
                              },
                            );
                          },
                          margin: const EdgeInsets.only(
                              bottom: 16, left: 12, right: 12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 16,
                            ),
                            child: Row(children: [
                              const PrimaryIcon(
                                icons: PrimaryIcons.binoculars,
                                style: PrimaryIconStyle.gradient,
                                gradients: PrimaryIconGradient.turquoise,
                                size: 32,
                                padding: EdgeInsets.all(12),
                                color: Colors.white,
                              ),
                              hpad(16),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name ?? "",
                                    style: txtBold(16),
                                  ),
                                  vpad(4),
                                  Table(
                                    textBaseline: TextBaseline.ideographic,
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.baseline,
                                    columnWidths: const {
                                      0: FlexColumnWidth(3),
                                      1: FlexColumnWidth(3)
                                    },
                                    children: [
                                      TableRow(children: [
                                        Text('${S.of(context).found_time}:'),
                                        Text(Utils.dateFormat(e.date ?? '', 1),
                                            style: txtLinkSmall()),
                                      ]),
                                      TableRow(children: [vpad(4), vpad(4)]),
                                      if (widget.type == "FOUND")
                                        TableRow(children: [
                                          Text('${S.of(context).found_place}:'),
                                          Text(
                                            e.address ?? "",
                                          ),
                                        ]),
                                      TableRow(children: [vpad(4), vpad(4)]),
                                      TableRow(children: [
                                        Text('${S.of(context).status}:'),
                                        Text(
                                          e.s!.name ?? "",
                                          style: genLostStyle(e.status ?? ""),
                                        )
                                      ]),
                                    ],
                                  )
                                ],
                              ))
                            ]),
                          ),
                        ),
                      ),
                      vpad(60),
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}
