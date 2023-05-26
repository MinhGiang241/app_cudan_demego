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
  var monthList = [
    S.current.th01,
    S.current.th02,
    S.current.th03,
    S.current.th04,
    S.current.th05,
    S.current.th06,
    S.current.th07,
    S.current.th08,
    S.current.th09,
    S.current.th10,
    S.current.th11,
    S.current.th12,
  ];
  final _selectionBehaviorLast = SelectionBehavior(
    selectedColor: yellowColor7,
    toggleSelection: false,
    unselectedColor: yellowColor7.withOpacity(0.1),
    enable: true,
  );
  final _selectionBehaviorCurrent = SelectionBehavior(
    selectedColor: primaryColor7,
    toggleSelection: false,
    unselectedColor: primaryColor7.withOpacity(0.1),
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
    var month = context.read<WaterPrv>().month;
    final ScrollController _scrollController = ScrollController(
      initialScrollOffset: (850 / 12) * (month! - 4),
      keepScrollOffset: true,
    );
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
              title: monthList[index],
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
                vpad(20),
                Row(
                  children: [
                    hpad(40),
                    Text('${S.of(context).consumed_water_detail1} (m³)',
                        style: txtBold(14, primaryColorBase)),
                  ],
                ),
                vpad(10),
                Row(
                  children: [
                    hpad(40),
                    Text(
                        '${S.of(context).year}: ${context.read<WaterPrv>().year}',
                        style: txtBold(12, Colors.black)),
                  ],
                ),
                vpad(30),
                // Expanded(
                //   child:
                SizedBox(
                  height: dvHeight(context) - 250,
                  width: 850,
                  child: SfCartesianChart(
                    //selectionGesture: ActivationMode.singleTap,
                    //selectionType: SelectionType.cluster,
                    borderWidth: 0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    primaryXAxis: CategoryAxis(labelStyle: txtRegular(12)),
                    // primaryYAxis:
                    //     NumericAxis(minimum: 1, maximum: 20, interval: 1),
                    // title: ChartTitle(
                    //   text: '${S.of(context).consumed_water_detail1} (m³)',
                    //   textStyle: txtBold(14, primaryColorBase),
                    // ),
                    legend: Legend(
                      isVisible: false,
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
                      // BarSeries<ChartDataViewModel, String>(
                      //   dataLabelMapper: (datum, index) {
                      //     return ('${datum.num?.toStringAsFixed(0)}');
                      //   },
                      //   initialSelectedDataIndexes: [
                      //     context.read<WaterPrv>().month! - 1
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
                      //   name: (context.watch<WaterPrv>().year! - 1).toString(),
                      //   // Enable data label
                      //   dataLabelSettings: DataLabelSettings(
                      //     isVisible: true,
                      //     showZeroValue: false,
                      //     textStyle: txtBold(12, yellowColor7),
                      //     showCumulativeValues: true,
                      //   ),
                      // ),
                      ColumnSeries<ChartDataViewModel, String>(
                        initialSelectedDataIndexes: [
                          context.read<WaterPrv>().month! - 1
                        ],
                        dataLabelMapper: (datum, index) {
                          return ('${datum.num?.toStringAsFixed(0)}');
                        },
                        selectionBehavior: _selectionBehaviorCurrent,
                        // spacing: 10,
                        // borderRadius: BorderRadius.circular(12),
                        color: primaryColor7,
                        dataSource: dataCharCurrent,
                        yValueMapper: (ChartDataViewModel sales, _) =>
                            sales.num,
                        xValueMapper: (ChartDataViewModel sales, _) =>
                            sales.title,
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
