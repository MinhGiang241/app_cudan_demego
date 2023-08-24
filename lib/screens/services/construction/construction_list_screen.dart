import 'package:app_cudan/screens/services/construction/construction_extend_screen.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_screen.dart';
import '../service_screen.dart';
import 'construction_reg_screen.dart';
import 'tab/construction_extend_tab.dart';
import 'tab/construction_file_tab.dart';
import 'tab/construction_registration_letter.dart';
import 'prv/construction_list_prv.dart';
import 'tab/construction_wait_tab.dart';

class ConstructionListScreen extends StatefulWidget {
  const ConstructionListScreen({super.key});
  static const routeName = '/construction';

  @override
  State<ConstructionListScreen> createState() => _ConstructionListScreenState();
}

class _ConstructionListScreenState extends State<ConstructionListScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 4, vsync: this);
  var initIndex = 0;

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;

    if (arg != null) {
      initIndex = arg['index'];
    }
    tabController.index = initIndex;
    return ChangeNotifierProvider(
      create: (context) => ConstructionListPrv(),
      builder: (context, state) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            leading: BackButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                ServiceScreen.routeName,
              ),
            ),
            title: S.of(context).cons_list,
            tabController: tabController,
            isTabScrollabel: true,
            tabs: [
              Tab(text: S.of(context).my_letter),
              Tab(text: S.of(context).wait_confirm_letter),
              Tab(text: S.of(context).extend_letter),
              Tab(text: S.of(context).cons_file),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: tabController.index == 2
                ? S.of(context).construction_extend
                : S.of(context).cons_reg,
            onPressed: () {
              if (tabController.index == 2) {
                Navigator.pushNamed(
                  context,
                  ConstructionExtendScreen.routeName,
                  arguments: {'edit': true},
                );
              } else {
                Navigator.pushNamed(
                  context,
                  ConstructionRegScreen.routeName,
                  arguments: {'isEdit': false},
                );
              }
            },
            backgroundColor: primaryColorBase,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              ConstructionRegistrationLetterTab(
                list: context.read<ConstructionListPrv>().listRegistration,
                getList: (BuildContext ctx) => context
                    .read<ConstructionListPrv>()
                    .getContructionRegistrationLetterList(ctx),
              ),
              ConstructionWaitTab(
                list: context.read<ConstructionListPrv>().listWaitRegistration,
                getList: (BuildContext ctx) => context
                    .read<ConstructionListPrv>()
                    .getContructionRegistrationLetterListWait(ctx),
              ),
              ConstructionExtendTab(),
              ConstructionFileTab(
                list: context.read<ConstructionListPrv>().listDocument,
                getList: (BuildContext ctx) => context
                    .read<ConstructionListPrv>()
                    .getContructionDocumentList(ctx),
              ),
            ],
          ),
        );
      },
    );
  }
}
