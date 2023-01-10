import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../service_screen.dart';
import 'prv/hand_over_prv.dart';
import 'tab/Booking_tab.dart';

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
    return ChangeNotifierProvider(
      create: (context) => HandOverPrv(),
      builder: (context, builder) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            leading: BackButton(
              onPressed: () => Navigator.pushReplacementNamed(
                  context, ServiceScreen.routeName),
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
            tooltip: S.of(context).booking_hand_over,
            onPressed: () {},
            backgroundColor: primaryColorBase,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              BookingTab(),
              BookingTab(),
            ],
          ),
        );
      },
    );
  }
}
