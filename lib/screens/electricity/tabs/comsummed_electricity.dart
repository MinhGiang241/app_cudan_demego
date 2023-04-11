// ignore_for_file: prefer_const_constructors, require_trailing_commas

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
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

  final _selectionBehaviorLast = SelectionBehavior(
      selectedColor: yellowColor7,
      toggleSelection: false,
      unselectedColor: yellowColor7.withOpacity(0.1),
      enable: true);
  final _selectionBehaviorCurrent = SelectionBehavior(
      selectedColor: primaryColor7,
      toggleSelection: false,
      unselectedColor: primaryColor7.withOpacity(0.1),
      enable: true);
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) =>
    //     _scrollController.animateTo(_scrollController.position.maxScrollExtent,
    //         duration: const Duration(milliseconds: 500),
    //         curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    var month = context.read<ElectricityPrv>().month;
    final ScrollController _scrollController = ScrollController(
      initialScrollOffset: (850 / 12) * (month! - 4),
      keepScrollOffset: true,
    );
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
        for (var i in context.watch<ElectricityPrv>().listIndicatorLastYear) {
          dataLast[i.month.toString()] = i.electricity_consumption;
        }

        for (var i
            in context.watch<ElectricityPrv>().listIndicatorCurrentYear) {
          dataCurent[i.month.toString()] = i.electricity_consumption;
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
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                vpad(30),
                // Expanded(
                //   child:
                SizedBox(
                  height: dvHeight(context) - 200,
                  width: 850,
                  child: SfCartesianChart(
                    // selectionGesture: ActivationMode.singleTap,

                    borderWidth: 0,
                    margin: EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    primaryXAxis: CategoryAxis(labelStyle: txtRegular(12)),
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
                      toggleSeriesVisibility: false,
                    ),
                    selectionType: SelectionType.cluster,

                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                      duration: 1000,
                      opacity: 0.7,
                    ),
                    series: <ChartSeries<ChartDataViewModel, String>>[
                      // BarSeries<ChartDataViewModel, String>(
                      //   dataLabelMapper: (datum, index) {
                      //     return ('${datum.num?.toStringAsFixed(0)}');
                      //   },
                      //   initialSelectedDataIndexes: [
                      //     context.read<ElectricityPrv>().month! - 1
                      //   ],
                      //   selectionBehavior: _selectionBehaviorLast,
                      //   borderRadius: BorderRadius.circular(12),
                      //   // spacing: 10,
                      //   color: yellowColor7,
                      //   dataSource: dataCharLast,
                      //   xValueMapper: (ChartDataViewModel sales, _) =>
                      //       sales.title,
                      //   yValueMapper: (ChartDataViewModel sales, _) =>
                      //       sales.num,
                      //   name: (context.watch<ElectricityPrv>().year! - 1)
                      //       .toString(),
                      //   // Enable data label
                      //   dataLabelSettings: DataLabelSettings(
                      //     isVisible: true,
                      //     showZeroValue: false,
                      //     textStyle: txtBold(12, yellowColor7),
                      //   ),
                      // ),
                      ColumnSeries<ChartDataViewModel, String>(
                        dataLabelMapper: (datum, index) {
                          return ('${datum.num?.toStringAsFixed(0)}');
                        },
                        initialSelectedDataIndexes: [
                          context.read<ElectricityPrv>().month! - 1
                        ],
                        selectionBehavior: _selectionBehaviorCurrent,
                        // spacing: 10,
                        // borderRadius: BorderRadius.circular(12),
                        color: primaryColor7,
                        dataSource: dataCharCurrent,
                        yValueMapper: (ChartDataViewModel sales, _) =>
                            sales.num,
                        xValueMapper: (ChartDataViewModel sales, _) =>
                            sales.title,
                        name: context.watch<ElectricityPrv>().year.toString(),
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
                vpad(20)
              ],
            ),
          ),
        );
      },
    );
  }
}
