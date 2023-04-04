// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/chat_data_view_model.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_loading.dart';
import '../prv/water_prv.dart';

class ConsummedWaterTab extends StatefulWidget {
  const ConsummedWaterTab({super.key});

  @override
  State<ConsummedWaterTab> createState() => _ConsummedWaterTabState();
}

class _ConsummedWaterTabState extends State<ConsummedWaterTab> {
  late TooltipBehavior _tooltipBehavior;
  final _selectionBehaviorLast = SelectionBehavior(
    selectedColor: yellowColor7,
    unselectedColor: yellowColor7.withOpacity(0.2),
    enable: true,
  );
  final _selectionBehaviorCurrent = SelectionBehavior(
    selectedColor: primaryColor7,
    unselectedColor: primaryColor7.withOpacity(0.2),
    enable: true,
  );
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
      future: context.read<WaterPrv>().getIndicatorByYear(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: PrimaryLoading());
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
        for (var i in context.watch<WaterPrv>().listIndicatorLastYear) {
          dataLast[i.month.toString()] = i.water_consumption;
        }

        for (var i in context.watch<WaterPrv>().listIndicatorCurrentYear) {
          dataCurent[i.month.toString()] = i.water_consumption;
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                vpad(30),
                // Expanded(
                //   child:
                SizedBox(
                  height: 800,
                  child: SfCartesianChart(
                    selectionGesture: ActivationMode.singleTap,
                    selectionType: SelectionType.point,
                    borderWidth: 0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    primaryXAxis: CategoryAxis(labelStyle: txtRegular(14)),
                    // primaryYAxis:
                    //     NumericAxis(minimum: 1, maximum: 20, interval: 1),
                    title: ChartTitle(
                      text: '${S.of(context).consumed_water_detail1} (m3)',
                      textStyle: txtBold(14, primaryColorBase),
                    ),
                    legend: Legend(
                      isVisible: true,
                      title: LegendTitle(
                        text: S.of(context).legend,
                      ),
                      toggleSeriesVisibility: false,
                    ),
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                      duration: 1000,
                      opacity: 0.7,
                    ),
                    series: <ChartSeries<ChartDataViewModel, String>>[
                      BarSeries<ChartDataViewModel, String>(
                        initialSelectedDataIndexes: [-1],
                        selectionBehavior: _selectionBehaviorLast,
                        borderRadius: BorderRadius.circular(12),
                        // spacing: 10,
                        color: yellowColor7,
                        dataSource: dataCharLast,
                        xValueMapper: (ChartDataViewModel sales, _) =>
                            sales.title,
                        yValueMapper: (ChartDataViewModel sales, _) =>
                            sales.num,
                        name: (context.watch<WaterPrv>().year - 1).toString(),
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          showZeroValue: false,
                          textStyle: txtBold(12, yellowColor7),
                          showCumulativeValues: true,
                        ),
                      ),
                      BarSeries<ChartDataViewModel, String>(
                        initialSelectedDataIndexes: [
                          context.read<WaterPrv>().month - 1
                        ],
                        selectionBehavior: _selectionBehaviorCurrent,
                        // spacing: 10,
                        borderRadius: BorderRadius.circular(12),
                        color: primaryColor7,
                        dataSource: dataCharCurrent,
                        xValueMapper: (ChartDataViewModel sales, _) =>
                            sales.title,
                        yValueMapper: (ChartDataViewModel sales, _) =>
                            sales.num,
                        name: context.watch<WaterPrv>().year.toString(),
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          showZeroValue: false,
                          textStyle: txtBold(12, primaryColor7),
                        ),
                      ),
                    ],
                  ),
                ),
                // ),
                vpad(20),
              ],
            ),
          ),
        );
      },
    );
  }
}
