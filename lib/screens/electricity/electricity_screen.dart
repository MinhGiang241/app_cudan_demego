import 'package:app_cudan/screens/electricity/tabs/electric_payment_tab.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_screen.dart';
import 'prv/electricity_prv.dart';
import 'tabs/comsummed_electricity.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});
  static const routeName = "/electricity";

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);
  var initIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ElectricityPrv(),
      builder: (context, snapshot) {
        return PrimaryScreen(
          isPadding: false,
          appBar: PrimaryAppbar(
            title: S.of(context).consume_elec,
            tabController: tabController,
            isTabScrollabel: false,
            tabs: [
              Tab(text: S.of(context).details),
              Tab(text: S.of(context).bill),
              Tab(text: S.of(context).pay),
            ],
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Center(
                  child: PrimaryIcon(
                    icons: PrimaryIcons.filter,
                    onTap: () {
                      // DatePicker.showPicker(
                      //   context,
                      //   onChanged: (v) {},
                      //   onConfirm: (v) {
                      //     context.read<PaymentListPrv>().onChooseMonthYear(v);
                      //     setState(() {
                      //       initIndex = tabController.index;
                      //       init = false;
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
                      //     });
                      //   },
                      //   pickerModel: CustomMonthPicker(
                      //       minTime: DateTime(DateTime.now().year - 10, 1, 1),
                      //       maxTime:
                      //           DateTime(DateTime.now().year + 10, 12, 31),
                      //       currentTime: DateTime(
                      //           context.read<PaymentListPrv>().year!,
                      //           context.read<PaymentListPrv>().month!,
                      //           1),
                      //       locale: LocaleType.vi),
                      // );
                    },
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: TabBarView(
              controller: tabController,
              children: [
                const ConsummedElectricityTab(),
                const ElectricityPaymentTab(),
                const ElectricityPaymentTab(),
              ],
            ),
          ),
        );
      },
    );
  }
}
