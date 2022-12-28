import 'package:app_cudan/models/missing_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../lost_item_details_screen.dart';

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
    case "FOUND":
      return txtBold(14, primaryColor6);
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
  Function(MissingObject)? changeStatus;

  Function() onRefresh;

  RefreshController refreshController = RefreshController();

  @override
  State<MissingObjectTab> createState() => _MissingObjectTabState();
}

class _MissingObjectTabState extends State<MissingObjectTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        child: widget.list.isEmpty
            ? Column(
                children: [
                  Expanded(
                    child: PrimaryEmptyWidget(
                      emptyText: S.of(context).no_pick_obj,
                      icons: PrimaryIcons.binoculars,
                      action: () {},
                    ),
                  ),
                ],
              )
            : ListView(
                children: [
                  vpad(24),
                  ...widget.list.map(
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
                                    Text('${S.of(context).missing_time}:'),
                                    Text(Utils.dateFormat(e.time ?? '', 1),
                                        style: txtLinkSmall()),
                                  ]),
                                  TableRow(children: [vpad(4), vpad(4)]),
                                  if (widget.type == "FOUND")
                                    TableRow(children: [
                                      Text('${S.of(context).found_place}:'),
                                      Text(
                                        e.find_place ?? "",
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
      ),
    );
  }
}
