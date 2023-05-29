import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/waterFee.dart';
import '../../../utils/utils.dart';
import '../../../widgets/choose_month_year.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../auth/prv/resident_info_prv.dart';
import '../prv/water_prv.dart';

class WaterBillTab extends StatefulWidget {
  const WaterBillTab({super.key});

  @override
  State<WaterBillTab> createState() => _WaterBillTabState();
}

class _WaterBillTabState extends State<WaterBillTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var formatter = NumberFormat('#,###,###');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<WaterPrv>().getDataBill(context),
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
        var receipt = context.watch<WaterPrv>().receiptMonth;
        var indi = receipt?.indicator;

        double totalIndex = indi?.water_consumption ?? 0;
        var list = [];
        var waterFeeConfig =
            receipt != null ? WaterFee.fromMap(receipt.fee_config) : null;
        double index = totalIndex;
        var waterFee = waterFeeConfig?.water_fee;
        waterFee?.sort((a, b) => a.to!.compareTo(b.to!));
        List<double> waterTo = waterFee?.map((e) => e.to!).toList() ?? [];
        waterTo.sort((a, b) => a.compareTo(b));
        // for (var i in waterTo) {
        //   index = index - i;
        //   if (index < 0) {
        //     list.add(index + i);
        //     break;
        //   } else if (i == waterTo.last) {
        //     list.add(index + i);
        //     break;
        //   } else {
        //     list.add(i);
        //   }
        // }
        for (var i = 0; i < waterTo.length; i++) {
          if (index >= waterTo[i] && i != waterTo.length - 1) {
            list.add(waterTo[i] - (i == 0 ? 0 : waterTo[i - 1]));
          } else if (index <= waterTo[i]) {
            var h = index - waterTo[i - 1];
            if (h != 0) {
              list.add(h);
            }

            break;
          } else if (index >= waterTo[i] && i == waterTo.length - 1) {
            list.add(index - waterTo[i]);
          }
        }
        var month = context.watch<WaterPrv>().month;
        var year = context.watch<WaterPrv>().year;

        var startMonth = DateTime(year!, month!, 1);
        var endMonth = DateTime(year, month + 1, 0);
        var totalMoney = list.asMap().entries.fold(0.0, (a, b) {
          var price = waterFee![b.key].price ?? 0;

          return a + b.value * price;
        });
        var vat = totalMoney * (receipt?.vat ?? 0) / 100;
        var totalMoneyVat = totalMoney + vat;
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
                  S.of(context).details_bill,
                  style: txtBold(14, primaryColorBase),
                ),
                vpad(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${S.of(context).month} $month, $year",
                      style: txtBold(14, redColorBase),
                    ),
                    PrimaryIcon(
                      onTap: () {
                        DatePicker.showPicker(
                          context,
                          onChanged: (v) {},
                          onConfirm: (v) {
                            context.read<WaterPrv>().onChooseMonthBill(v);
                            setState(() {});
                          },
                          pickerModel: CustomMonthPicker(
                            minTime: DateTime(DateTime.now().year - 40, 1, 1),
                            maxTime: DateTime(DateTime.now().year, 12, 31),
                            currentTime: DateTime(
                              context.read<WaterPrv>().year!,
                              context.read<WaterPrv>().month!,
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
                                      '${formatter.format(indi?.water_consumption ?? 0)} m³',
                                      style: txtBold(14, redColorBase),
                                    ),
                                  )
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
                                      context
                                              .read<ResidentInfoPrv>()
                                              .selectedApartment
                                              ?.apartment
                                              ?.water_code ??
                                          "",
                                      style: txtBold(
                                        14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              vpad(12),
                              if (receipt != null)
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
                                      text:
                                          "${S.of(context).consumed_water} (m³)",
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
                              if (receipt != null)
                                Row(
                                  children: [
                                    genCell(
                                      text: formatter
                                          .format(
                                            indi?.water_head ?? 0,
                                          )
                                          .toString(),
                                    ),
                                    genCell(
                                      text: formatter
                                          .format(
                                            indi?.water_last ?? 0,
                                          )
                                          .toString(),
                                    ),
                                    genCell(
                                      text: formatter
                                          .format(
                                            indi?.water_consumption ?? 0,
                                          )
                                          .toString(),
                                    ),
                                    genCell(text: ""),
                                    genCell(text: ""),
                                  ],
                                ),
                              if (receipt != null)
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
                                            .format(waterFee![index].price)
                                            .toString(),
                                      ),
                                      genCell(
                                        text: formatter
                                            .format(
                                              list[index] *
                                                  waterFee[index].price,
                                            )
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              if (receipt != null)
                                Row(
                                  children: [
                                    genCell(
                                      text: "${S.of(context).vat}:",
                                      flex: 3,
                                      align: Alignment.centerRight,
                                    ),
                                    genCell(
                                        text:
                                            "${formatter.format(receipt.vat ?? 0)}%"),
                                    genCell(
                                      text: formatter.format(vat).toString(),
                                    ),
                                  ],
                                ),
                              if (receipt != null)
                                Row(
                                  children: [
                                    genCell(
                                      text:
                                          "${S.of(context).total_money_to_pay}:",
                                      flex: 4,
                                    ),
                                    genCell(
                                      text: formatter
                                          .format(totalMoneyVat)
                                          .toString(),
                                    ),
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
    AlignmentGeometry? align,
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
          alignment: align ?? Alignment.center,
          child: AutoSizeText(
            text,
            maxLines: 4,
            style: style ??
                txtRegular(
                  12,
                  grayScaleColorBase,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
