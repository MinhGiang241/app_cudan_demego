import 'package:app_cudan/screens/payment/prv/payment_list_prv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/bill_model.dart';
import '../../../models/extra_service.dart';
import '../../../models/receipt.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_empty_widget.dart';

import '../../../widgets/primary_icon.dart';

import '../payment_screen.dart';
import '../widget/payment_item.dart';

// ignore: must_be_immutable
class PaymentTab extends StatefulWidget {
  PaymentTab({
    super.key,
    this.list = const [],
    required this.type,
    required this.refreshController,
    this.onRefresh,
  });
  String type;
  List<Receipt> list;
  RefreshController refreshController;
  Function()? onRefresh;

  @override
  State<PaymentTab> createState() => _PaymentTabState();
}

class _PaymentTabState extends State<PaymentTab> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: () {
              // context.read<PaymentListTabPrv>().getEventList(context, true);
              widget.onRefresh!();
              widget.refreshController.refreshCompleted();
            },
            controller: widget.refreshController,
            header: WaterDropMaterialHeader(
                backgroundColor: Theme.of(context).primaryColor),
            onLoading: () {
              // context
              //     .read<PaymentListTabPrv>()
              //     .getEventList(context, false);

              widget.refreshController.loadComplete();
            },
            child: widget.list.isEmpty
                ? PrimaryEmptyWidget(
                    emptyText: S.of(context).no_bill,
                    icons: PrimaryIcons.credit,
                    action: () {},
                  )
                : ListView(
                    children: [
                      vpad(24),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, bottom: 12, right: 12),
                        child: Text(
                          "${S.of(context).bills}:",
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: family,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: grayScaleColorBase),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, bottom: 12, right: 12),
                        child: Text(
                          "${S.of(context).month} ${context.watch<PaymentListPrv>().month.toString()}, ${context.watch<PaymentListPrv>().year.toString()}",
                          style: txtBold(14, grayScaleColorBase),
                        ),
                      ),
                      ...widget.list.asMap().entries.map(
                            (e) => PaymentItem(
                              re: e.value,
                              isPaid: widget.type == "PAID",
                              onSelect: () => context
                                  .read<PaymentListPrv>()
                                  .onSelect(e.key),
                            ),
                          ),
                      vpad(80)
                    ],
                  ),
          ),
        ),
        if (widget.type == "UNPAID")
          Positioned(
            bottom: 24,
            left: 12,
            right: 12,
            child: SafeArea(
              child: PrimaryButton(
                text: S.of(context).pay,
                onTap: () {
                  var e = widget.list.where((e) => e.isSelected).toList();
                  if (e.isNotEmpty) {
                    Navigator.pushNamed(
                      context,
                      PaymentScreen.routeName,
                      arguments: e,
                    );
                  }
                },
              ),
            ),
          )
      ],
    );
  }
}
