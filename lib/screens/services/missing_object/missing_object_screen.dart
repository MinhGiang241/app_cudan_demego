import 'package:app_cudan/screens/services/missing_object/pick_item_screen.dart';
import 'package:app_cudan/screens/services/missing_object/prv/missing_object_prv.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/missing_object.dart';
import '../../../widgets/choose_month_year.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../service_screen.dart';
import 'reg_lost_item_screen.dart';
import 'tab/missing_object_tab.dart';
import 'tab/picked_item_tab.dart';

class MissingObectScreen extends StatefulWidget {
  const MissingObectScreen({super.key});
  static const routeName = '/missing-object';

  @override
  State<MissingObectScreen> createState() => _MissingObectScreenState();
}

class _MissingObectScreenState extends State<MissingObectScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  var initIndex = 0;
  final RefreshController _refreshHistoryController =
      RefreshController(initialRefresh: false);
  final RefreshController _refreshFoundController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    int? year;
    int? month;

    if (arg != null) {
      year = arg['year'];
      month = arg['month'];
      initIndex = arg['index'];
    }
    tabController.index = initIndex;
    return ChangeNotifierProvider(
        create: (context) => MissingObjectPrv(year: year, month: month),
        builder: (context, state) {
          return PrimaryScreen(
              appBar: PrimaryAppbar(
                leading: BackButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, ServiceScreen.routeName),
                ),
                title: S.of(context).missing_obj,
                tabController: tabController,
                isTabScrollabel: false,
                tabs: [
                  Tab(text: S.of(context).history_find_obj),
                  Tab(text: S.of(context).found_object),
                ],
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Center(
                      child: PrimaryIcon(
                        icons: PrimaryIcons.filter,
                        onTap: () {
                          DatePicker.showPicker(
                            context,
                            onChanged: (v) {},
                            onConfirm: (v) {
                              context
                                  .read<MissingObjectPrv>()
                                  .onChooseMonthYear(v);
                              setState(() {
                                tabController.index = tabController.index;
                              });
                            },
                            pickerModel: CustomMonthPicker(
                                minTime:
                                    DateTime(DateTime.now().year - 10, 1, 1),
                                maxTime:
                                    DateTime(DateTime.now().year + 10, 12, 31),
                                currentTime: DateTime(
                                    context.read<MissingObjectPrv>().year!,
                                    context.read<MissingObjectPrv>().month!,
                                    1),
                                locale: LocaleType.vi),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                // tooltip: tabController.index == 0
                //     ? S.of(context).reg_missing_obj
                //     : S.of(context).found_object,
                onPressed: () {
                  if (tabController.index == 0) {
                    Navigator.pushNamed(
                      context,
                      RegisterLostItemScreen.routeName,
                    );
                  } else {
                    Navigator.pushNamed(
                      context,
                      PickItemScreen.routeName,
                    );
                  }
                },
                backgroundColor: primaryColorBase,
                child: const Icon(
                  Icons.add,
                  size: 40,
                ),
              ),
              body: FutureBuilder(
                  future:
                      context.read<MissingObjectPrv>().getLostItemList(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: PrimaryLoading());
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return PrimaryErrorWidget(
                          code: snapshot.hasError ? "err" : "1",
                          message: snapshot.data.toString(),
                          onRetry: () async {
                            setState(() {
                              initIndex = tabController.index;
                            });
                          });
                    }
                    return SafeArea(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          MissingObjectTab(
                            changeStatus:
                                (BuildContext ctx, MissingObject lost) =>
                                    context
                                        .read<MissingObjectPrv>()
                                        .saveLostItem(ctx, lost),
                            type: "HISTORY",
                            list: context.watch<MissingObjectPrv>().lostList,
                            refreshController: _refreshHistoryController,
                            onRefresh: () {
                              setState(() {
                                initIndex = tabController.index;
                              });
                            },
                          ),
                          PickedItemTab(
                            changeStatus: (BuildContext ctx, LootItem loot) =>
                                context
                                    .read<MissingObjectPrv>()
                                    .saveLootItem(ctx, loot),
                            type: "FOUND",
                            list: context.watch<MissingObjectPrv>().lootList,
                            refreshController: _refreshFoundController,
                            onRefresh: () {
                              setState(() {
                                initIndex = tabController.index;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }));
        });
  }
}
