import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/info_content_view.dart';
import '../../models/receipt.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_screen.dart';
import 'widget/payment_item.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static const routeName = '/payment/pay';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as List<Receipt>;
    var link = "assets/icons/vnpay.svg";
    var link1 = "assets/icons/paypal.svg";
    var value = 0;

    int sum = arg.fold(0, (a, b) => a + b.amount_due!);

    return PrimaryScreen(
      isPadding: false,
      appBar: PrimaryAppbar(
        title: S.of(context).pay,
      ),
      body: Stack(
        children: [
          ListView(children: [
            vpad(12),
            ...arg.map((e) {
              var listContent = [
                InfoContentView(
                  title: S.of(context).bill_name,
                  content: e.reason,
                  contentStyle: txtBold(13, grayScaleColorBase),
                ),
                InfoContentView(
                  title: S.of(context).bill_code,
                  content: e.id,
                  contentStyle: txtBold(13, grayScaleColorBase),
                ),
                if (e.content != null)
                  InfoContentView(
                    title: S.of(context).content,
                    content: e.content,
                    contentStyle: txtBold(13, grayScaleColorBase),
                  ),
                InfoContentView(
                  title: S.of(context).vat,
                  content: e.vat != null
                      ? formatCurrency.format(e.vat).replaceAll("₫", "VND")
                      : "0 VND",
                  contentStyle: txtBold(13, grayScaleColorBase),
                ),
                InfoContentView(
                  title: S.of(context).discount,
                  content: e.discount_money != null
                      ? formatCurrency
                          .format(e.discount_money)
                          .replaceAll("₫", "VND")
                      : "0 VND",
                  contentStyle: txtBold(13, grayScaleColorBase),
                ),
                InfoContentView(
                  title: S.of(context).to_money,
                  content: e.amount_due != null
                      ? formatCurrency
                          .format(e.amount_due)
                          .replaceAll("₫", "VND")
                      : "0 VND",
                  contentStyle: txtBold(13, grayScaleColorBase),
                ),
              ];
              return PrimaryCard(
                  margin:
                      const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                  padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
                  child: Row(
                    children: [
                      Transform.translate(
                        offset: const Offset(0.0, -65),
                        child: const PrimaryIcon(
                          icons: PrimaryIcons.spreadsheet,
                          style: PrimaryIconStyle.gradient,
                          gradients: PrimaryIconGradient.green,
                          size: 32,
                          padding: EdgeInsets.all(12),
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Table(
                          textBaseline: TextBaseline.ideographic,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.baseline,
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            ...listContent.map<TableRow>(
                              (e) => TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 16, left: 10),
                                    child: Text(
                                      '${e.title}:',
                                      style: txtMedium(12, grayScaleColor2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Text(e.content ?? "",
                                        style: e.contentStyle),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ));
            }),
            vpad(150),
          ]),
          Positioned(
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryCard(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border.symmetric(
                          horizontal:
                              BorderSide(width: 1, color: grayScaleColor5))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  height: 50,
                  width: dvWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${S.of(context).payment_method}:'),
                      PopupMenuButton(
                        onSelected: (v) {
                          setState(() {
                            value = v;
                          });
                        },
                        child: Row(
                          children: [
                            if (value == 0)
                              SvgPicture.asset(
                                link,
                                color: Colors.red,
                                width: 24,
                                height: 20,
                              ),
                            if (value == 1)
                              SvgPicture.asset(
                                link1,
                                color: Colors.blue,
                                width: 24,
                                height: 20,
                              ),
                            const Icon(Icons.expand_more),
                          ],
                        ),
                        itemBuilder: (_) => [
                          PopupMenuItem(
                              value: 0,
                              child: SvgPicture.asset(
                                link,
                                color: Colors.red,
                                width: 24,
                                height: 20,
                              )),
                          PopupMenuItem(
                              value: 1,
                              child: SvgPicture.asset(
                                link1,
                                color: Colors.blue,
                                width: 24,
                                height: 20,
                                allowDrawingOutsideViewBox: true,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                PrimaryCard(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border.symmetric(
                          horizontal:
                              BorderSide(width: 1, color: grayScaleColor4))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  height: 50,
                  width: dvWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${S.of(context).total}:",
                        // style: txtRegular(14, grayScaleColorBase),
                      ),
                      Text(
                        formatCurrency.format(sum).replaceAll("₫", "VND"),
                        style: txtBold(14, primaryColorBase),
                      )
                    ],
                  ),
                ),
                PrimaryButton(
                  width: dvWidth(context),
                  isRectangle: true,
                  text: S.of(context).pay,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
