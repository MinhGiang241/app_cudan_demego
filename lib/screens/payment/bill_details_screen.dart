import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/models/receipt.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../models/info_content_view.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_info_widget.dart';
import '../../widgets/primary_screen.dart';
import 'payment_screen.dart';
import 'widget/payment_item.dart';

class BillDetailsScreen extends StatelessWidget {
  const BillDetailsScreen({super.key});
  static const routeName = '/payment/bill-details';

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Receipt bill = arg['re'];
    String? payDate;
    double paid = 0;
    if (bill.transactions.isNotEmpty) {
      // var a = bill.transactions[0].createdTime;

      payDate = bill.transactions.map((e) => e.createdTime).reduce((a, e) {
        if (a!.compareTo(e!) > 0) {
          return a;
        } else {
          return e;
        }
      });
      paid = bill.transactions.fold(0, (a, b) => a += (b.payment_amount ?? 0));
    }

    var listContent = [
      InfoContentView(
        title: S.of(context).bill_name,
        content: bill.reason,
        contentStyle: txtBodySmallBold(color: grayScaleColorBase),
      ),
      InfoContentView(
        title: S.of(context).bill_code,
        content: bill.code ?? bill.id,
        contentStyle: txtBodySmallBold(color: grayScaleColorBase),
      ),
      if (bill.content != null)
        InfoContentView(
          title: S.of(context).content,
          content: bill.content ?? "",
          contentStyle: txtBodySmallBold(color: grayScaleColorBase),
        ),
      InfoContentView(
        title: S.of(context).total_bill,
        content: formatCurrency.format(bill.amount_due).replaceAll("₫", "VND"),
        contentStyle: txtBodySmallBold(color: grayScaleColorBase),
      ),
      if (bill.vat != null)
        InfoContentView(
          title: S.of(context).vat,
          content: bill.vat != null ? "${bill.vat} %" : '0 %',
          contentStyle: txtBodySmallBold(color: grayScaleColorBase),
        ),
      if (bill.discount_percent != null)
        InfoContentView(
          title: S.of(context).discount,
          content: bill.discount_percent != null
              ? bill.discount_type == "Value"
                  ? formatCurrency
                      .format(bill.discount_percent)
                      .replaceAll("₫", "VND")
                  : "${bill.discount_percent} %"
              : "0 VND",
          contentStyle: txtBodySmallBold(color: grayScaleColorBase),
        ),
      InfoContentView(
        title: S.of(context).total_pay,
        content: bill.amount != null
            ? formatCurrency.format(bill.amount!).replaceAll("₫", "VND")
            : '0 VND',
        contentStyle: txtBodySmallBold(color: grayScaleColorBase),
      ),
      InfoContentView(
        title: S.of(context).paid_payment,
        content: bill.amount_due != null
            ? formatCurrency.format(paid).replaceAll("₫", "VND")
            : '0 VND',
        contentStyle: txtBodySmallBold(color: grayScaleColorBase),
      ),
      // if (bill.payment_status != "PAID")
      InfoContentView(
        title: S.of(context).need_pay,
        content: bill.amount != null
            ? formatCurrency.format(bill.amount! - paid).replaceAll("₫", "VND")
            : '0 VND',
        contentStyle: txtBodySmallBold(color: grayScaleColorBase),
      ),
      if (bill.expiration_date != null)
        InfoContentView(
          title: S.of(context).due_bill,
          content: Utils.dateFormat(bill.expiration_date ?? "", 1),
          contentStyle: txtBodySmallBold(color: grayScaleColorBase),
        ),
      if (bill.transactions.isNotEmpty)
        InfoContentView(
          title: S.of(context).pay_date,
          content: Utils.dateFormat(payDate ?? "", 1),
          contentStyle: txtBodySmallBold(color: grayScaleColorBase),
        ),
    ];
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).bill_details,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 28),
            child: Column(
              children: [
                PrimaryInfoWidget(
                  listInfoView: listContent,
                ),
                vpad(20),
                if (bill.payment_status != "PAID")
                  PrimaryButton(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PaymentScreen.routeName,
                        arguments: {
                          "list": [bill],
                          "year": arg['year'],
                          "month": arg['month'],
                          "navigate": arg['navigate']
                        },
                      );
                    },
                    width: dvWidth(context) - 24,
                    text: S.of(context).pay,
                  ),
                vpad(30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
