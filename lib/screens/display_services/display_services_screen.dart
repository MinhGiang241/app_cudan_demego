import 'package:app_cudan/screens/display_services/prv/display_service_prv.dart';
import 'package:app_cudan/screens/display_services/tabs/health_tabs.dart';
import 'package:app_cudan/screens/display_services/tabs/shopping_tab.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';

class DisplayServiceScreen extends StatefulWidget {
  const DisplayServiceScreen({super.key});
  static const routeName = '/display';

  @override
  State<DisplayServiceScreen> createState() => _DisplayServiceScreenState();
}

class _DisplayServiceScreenState extends State<DisplayServiceScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DisplayServicePrv(),
      builder: (context, builder) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).display_service,
            tabController: tabController,
            isTabScrollabel: false,
            tabs: [
              Tab(text: S.of(context).health),
              Tab(text: S.of(context).shopping),
            ],
          ),
          body: SafeArea(
            child: TabBarView(
              controller: tabController,
              children: [
                HealthTab(),
                ShoppingTab(),
              ],
            ),
          ),
        );
      },
    );
  }
}
