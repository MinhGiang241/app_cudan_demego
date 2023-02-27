import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/models/missing_object.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../lost_item_details_screen.dart';
import '../prv/missing_object_prv.dart';

// genLostStatus(String? status) {
//   switch (status) {
//     case "FOUND":
//       return S.current.returned;
//     case "NOTFOUND":
//       return S.current.wait_return;
//     default:
//       return '';
//   }
// }

genLostStyle(String? status) {
  switch (status) {
    case "FOUND":
      return txtBold(14, primaryColor6);
    case "NOTFOUND":
      return txtBold(14, redColorBase);
    case "NOTFOUND":
      return txtBold(14, redColorBase);
    default:
      return txtBold(14, grayScaleColorBase);
  }
}

class MissingObjectTab extends StatefulWidget {
  MissingObjectTab({
    super.key,
    required this.refreshController,
    required this.list,
    required this.onRefresh,
    required this.type,
    this.changeStatus,
  });
  List<MissingObject> list = [];
  String type;
  Function(BuildContext, MissingObject)? changeStatus;

  Function() onRefresh;

  RefreshController refreshController = RefreshController();

  @override
  State<MissingObjectTab> createState() => _MissingObjectTabState();
}

class _MissingObjectTabState extends State<MissingObjectTab> {
  @override
  Widget build(BuildContext context) {
    // List<MissingObject> list = [];
    List<MissingObject> foundList = [];
    List<MissingObject> notFoundList = [];
    List<MissingObject> acceptList = [];
    final _controller = ScrollController();

    for (var i in widget.list) {
      if (i.status == "FOUND") {
        foundList.add(i);
      } else if (i.status == "NOTFOUND") {
        notFoundList.add(i);
      } else {
        acceptList.add(i);
      }
    }
    foundList.sort((a, b) => b.time!.compareTo(a.time ?? ""));
    notFoundList.sort((a, b) => b.time!.compareTo(a.time ?? ""));
    acceptList.sort((a, b) => b.time!.compareTo(a.time ?? ""));
    List<MissingObject> list = [];
    var listValue = context.watch<MissingObjectPrv>().filterValueHistory;
    if (listValue == 0) {
      list = notFoundList + foundList + acceptList;
    } else if (listValue == 1) {
      list = notFoundList;
    } else if (listValue == 2) {
      list = foundList;
    } else {
      list = acceptList;
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
              value: context.watch<MissingObjectPrv>().filterValueHistory,
              onChange:
                  context.read<MissingObjectPrv>().changeStatusListHistory,
              selectList: [
                DropdownMenuItem(
                  value: 0,
                  child: Text(S.of(context).all),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text(S.of(context).wait_find),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text(S.of(context).found),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text(S.of(context).confirmed),
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
                      shrinkWrap: true,
                      controller: _controller,
                      // physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ...list.map(
                          (e) => PrimaryCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                LostItemDetailsScreen.routeName,
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
                                        1: FlexColumnWidth(2)
                                      },
                                      children: [
                                        TableRow(children: [
                                          Text(
                                              '${S.of(context).missing_time}:'),
                                          Text(
                                              Utils.dateFormat(e.time ?? '', 1),
                                              style: txtLinkSmall()),
                                        ]),
                                        TableRow(children: [vpad(4), vpad(4)]),
                                        if (widget.type == "FOUND")
                                          TableRow(children: [
                                            Text(
                                                '${S.of(context).found_place}:'),
                                            Text(
                                              e.find_place ?? "",
                                            ),
                                          ]),
                                        TableRow(children: [vpad(4), vpad(4)]),
                                        TableRow(children: [
                                          Text('${S.of(context).status}:'),
                                          Text(
                                            e.s!.name ?? "",
                                            style: txtBold(14,
                                                genStatusColor(e.status ?? "")),
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
                  ),
                ),
        ],
      ),
    );
  }
}
