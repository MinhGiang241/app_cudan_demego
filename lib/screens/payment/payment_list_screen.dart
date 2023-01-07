import 'package:app_cudan/screens/payment/prv/payment_list_prv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../generated/l10n.dart';
import '../../widgets/choose_month_year.dart';
import '../../widgets/primary_appbar.dart';

import '../../widgets/primary_error_widget.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_loading.dart';
import '../../widgets/primary_screen.dart';
import '../home/home_screen.dart';
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
  bool init = true;
  final RefreshController _refreshPayController =
      RefreshController(initialRefresh: false);
  final RefreshController _refreshUnpayController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    if (arg['index'] != null && init) {
      initIndex = arg['index'];
    }
    tabController.index = initIndex;
    return ChangeNotifierProvider(
      create: (context) =>
          PaymentListPrv(year: arg['year'], month: arg['month']),
      builder: (context, state) {
        return PrimaryScreen(
            appBar: PrimaryAppbar(
              // leading: BackButton(onPressed: () {
              //   Navigator.pushNamedAndRemoveUntil(
              //       context, HomeScreen.routeName, (route) => route.isCurrent);
              // }),
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
                        DatePicker.showPicker(
                          context,
                          onChanged: (v) {},
                          onConfirm: (v) {
                            context.read<PaymentListPrv>().onChooseMonthYear(v);
                            setState(() {
                              initIndex = tabController.index;
                              init = false;
                            });
                          },
                          pickerModel: CustomMonthPicker(
                              minTime: DateTime(DateTime.now().year - 10, 1, 1),
                              maxTime:
                                  DateTime(DateTime.now().year + 10, 12, 31),
                              currentTime: DateTime(
                                  context.read<PaymentListPrv>().year!,
                                  context.read<PaymentListPrv>().month!,
                                  1),
                              locale: LocaleType.vi),
                        );
                        // Utils.showBottomSheet(
                        //   context: context,
                        //   child: PrimaryBottomSheet(
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 16),
                        //       child: Column(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           ItemSelected(text: "Tất cả", onTap: () {}),
                        //           const Divider(height: 1),
                        //           ItemSelected(
                        //               text: "Điện",
                        //               isSelected: true,
                        //               onTap: () {}),
                        //           const Divider(height: 1),
                        //           ItemSelected(text: "Nước", onTap: () {}),
                        //           const Divider(height: 1),
                        //           ItemSelected(text: "Internet", onTap: () {}),
                        //           const Divider(height: 1),
                        //           ItemSelected(text: "Bảo trì", onTap: () {}),
                        //           const Divider(height: 1),
                        //           vpad(MediaQuery.of(context).padding.bottom +
                        //               24)
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                  ),
                )
              ],
            ),
            body: FutureBuilder(
                future: context.read<PaymentListPrv>().getReceiptsList(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: PrimaryLoading());
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return PrimaryErrorWidget(
                        code: snapshot.hasError ? "err" : "1",
                        message: snapshot.data.toString(),
                        onRetry: () async {
                          setState(() {});
                          init = false;
                        });
                  }
                  return SafeArea(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        PaymentTab(
                          refreshController: _refreshPayController,
                          list: context.watch<PaymentListPrv>().listUnpay,
                          type: "UNPAID",
                          onRefresh: () {
                            setState(() {
                              initIndex = tabController.index;
                              init = false;
                            });
                          },
                        ),
                        PaymentTab(
                          refreshController: _refreshUnpayController,
                          type: "PAID",
                          list: context.watch<PaymentListPrv>().listPay,
                          onRefresh: () {
                            setState(() {
                              initIndex = tabController.index;
                              init = false;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }));
      },
    );
  }
}
