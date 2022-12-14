import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../prv/payment_list_tab_prv.dart';
import '../widget/payment_item.dart';

class PaymentTab extends StatefulWidget {
  const PaymentTab({super.key});

  @override
  State<PaymentTab> createState() => _PaymentTabState();
}

class _PaymentTabState extends State<PaymentTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PaymentListTabPrv(),
        builder: (context, builder) {
          return FutureBuilder(
            future: () async {}(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: PrimaryLoading());
              } else if (snapshot.connectionState == ConnectionState.none) {
                return PrimaryErrorWidget(
                    code: snapshot.hasError ? "err" : "1",
                    message: snapshot.data.toString(),
                    onRetry: () async {
                      setState(() {});
                    });
              } else if (!context
                  .watch<PaymentListTabPrv>()
                  .listPayment
                  .isEmpty) {
                return SafeArea(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: () {
                      // context.read<PaymentListTabPrv>().getEventList(context, true);
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () {
                      // context
                      //     .read<PaymentListTabPrv>()
                      //     .getEventList(context, false);
                      _refreshController.loadComplete();
                    },
                    controller: _refreshController,
                    header: WaterDropMaterialHeader(
                        backgroundColor: Theme.of(context).primaryColor),
                    child: PrimaryEmptyWidget(
                      emptyText: S.of(context).no_bill,
                      icons: PrimaryIcons.credit,
                      action: () {},
                    ),
                  ),
                );
              } else {
                return Stack(
                  children: [
                    SafeArea(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh: () {
                          // context.read<PaymentListTabPrv>().getEventList(context, true);
                          _refreshController.refreshCompleted();
                        },
                        controller: _refreshController,
                        header: WaterDropMaterialHeader(
                            backgroundColor: Theme.of(context).primaryColor),
                        onLoading: () {
                          // context
                          //     .read<PaymentListTabPrv>()
                          //     .getEventList(context, false);
                          _refreshController.loadComplete();
                        },
                        child: ListView(
                          children: [
                            vpad(24),
                            PaymentItem(
                              isPaid: true,
                              isSelected: true,
                              onSelect: () {},
                            ),
                            PaymentItem(
                              isPaid: false,
                              isSelected: false,
                              onSelect: () {},
                            ),
                            PaymentItem(
                              isPaid: false,
                              isSelected: true,
                              onSelect: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 24,
                      left: 12,
                      right: 12,
                      child: SafeArea(
                        child: PrimaryButton(
                          text: S.of(context).pay,
                          onTap: () {
                            // Utils.pushScreen(context, const PaymentScreen());
                          },
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          );
        });
  }
}
