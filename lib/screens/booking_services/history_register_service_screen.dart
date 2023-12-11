import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import 'prv/history_register_service_prv.dart';
import 'tabs/month_services_tab.dart';
import 'tabs/turn_services_tab.dart';

class HistoryRegisterServiceScreen extends StatefulWidget {
  const HistoryRegisterServiceScreen({super.key});
  static const routeName = 'history-booking';

  @override
  State<HistoryRegisterServiceScreen> createState() =>
      _HistoryRegisterServiceScreenState();
}

class _HistoryRegisterServiceScreenState
    extends State<HistoryRegisterServiceScreen> with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  var initIndex = 0;

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    if (arg != null && arg['init'] != null) {
      initIndex = arg['init'];
    }
    print(arg);
    print(initIndex);
    return ChangeNotifierProvider(
      create: (context) => HistoryRegisterServicePrv(),
      builder: (context, builder) {
        tabController.index = initIndex;
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).his_reg_service,
            tabController: tabController,
            isTabScrollabel: false,
            tabs: [
              Tab(text: S.of(context).turn_service),
              Tab(text: S.of(context).month_service),
            ],
          ),
          body: SafeArea(
            child: TabBarView(
              controller: tabController,
              children: [
                TurnServicesTab(),
                MonthServicesTab(),
              ],
            ),
          ),
        );
      },
    );
  }
}
