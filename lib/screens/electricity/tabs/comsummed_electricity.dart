// ignore_for_file: prefer_const_constructors, require_trailing_commas

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/chat_data_view_model.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_loading.dart';
import '../prv/electricity_prv.dart';

class ConsummedElectricityTab extends StatefulWidget {
  const ConsummedElectricityTab({super.key});

  @override
  State<ConsummedElectricityTab> createState() =>
      _ConsummedElectricityTabState();
}

class _ConsummedElectricityTabState extends State<ConsummedElectricityTab> {
  late TooltipBehavior _tooltipBehavior;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<ElectricityPrv>().getIndicatorByYear(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const PrimaryLoading());
        } else if (snapshot.hasError) {
          return PrimaryErrorWidget(
            code: snapshot.hasError ? "err" : "1",
            message: snapshot.data.toString(),
            onRetry: () async {
              setState(() {});
            },
          );
        }

        var dataLast = {};
        var dataCurent = {};
        for (var i in context.read<ElectricityPrv>().listIndicatorLastYear) {
          dataLast[i.month.toString()] = i.electricity_head;
        }

        for (var i in context.read<ElectricityPrv>().listIndicatorCurrentYear) {
          dataCurent[i.month.toString()] = i.electricity_head;
        }

        List<ChartDataViewModel> dataCharLast = [
          ...List.generate(
            12,
            (index) => ChartDataViewModel(
              title: "${S.of(context).month} ${(index + 1).toString()}",
              num: dataLast[(index + 1).toString()] ?? 0,
            ),
          )
        ];

        List<ChartDataViewModel> dataCharCurrent = [
          ...List.generate(
            12,
            (index) => ChartDataViewModel(
              title: "${S.of(context).month} ${(index + 1).toString()}",
              num: dataCurent[(index + 1).toString()] ?? 0,
            ),
          )
        ];

        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropMaterialHeader(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          controller: _refreshController,
          onRefresh: () {
            setState(() {});
            _refreshController.refreshCompleted();
          },
          child: Column(
            children: [
              // vpad(30),
              // Center(
              //   child: Text(
              //     S.of(context).consumed_elec_details,
              //     style: txtBold(14, primaryColorBase),
              //   ),
              // ),
              vpad(30),
              Expanded(
                child: SizedBox(
                  height: 20,
                  child: SfCartesianChart(
                    borderWidth: 0,
                    margin: EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    primaryXAxis: CategoryAxis(labelStyle: txtRegular(14)),
                    // primaryYAxis:
                    //     NumericAxis(minimum: 1, maximum: 20, interval: 1),
                    title: ChartTitle(
                      text: '${S.of(context).consumed_elec_details} (kWh)',
                      textStyle: txtBold(14, primaryColorBase),
                    ),
                    legend: Legend(
                      isVisible: true,
                      title: LegendTitle(
                        text: S.of(context).legend,
                      ),
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<ChartDataViewModel, String>>[
                      BarSeries<ChartDataViewModel, String>(
                          borderRadius: BorderRadius.circular(12),
                          // spacing: 10,
                          color: yellowColor7,
                          dataSource: dataCharLast,
                          xValueMapper: (ChartDataViewModel sales, _) =>
                              sales.title,
                          yValueMapper: (ChartDataViewModel sales, _) =>
                              sales.num,
                          name: (context.watch<ElectricityPrv>().year - 1)
                              .toString(),
                          // Enable data label
                          dataLabelSettings:
                              DataLabelSettings(isVisible: true)),
                      BarSeries<ChartDataViewModel, String>(
                          // spacing: 10,
                          borderRadius: BorderRadius.circular(12),
                          color: primaryColor7,
                          dataSource: dataCharCurrent,
                          xValueMapper: (ChartDataViewModel sales, _) =>
                              sales.title,
                          yValueMapper: (ChartDataViewModel sales, _) =>
                              sales.num,
                          name: context.watch<ElectricityPrv>().year.toString(),
                          // Enable data label
                          dataLabelSettings:
                              DataLabelSettings(isVisible: true)),
                    ],
                  ),
                ),
              ),
              vpad(20)
            ],
          ),
        );
      },
    );
  }
}