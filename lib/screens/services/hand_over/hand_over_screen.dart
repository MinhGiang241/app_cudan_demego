import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../service_screen.dart';
import 'booking_screen.dart';
import 'prv/hand_over_prv.dart';
import 'tab/Booking_tab.dart';
import 'tab/history_tab.dart';

class HandOverScreen extends StatefulWidget {
  const HandOverScreen({super.key});
  static const routeName = '/hand-over';

  @override
  State<HandOverScreen> createState() => _HandOverScreenState();
}

class _HandOverScreenState extends State<HandOverScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  var initIndex = 0;
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return ChangeNotifierProvider(
      create: (context) => HandOverPrv(),
      builder: (context, builder) {
        if (arg != null && arg['init'] != null) {
          tabController.index = arg['init'];
        }
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            leading: BackButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                ServiceScreen.routeName,
              ),
            ),
            title: S.of(context).hand_over,
            tabController: tabController,
            isTabScrollabel: false,
            tabs: [
              Tab(text: S.of(context).booking),
              Tab(text: S.of(context).booking_his),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            tooltip: S.of(context).booking_hand_over_0,
            onPressed: () {
              Navigator.pushNamed(
                context,
                BookingScreen.routeName,
                arguments: {"book": true},
              );
            },
            backgroundColor: primaryColorBase,
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: const [
              BookingTab(),
              HistoryTab(),
            ],
          ),
        );
      },
    );
  }
}
