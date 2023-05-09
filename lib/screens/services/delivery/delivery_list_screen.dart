// ignore_for_file: prefer_const_constructors

import 'package:app_cudan/screens/services/delivery/tabs/my_letters-tabs.dart';
import 'package:app_cudan/screens/services/delivery/tabs/wait_confirm_letter_tabs.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';

import '../../../widgets/primary_screen.dart';
import '../service_screen.dart';

import 'provider/delivery_list_prv.dart';
import 'register_delivery_screen.dart';

class DeliveryListScreen extends StatefulWidget {
  static const routeName = '/delivery';
  const DeliveryListScreen({super.key});

  @override
  State<DeliveryListScreen> createState() => _DeliveryListScreenState();
}

class _DeliveryListScreenState extends State<DeliveryListScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  var initIndex = 0;

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as int?;

    if (arg != null) {
      initIndex = arg;
    }
    tabController.index = initIndex;
    return ChangeNotifierProvider(
      create: (context) => DeliveryListPrv(),
      builder: (context, child) {
        return ChangeNotifierProvider(
          create: (_) => DeliveryListPrv(),
          builder: (context, child) {
            return PrimaryScreen(
              appBar: PrimaryAppbar(
                leading: BackButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    ServiceScreen.routeName,
                  ),
                ),
                title: S.of(context).transfer_list,
                tabController: tabController,
                isTabScrollabel: false,
                tabs: [
                  Tab(text: S.of(context).my_letter),
                  Tab(text: S.of(context).wait_confirm_letter),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                tooltip: S.of(context).add_trans_card,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RegisterDelivery.routeName,
                    arguments: {"isEdit": false},
                  );
                },
                backgroundColor: primaryColorBase,
                child: const Icon(
                  Icons.add,
                  size: 40,
                ),
              ),
              body: SafeArea(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    MyLettersTabs(),
                    WaitConfirmLetterTab(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
