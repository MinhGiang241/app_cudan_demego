import 'package:app_cudan/screens/event/prv/event_list_prv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_error_widget.dart';
import '../../widgets/primary_loading.dart';
import '../../widgets/primary_screen.dart';
import '../home/home_screen.dart';
import 'tabs/event_tab.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});
  static const routeName = '/events';

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 4, vsync: this);
  var initIndex = 0;
  @override
  Widget build(BuildContext context) {
    void _onRefresh() {
      setState(() {
        initIndex = tabController.index;
      });
    }

    return ChangeNotifierProvider(
      create: (context) => EventListPrv(),
      builder: (context, state) {
        return PrimaryScreen(
            appBar: PrimaryAppbar(
              leading: BackButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (route) => route.isCurrent),
              ),
              title: S.of(context).event,
              tabController: tabController,
              isTabScrollabel: true,
              tabs: [
                Tab(text: S.of(context).coming_soon),
                Tab(text: S.of(context).happening),
                Tab(text: S.of(context).happened),
                Tab(text: S.of(context).history),
              ],
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                EventTab(
                  type: "COMING",
                ),
                EventTab(
                  type: "HAPPENING",
                ),
                EventTab(
                  type: "HAPPENED",
                ),
                EventTab(
                  type: "HISTORY",
                ),
              ],
            ));
      },
    );
  }
}
