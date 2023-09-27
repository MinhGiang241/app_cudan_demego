// ignore_for_file: prefer_const_constructors

// import 'package:app_cudan/screens/electricity/tabs/electric_payment_tab.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../widgets/choose_month_year.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_screen.dart';
import 'prv/electricity_prv.dart';
import 'tabs/comsummed_electricity.dart';
import 'tabs/electricity_bill.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});
  static const routeName = "/electricity";

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen>
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
      create: (context) =>
          ElectricityPrv(year: arg?['year'], month: arg?['month']),
      builder: (context, snapshot) {
        tabController.index = initIndex;

        return PrimaryScreen(
          isPadding: false,
          appBar: PrimaryAppbar(
            title: S.of(context).consume_elec,
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
                          context.read<ElectricityPrv>().onChooseMonthYear(v);
                          setState(() {
                            initIndex = tabController.index;
                            // init = false;
                          });
                          /* Navigator.of(context).pop(); */
                        },
                        pickerModel: CustomMonthPicker(
                          minTime: DateTime(DateTime.now().year - 40, 1, 1),
                          maxTime: DateTime(DateTime.now().year, 12, 31),
                          currentTime: DateTime(
                            context.read<ElectricityPrv>().year!,
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
                ConsummedElectricityTab(),
                ElectricityBillTab(),
                // ElectricityPaymentTab(),
              ],
            ),
          ),
        );
      },
    );
  }
}
