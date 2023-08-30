import 'package:app_cudan/screens/services/parcel/prv/parcel_list_prv.dart';
import 'package:app_cudan/screens/services/parcel/tab/parcel_tab.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../generated/l10n.dart';
import '../../../widgets/choose_month_year.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../service_screen.dart';

class ParcelListScreen extends StatefulWidget {
  static const routeName = '/parcel';
  const ParcelListScreen({super.key});

  @override
  State<ParcelListScreen> createState() => _ParcelListScreenState();
}

class _ParcelListScreenState extends State<ParcelListScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  var initIndex = 0;
  bool init = true;
  final RefreshController _refreshWaitController =
      RefreshController(initialRefresh: false);
  final RefreshController _refreshReceiptedController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    if (arg != null && arg['initTab'] != null && init) {
      initIndex = arg['initTab'];
    }

    return ChangeNotifierProvider(
      create: (context) => ParcelListPrv(),
      builder: (context, state) {
        tabController.index = initIndex;
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            leading: BackButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                ServiceScreen.routeName,
              ),
            ),
            title: S.of(context).parcel,
            tabController: tabController,
            isTabScrollabel: false,
            tabs: [
              Tab(text: S.of(context).wait_receipt),
              Tab(text: S.of(context).receipted),
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
                          context.read<ParcelListPrv>().onChooseMonthYear(v);

                          setState(() {
                            init = false;
                            initIndex = tabController.index;
                          });
                        },
                        pickerModel: CustomMonthPicker(
                          minTime: DateTime(DateTime.now().year - 10, 1, 1),
                          maxTime: DateTime(DateTime.now().year + 10, 12, 31),
                          currentTime: DateTime(
                            context.read<ParcelListPrv>().year,
                            context.read<ParcelListPrv>().month,
                            1,
                          ),
                          locale: LocaleType.vi,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          body: FutureBuilder(
            future: context.read<ParcelListPrv>().getParcelList(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: PrimaryLoading());
              } else if (snapshot.connectionState == ConnectionState.none) {
                return PrimaryErrorWidget(
                  code: snapshot.hasError ? "err" : "1",
                  message: snapshot.data.toString(),
                  onRetry: () async {
                    setState(() {
                      initIndex = initIndex;
                    });
                  },
                );
              }

              return SafeArea(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ParcelTab(
                      type: 'WAIT',
                      list: context.watch<ParcelListPrv>().listWaitParcel,
                      onRefresh: () {
                        setState(() {
                          initIndex = tabController.index;
                        });
                      },
                      refreshController: _refreshWaitController,
                    ),
                    ParcelTab(
                      type: 'RECEIPTED',
                      list: context.watch<ParcelListPrv>().listReceiptedParcel,
                      onRefresh: () {
                        setState(() {
                          initIndex = tabController.index;
                        });
                      },
                      refreshController: _refreshReceiptedController,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
