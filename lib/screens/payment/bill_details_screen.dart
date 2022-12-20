import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/models/receipt.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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

    var listContent = [
      InfoContentView(
        title: S.of(context).bill_name,
        content: arg['re'].reason,
        contentStyle: txtBodySmallBold(color: grayScaleColorBase),
      ),
      InfoContentView(
        title: S.of(context).bill_code,
        content: arg['re'].id ?? "",
        contentStyle: txtBodySmallBold(color: grayScaleColorBase),
      ),
      if (arg['re'].content != null)
        InfoContentView(
          title: S.of(context).content,
          content: arg['re'].content ?? "",
          contentStyle: txtBodySmallBold(color: grayScaleColorBase),
        ),
      InfoContentView(
        title: S.of(context).vat,
        content: arg['re'].vat != null
            ? formatCurrency.format(arg['re'].vat).replaceAll("₫", "VND")
            : '0 VND',
        contentStyle: txtBodySmallBold(color: grayScaleColorBase),
      ),
      InfoContentView(
        title: S.of(context).to_money,
        content: arg['re'].amount_due != null
            ? formatCurrency.format(arg['re'].amount_due).replaceAll("₫", "VND")
            : '0 VND',
        contentStyle: txtBodySmallBold(color: grayScaleColorBase),
      ),
      InfoContentView(
        title: S.of(context).due_bill,
        content: Utils.dateFormat(arg['re'].date ?? "", 1),
        contentStyle: txtBodySmallBold(color: grayScaleColorBase),
      ),
      if (arg['re'].transactions.isNotEmpty)
        InfoContentView(
          title: S.of(context).pay_date,
          content:
              Utils.dateFormat(arg['re'].transactions[0].createdTime ?? "", 1),
          contentStyle: txtBodySmallBold(color: grayScaleColorBase),
        ),
    ];
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).bill_details,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 28),
          child: Stack(
            children: [
              PrimaryInfoWidget(
                listInfoView: listContent,
              ),
              if (arg['re'].payment_status != "PAID")
                Positioned(
                    bottom: 10,
                    child: PrimaryButton(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PaymentScreen.routeName,
                          arguments: {
                            "list": [arg['re'] as Receipt],
                            "year": arg['year'],
                            "month": arg['month']
                          },
                        );
                      },
                      width: dvWidth(context) - 24,
                      text: S.of(context).pay,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
