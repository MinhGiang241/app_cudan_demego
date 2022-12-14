import 'package:app_cudan/screens/payment/prv/payment_list_prv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../utils/utils.dart';
import '../../widgets/item_selected.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_bottom_sheet.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_screen.dart';
import 'tabs/payment_tab.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});
  static const routeName = '/payment';

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  var initIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentListPrv(),
      builder: (context, state) {
        return PrimaryScreen(
            appBar: PrimaryAppbar(
              title: S.of(context).pay,
              tabController: tabController,
              isTabScrollabel: false,
              tabs: [
                Tab(text: S.of(context).paid),
                Tab(text: S.of(context).unpaid),
              ],
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Center(
                    child: PrimaryIcon(
                      icons: PrimaryIcons.filter,
                      onTap: () {
                        Utils.showBottomSheet(
                          context: context,
                          child: PrimaryBottomSheet(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ItemSelected(text: "Tất cả", onTap: () {}),
                                  const Divider(height: 1),
                                  ItemSelected(
                                      text: "Điện",
                                      isSelected: true,
                                      onTap: () {}),
                                  const Divider(height: 1),
                                  ItemSelected(text: "Nước", onTap: () {}),
                                  const Divider(height: 1),
                                  ItemSelected(text: "Internet", onTap: () {}),
                                  const Divider(height: 1),
                                  ItemSelected(text: "Bảo trì", onTap: () {}),
                                  const Divider(height: 1),
                                  vpad(MediaQuery.of(context).padding.bottom +
                                      24)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                PaymentTab(),
                PaymentTab(),
              ],
            ));
      },
    );
  }
}
