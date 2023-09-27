// ignore_for_file: prefer_const_constructors

import 'package:app_cudan/screens/water/prv/water_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../widgets/choose_month_year.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_screen.dart';
import 'tabs/consummed_water_tab.dart';
import 'tabs/water_bill_tab.dart';
// import 'tabs/water_payment_tab.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});
  static const routeName = "/water";

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  var initIndex = 0;
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    if (arg != null && arg['init'] != null) {
      initIndex = arg['init'];
    }
    return ChangeNotifierProvider(
      create: (context) => WaterPrv(year: arg?['year'], month: arg?['month']),
      builder: (context, snapshot) {
        tabController.index = initIndex;
        return PrimaryScreen(
          isPadding: false,
          appBar: PrimaryAppbar(
            title: S.of(context).consumed_water,
            tabController: tabController,
            isTabScrollabel: false,
            tabs: [
              Tab(text: S.of(context).details),
              Tab(text: S.of(context).bills),
              // Tab(text: S.of(context).pay),
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
                          context.read<WaterPrv>().onChooseMonthYear(v);
                          setState(() {
                            // init = false;
                          });
                          /* Navigator.of(context).pop(); */
                        },
                        pickerModel: CustomMonthPicker(
                          minTime: DateTime(DateTime.now().year - 40, 1, 1),
                          maxTime: DateTime(DateTime.now().year, 12, 31),
                          currentTime: DateTime(
                            context.read<WaterPrv>().year!,
                            1,
                            1,
                          ),
                          custom: [1, 0, 0],
                          locale: LocaleType.vi,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: TabBarView(
              controller: tabController,
              children: [
                ConsummedWaterTab(),
                WaterBillTab(),
                // WaterPaymentTab(),
              ],
            ),
          ),
        );
      },
    );
  }
}
