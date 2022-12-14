import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../service_screen.dart';
import 'construction_reg_screen.dart';
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
  late TabController tabController = TabController(length: 2, vsync: this);
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
                    context, ServiceScreen.routeName),
              ),
              title: S.of(context).cons_list,
              tabController: tabController,
              isTabScrollabel: false,
              tabs: [
                Tab(text: S.of(context).cons_reg_letter),
                Tab(text: S.of(context).cons_file),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: S.of(context).cons_reg,
              onPressed: () {
                Navigator.pushNamed(context, ConstructionRegScreen.routeName,
                    arguments: {"isEdit": false});
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
                ConstructionFileTab(
                  list: context.read<ConstructionListPrv>().listDocument,
                  getList: (BuildContext ctx) => context
                      .read<ConstructionListPrv>()
                      .getContructionDocumentList(ctx),
                ),
              ],
            ),
          );
        });
  }
}
