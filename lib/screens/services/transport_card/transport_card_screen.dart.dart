// ignore_for_file: implementation_imports, prefer_const_constructors

import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_screen.dart';
import '../service_screen.dart';
import 'add_new_transport_card.dart';
import 'prv/transport_card_prv.dart';
import 'tabs/transport_card_tab.dart';
import 'tabs/transport_letter_tab.dart';

class TransportCardScreen extends StatefulWidget {
  const TransportCardScreen({super.key});
  static const routeName = '/transport/add';

  @override
  State<TransportCardScreen> createState() => _TransportCardScreenState();
}

class _TransportCardScreenState extends State<TransportCardScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  var initIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as int?;

    if (arg != null) {
      initIndex = arg;
    }
    tabController.index = initIndex;

    return ChangeNotifierProvider(
      create: (context) => TransportCardPrv(),
      builder: (context, state) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).transport_card,
            leading: BackButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                ServiceScreen.routeName,
              ),
            ),
            tabController: tabController,
            isTabScrollabel: false,
            tabs: [
              Tab(text: S.of(context).card_status),
              Tab(text: S.of(context).letter_status),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: S.of(context).add_trans_card,
            onPressed: () {
              Navigator.pushNamed(
                context,
                AddNewTransportCardScreen.routeName,
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
                TransportCardTab(),
                TransportLetterTab(),
              ],
            ),
          ),
        );
      },
    );
  }
}
