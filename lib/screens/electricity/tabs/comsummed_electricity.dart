// ignore_for_file: prefer_const_constructors, require_trailing_commas, unused_field

import 'package:auto_size_text/auto_size_text.dart';
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

        // ignore: unused_local_variable
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              vpad(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  hpad(30),
                  AutoSizeText(
                    '${S.of(context).consumed_elec_details} (kWh)',
                    style: txtBold(14, primaryColorBase),
                    maxLines: 1,
                  ),
                ],
              ),
              vpad(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  hpad(40),
                  Text(
                    '${S.of(context).year}: ${context.read<ElectricityPrv>().year}',
                    style: txtBold(12, Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              vpad(10),
              // Expanded(
              //   child:
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: dvHeight(context) - 300,
                    width: 850,
                    child: SfCartesianChart(
                      // selectionGesture: ActivationMode.singleTap,

                      borderWidth: 0,
                      margin: EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      primaryXAxis: CategoryAxis(labelStyle: txtRegular(12)),

                      legend: Legend(
                        isVisible: false,
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
                ),
              ),
              // ),
              vpad(20)
            ],
          ),
        );
      },
    );
  }
}
