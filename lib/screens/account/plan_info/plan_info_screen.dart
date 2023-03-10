import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_screen.dart';
import 'widgets/plan_info_tab.dart';
import 'widgets/recident_info_tab.dart';

class PlanInfoScreen extends StatefulWidget {
  const PlanInfoScreen({Key? key}) : super(key: key);

  @override
  State<PlanInfoScreen> createState() => _PlanInfoScreenState();
}

class _PlanInfoScreenState extends State<PlanInfoScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 4, vsync: this);
  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).plan_info,
        tabController: tabController,
        // isTabScrollable: false,
        tabs: [
          Tab(text: S.of(context).surface),
          Tab(text: S.of(context).resident_info),
          Tab(text: S.of(context).bill_history),
          Tab(text: S.of(context).noti_history),
        ],
      ),
      body: TabBarView(controller: tabController, children: [
        const PlanInfoTab(),
        const ResidentInfoTab(),
        Container(),
        Container(),
      ]),
    );
  }
}
