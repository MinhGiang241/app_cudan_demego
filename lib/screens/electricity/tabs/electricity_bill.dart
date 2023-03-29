// ignore_for_file: require_trailing_commas

import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/choose_month_year.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_loading.dart';
import '../prv/electricity_prv.dart';

class ElectricityBillTab extends StatefulWidget {
  const ElectricityBillTab({super.key});

  @override
  State<ElectricityBillTab> createState() => _ElectricityBillTabState();
}

class _ElectricityBillTabState extends State<ElectricityBillTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var formatter = NumberFormat('#,###,###');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<ElectricityPrv>().getDataBill(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: PrimaryLoading(),
          );
        } else if (snapshot.hasError) {
          return PrimaryErrorWidget(
            code: snapshot.hasError ? "err" : "1",
            message: snapshot.data.toString(),
            onRetry: () async {
              setState(() {});
            },
          );
        }
        var lastIndicator = context.read<ElectricityPrv>().indicatorLastMonth;
        var currentIndicator =
            context.read<ElectricityPrv>().indicatorCurrentMonth;
        double totalIndex = currentIndicator?.electricity_head ??
            0.0 - (lastIndicator?.electricity_head ?? 0.0);
        var list = [];

        double index = totalIndex;
        var elecFee = context.read<ElectricityPrv>().electricFee?.electric_fee;
        List<double> elecFeeTo = elecFee?.map((e) => e.to!).toList() ?? [];
        elecFeeTo.sort((a, b) => a.compareTo(b));
        for (var i in elecFeeTo) {
          index = index - i;
          if (index < 0) {
            list.add(index + i);
            break;
          } else if (i == elecFeeTo.last) {
            list.add(index + i);
            break;
          } else {
            list.add(i);
          }
        }
        var month = context.watch<ElectricityPrv>().month;
        var year = context.watch<ElectricityPrv>().year;

        var startMonth = DateTime(year, month, 1);
        var endMonth = DateTime(year, month + 1, 0);
        var totalMoney = list
            .asMap()
            .entries
            .fold(0.0, (a, b) => a + b.value * elecFeeTo[b.key]);
        var vat = totalMoney * 1.0;
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                vpad(20),
                Text(
                  S.of(context).bill_details,
                  style: txtBold(14, primaryColorBase),
                ),
                vpad(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).bill_name,
                      style: txtBold(14, redColorBase),
                    ),
                    PrimaryIcon(
                      onTap: () {
                        DatePicker.showPicker(
                          context,
                          onChanged: (v) {},
                          onConfirm: (v) {
                            context.read<ElectricityPrv>().onChooseMonthBill(v);
                            setState(() {});
                          },
                          pickerModel: CustomMonthPicker(
                            minTime: DateTime(DateTime.now().year - 40, 1, 1),
                            maxTime: DateTime(DateTime.now().year, 12, 31),
                            currentTime: DateTime(
                              context.read<ElectricityPrv>().year,
                              context.read<ElectricityPrv>().month,
                              1,
                            ),
                            custom: [0, 1, 0],
                            locale: LocaleType.vi,
                          ),
                        );
                      },
                      icons: PrimaryIcons.filter,
                    ),
                  ],
                ),
                vpad(10),
                Expanded(
                  child: SingleChildScrollView(
                    child: PrimaryCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              vpad(12),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      S.of(context).bill_from_to(
                                            Utils.dateFormat(
                                              startMonth.toIso8601String(),
                                              0,
                                            ),
                                            Utils.dateFormat(
                                              endMonth.toIso8601String(),
                                              0,
                                            ),
                                          ),
                                      style: txtRegular(14, grayScaleColorBase),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${formatter.format(totalIndex)} kWh',
                                        style: txtBold(14, redColorBase),
                                      ))
                                ],
                              ),
                              vpad(12),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      S.of(context).meter_code,
                                      style: txtRegular(14, grayScaleColorBase),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '12345678',
                                        style: txtBold(
                                          14,
                                        ),
                                      ))
                                ],
                              ),
                              vpad(12),
                              Row(
                                children: [
                                  genCell(
                                    text: S.of(context).new_index,
                                    flex: 1,
                                    style: txtRegular(12, primaryColorBase),
                                    height: 80,
                                  ),
                                  genCell(
                                    text: S.of(context).old_index,
                                    flex: 1,
                                    style: txtRegular(12, primaryColorBase),
                                    height: 80,
                                  ),
                                  genCell(
                                    text: "${S.of(context).consume_elec} (kWh)",
                                    flex: 1,
                                    style: txtRegular(12, primaryColorBase),
                                    height: 80,
                                  ),
                                  genCell(
                                    text: S.of(context).unit_price,
                                    flex: 1,
                                    style: txtRegular(12, primaryColorBase),
                                    height: 80,
                                  ),
                                  genCell(
                                    text: '${S.of(context).to_money} (VNĐ)',
                                    flex: 1,
                                    style: txtRegular(12, primaryColorBase),
                                    height: 80,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  genCell(
                                    text: formatter
                                        .format(
                                          lastIndicator?.electricity_head ?? 0,
                                        )
                                        .toString(),
                                  ),
                                  genCell(
                                    text: formatter
                                        .format(
                                          currentIndicator?.electricity_head ??
                                              0,
                                        )
                                        .toString(),
                                  ),
                                  genCell(
                                    text: formatter
                                        .format(
                                          totalIndex,
                                        )
                                        .toString(),
                                  ),
                                  genCell(text: ""),
                                  genCell(text: ""),
                                ],
                              ),
                              ...List.generate(
                                list.length,
                                (index) => Row(
                                  children: [
                                    genCell(text: '', flex: 2),
                                    genCell(
                                      text: formatter
                                          .format(list[index])
                                          .toString(),
                                    ),
                                    genCell(
                                      text: formatter
                                          .format(elecFee![index].price)
                                          .toString(),
                                    ),
                                    genCell(
                                      text: formatter
                                          .format(
                                            list[index] * elecFee[index].price,
                                          )
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  genCell(
                                    text: "${S.of(context).vat}:",
                                    flex: 3,
                                  ),
                                  genCell(text: "10%"),
                                  genCell(
                                      text: formatter.format(vat).toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  genCell(
                                    text:
                                        "${S.of(context).total_money_to_pay}:",
                                    flex: 4,
                                  ),
                                  genCell(
                                      text: formatter
                                          .format(totalMoney)
                                          .toString()),
                                ],
                              ),
                              vpad(20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  genCell({
    required String text,
    int? flex,
    TextStyle? style,
    BoxBorder? border,
    double? height,
  }) {
    return Expanded(
      flex: flex ?? 1,
      child: Container(
        height: height ?? 50,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        decoration: BoxDecoration(
          border: border ??
              const Border.symmetric(
                horizontal: BorderSide(
                  width: 1,
                ),
                vertical: BorderSide(width: 1),
              ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: AutoSizeText(
            text,
            maxLines: 4,
            style: style ?? txtRegular(12, grayScaleColorBase),
          ),
          // Text(
          //   text,

          //   style: style ?? txtRegular(12, grayScaleColorBase),
          //   // overflow: TextOverflow.ellipsis,
          // ),
        ),
      ),
    );
  }
}
