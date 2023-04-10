import 'package:app_cudan/models/receipt.dart';
import 'package:app_cudan/screens/payment/bill_details_screen.dart';
import 'package:app_cudan/widgets/primary_empty_widget.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../payment/widget/payment_item.dart';
import '../prv/water_prv.dart';

class WaterPaymentTab extends StatefulWidget {
  const WaterPaymentTab({super.key});

  @override
  State<WaterPaymentTab> createState() => _WaterPaymentTabState();
}

class _WaterPaymentTabState extends State<WaterPaymentTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {
        await context.read<WaterPrv>().getReceiptByYear(context);
      }(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: PrimaryLoading(),
          );
        } else if (snapshot.hasError) {
          return PrimaryErrorWidget(
            code: snapshot.hasError ? "err" : "1",
            message: snapshot.data.toString(),
            onRetry: () async {
              setState(() {});
            },
          );
        }
        List<Receipt> listReceipt = context.watch<WaterPrv>().listReceipt;
        if (listReceipt.isEmpty) {
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropMaterialHeader(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            controller: _refreshController,
            onRefresh: () {
              _refreshController.refreshCompleted();
              setState(() {});
            },
            child: PrimaryEmptyWidget(
              emptyText: S.of(context).no_bill,
              icons: PrimaryIcons.credit,
              action: () {},
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
            _refreshController.refreshCompleted();
            setState(() {});
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              vpad(12),
              ...listReceipt.map((e) {
                var date =
                    DateTime.parse(e.date ?? '').add(const Duration(hours: 7));
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${S.of(context).month}  ${e.month_indicator}, ${e.year_indicator}",
                          style: txtBold(12, grayScaleColor2),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    vpad(8),
                    PaymentItem(
                      canSelect: false,
                      widget: e.payment_status == "UNPAID"
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: (genStatusColor("UNPAID")),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  genStatus('UNPAID'),
                                  style: txtSemiBold(12, Colors.white),
                                ),
                              ),
                            )
                          : null,
                      re: e,
                      isPaid: false,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          BillDetailsScreen.routeName,
                          arguments: {
                            "re": e,
                            "year": date.year,
                            "month": date.month,
                            "navigate": context.read<WaterPrv>().navigate,
                          },
                        );
                      },
                    ),
                  ],
                );
              })
              // PaymentItem(
              //   re:,
              //
              // ),
            ],
          ),
        );
      },
    );
  }
}
