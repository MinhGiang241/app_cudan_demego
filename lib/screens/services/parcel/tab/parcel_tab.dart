import 'package:app_cudan/widgets/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../models/parcel.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../parcel_detail_screen.dart';
import '../prv/parcel_list_prv.dart';

// ignore: must_be_immutable
class ParcelTab extends StatefulWidget {
  ParcelTab({
    super.key,
    required this.refreshController,
    required this.list,
    required this.onRefresh,
    required this.type,
  });
  List<Parcel> list = [];
  String type;

  Function() onRefresh;

  RefreshController refreshController = RefreshController();

  @override
  State<ParcelTab> createState() => _ParcelTabState();
}

class _ParcelTabState extends State<ParcelTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          vpad(24),
          context.watch<ParcelListPrv>().isInit
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).all,
                        style: txtBold(12, grayScaleColor3),
                      ),
                      Text(
                        "${S.of(context).amount}: ${widget.list.length}",
                        style: txtBold(12, grayScaleColor3),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${S.of(context).month} ${context.watch<ParcelListPrv>().month},${context.watch<ParcelListPrv>().year}',
                        style: txtBold(12, grayScaleColor3),
                      ),
                      Text(
                        "${S.of(context).amount}: ${widget.list.length}",
                        style: txtBold(12, grayScaleColor3),
                      ),
                    ],
                  ),
                ),
          vpad(12),
          widget.list.isEmpty
              ? Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    onRefresh: () {
                      // context.read<PaymentListTabPrv>().getEventList(context, true);
                      widget.onRefresh();
                      widget.refreshController.refreshCompleted();
                    },
                    controller: widget.refreshController,
                    header: WaterDropMaterialHeader(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onLoading: () {
                      // context
                      //     .read<PaymentListTabPrv>()
                      //     .getEventList(context, false);

                      widget.refreshController.loadComplete();
                    },
                    child: PrimaryEmptyWidget(
                      emptyText: S.of(context).no_parcel,
                      icons: PrimaryIcons.package,
                      action: () {},
                    ),
                  ),
                )
              : Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    onRefresh: () {
                      // context.read<PaymentListTabPrv>().getEventList(context, true);
                      widget.onRefresh();
                      widget.refreshController.refreshCompleted();
                    },
                    controller: widget.refreshController,
                    header: WaterDropMaterialHeader(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onLoading: () {
                      // context
                      //     .read<PaymentListTabPrv>()
                      //     .getEventList(context, false);

                      widget.refreshController.loadComplete();
                    },
                    child: ListView(
                      children: [
                        ...widget.list.map(
                          (e) => PrimaryCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ParcelDetailsScreen.routeName,
                                arguments: e,
                              );
                            },
                            margin: const EdgeInsets.only(
                              bottom: 16,
                              left: 12,
                              right: 12,
                            ),
                            child: Column(
                              children: [
                                if (widget.type == "RECEIPTED")
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (genStatusColor(
                                          e.status as String,
                                        )),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        e.s!.name ?? "",
                                        style: txtSemiBold(12, Colors.white),
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      const PrimaryIcon(
                                        icons: PrimaryIcons.package,
                                        style: PrimaryIconStyle.gradient,
                                        gradients: PrimaryIconGradient.blue,
                                        size: 32,
                                        padding: EdgeInsets.all(12),
                                        color: Colors.white,
                                      ),
                                      hpad(16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.name ?? "",
                                              style: txtBold(16),
                                            ),
                                            vpad(4),
                                            Text(
                                              '${S.of(context).parcel_code}: ${e.code ?? ""}',
                                            ),
                                            vpad(4),
                                            if (widget.type == "WAIT")
                                              Text(
                                                '${S.of(context).arrived_date}: ${Utils.dateTimeFormat(e.time_get ?? "", 1)}',
                                              ),
                                            if (widget.type == "RECEIPTED")
                                              Text(
                                                '${S.of(context).receipt_date}: ${Utils.dateTimeFormat(e.time_out ?? "", 1)}',
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        vpad(80),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
