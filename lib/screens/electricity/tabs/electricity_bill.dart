import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:merge_table/merge_table.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () {}(),
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
                vpad(20),
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
                vpad(20),
                PrimaryCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      children: [
                        vpad(30),
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
                              text: '${S.of(context).unit_price}',
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
                            genCell(text: "0.11"),
                            genCell(text: "0.11"),
                            genCell(text: "0.11"),
                            genCell(text: "0.11"),
                            genCell(text: "0.11"),
                          ],
                        ),
                        Row(
                          children: [
                            genCell(text: "", flex: 2),
                            genCell(text: "0.11"),
                            genCell(text: "0.11"),
                            genCell(text: "0.11"),
                          ],
                        ),
                        Row(
                          children: [
                            genCell(text: "", flex: 2),
                            genCell(text: "0.11"),
                            genCell(text: "0.11"),
                            genCell(text: "0.11"),
                          ],
                        ),
                        Row(
                          children: [
                            genCell(text: "${S.of(context).vat}:", flex: 3),
                            genCell(text: "0.11"),
                            genCell(text: "0.11"),
                          ],
                        ),
                        Row(
                          children: [
                            genCell(
                              text: "${S.of(context).total_money_to_pay}:",
                              flex: 4,
                            ),
                            genCell(text: "0.11"),
                          ],
                        ),
                        vpad(20),
                      ],
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
        height: height ?? 40,
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
          child: Text(
            text,
            style: style ?? txtRegular(12, grayScaleColorBase),
            // overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
