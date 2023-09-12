import 'dart:async';

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

class ConstructionListScreen extends StatefulWidget {
  const ConstructionListScreen({super.key});
  static const routeName = '/construction';

  @override
  State<ConstructionListScreen> createState() => _ConstructionListScreenState();
}

class _ConstructionListScreenState extends State<ConstructionListScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);
  var initIndex = 0;
  var tooltipKey = UniqueKey();
  StreamController<bool> stream = StreamController.broadcast();
  @override
  void initState() {
    super.initState();
    tabController.addListener(() {
      stream.add(tabController.index == 0 || tabController.index == 1);
    });
  }

  Widget _bottomButtons() {
    return StreamBuilder<bool>(
      initialData: tabController.index == 0 || tabController.index == 1,
      stream: stream.stream,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return FloatingActionButton(
            shape: CircleBorder(),
            key: tooltipKey,
            tooltip: tabController.index == 1
                ? S.current.construction_extend
                : S.current.cons_reg,
            onPressed: () {
              if (tabController.index == 1) {
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
              color: Colors.white,
              size: 40,
            ),
          );
        }
        return vpad(0);
      },
    );
  }

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
              // Tab(text: S.of(context).wait_confirm_letter),
              Tab(text: S.of(context).extend_letter),
              // Tab(text: S.of(context).wait_extend_letter),
              Tab(text: S.of(context).cons_file),
            ],
          ),
          floatingActionButton: _bottomButtons(),
          body: TabBarView(
            controller: tabController,
            children: [
              ConstructionRegistrationLetterTab(
                list: context.read<ConstructionListPrv>().listRegistration,
                getList: (BuildContext ctx) => context
                    .read<ConstructionListPrv>()
                    .getContructionRegistrationLetterList(ctx),
              ),
              // ConstructionWaitTab(
              //   list: context.read<ConstructionListPrv>().listWaitRegistration,
              //   getList: (BuildContext ctx) => context
              //       .read<ConstructionListPrv>()
              //       .getContructionRegistrationLetterListWait(ctx),
              // ),
              ConstructionExtendTab(
                list: context.read<ConstructionListPrv>().listExtension,
                getList: (BuildContext ctx) => context
                    .read<ConstructionListPrv>()
                    .getConstructionExtensionList(ctx),
              ),
              // ConstructionExtendWaitTab(
              //   list: context.read<ConstructionListPrv>().listWaitExtension,
              //   getList: (BuildContext ctx) => context
              //       .read<ConstructionListPrv>()
              //       .getListWaitExtension(ctx),
              // ),
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
