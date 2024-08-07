// ignore_for_file: require_trailing_commas

import 'package:app_cudan/services/api_payment.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/info_content_view.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_screen.dart';
import 'prv/payment_prv.dart';
import 'widget/payment_item.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static const routeName = '/payment/pay';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return ChangeNotifierProvider(
        create: (context) => PaymentPrv(
            listReceipts: arg['list'],
            ctx: context,
            year: arg['year'],
            month: arg['month'],
            navigate: arg['navigate']),
        builder: (context, state) {
          return PrimaryScreen(
            isPadding: false,
            appBar: PrimaryAppbar(
              title: S.of(context).pay,
            ),
            body: context.watch<PaymentPrv>().isConfirm
                ? FutureBuilder(future: () async {
                    // await APIPayment.getReceipt(arg['list'][0].id).then((v) {
                    //   context.read<PaymentPrv>().setPayment(v);
                    // });
                  }(), builder: (context, snapshot) {
                    return SafeArea(
                      child: Column(
                        children: [
                          PrimaryCard(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border.symmetric(
                                    horizontal: BorderSide(
                                        width: 1, color: grayScaleColor5))),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            height: 50,
                            width: dvWidth(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${S.of(context).payment_method}:'),
                                PopupMenuButton(
                                  onSelected: (v) {
                                    context.read<PaymentPrv>().changeValue(v);
                                  },
                                  child: Row(
                                    children: [
                                      if (context.watch<PaymentPrv>().value ==
                                          0)
                                        SvgPicture.asset(
                                          context.read<PaymentPrv>().link,
                                          color: Colors.red,
                                          width: 24,
                                          height: 20,
                                        ),
                                      if (context.watch<PaymentPrv>().value ==
                                          1)
                                        SvgPicture.asset(
                                          context.read<PaymentPrv>().link1,
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
                                          context.read<PaymentPrv>().link,
                                          color: Colors.red,
                                          width: 24,
                                          height: 20,
                                        )),
                                    PopupMenuItem(
                                        value: 1,
                                        child: SvgPicture.asset(
                                          context.read<PaymentPrv>().link1,
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
                                    horizontal: BorderSide(
                                        width: 1, color: grayScaleColor4))),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
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
                                  formatCurrency
                                      .format(context.read<PaymentPrv>().sum)
                                      .replaceAll("₫", "VND"),
                                  style: txtBold(14, primaryColorBase),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                : Stack(
                    children: [
                      SafeArea(
                        child: SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: false,
                            header: WaterDropMaterialHeader(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            controller: _refreshController,
                            onRefresh: () async {
                              await APIPayment.getReceipt(arg['list'][0].id)
                                  .then((v) {
                                context.read<PaymentPrv>().setPayment(v);
                              });

                              setState(() {});

                              _refreshController.refreshCompleted();
                            },
                            child: ListView(children: [
                              vpad(12),
                              ...context
                                  .read<PaymentPrv>()
                                  .listReceipts
                                  .map((e) {
                                double paid = 0;
                                if (e.transactions.isNotEmpty) {
                                  paid = e.transactions.fold(0,
                                      (a, b) => a += (b.payment_amount ?? 0));
                                }
                                var listContent = [
                                  InfoContentView(
                                    title: S.of(context).bill_name,
                                    content: e.reason,
                                    contentStyle:
                                        txtBold(13, grayScaleColorBase),
                                  ),
                                  InfoContentView(
                                    title: S.of(context).bill_code,
                                    content: e.code ?? e.id,
                                    contentStyle:
                                        txtBold(13, grayScaleColorBase),
                                  ),
                                  if (e.content != null)
                                    InfoContentView(
                                      title: S.of(context).content,
                                      content: e.content,
                                      contentStyle:
                                          txtBold(13, grayScaleColorBase),
                                    ),

                                  InfoContentView(
                                    title: S.of(context).total_bill,
                                    content: e.amount_due != null
                                        ? formatCurrency
                                            .format(e.amount_due)
                                            .replaceAll("₫", "VND")
                                        : "0 VND",
                                    contentStyle:
                                        txtBold(13, grayScaleColorBase),
                                  ),
                                  if (e.vat != null)
                                    InfoContentView(
                                      title: S.of(context).vat,
                                      content:
                                          e.vat != null ? "${e.vat} %" : "0 %",
                                      contentStyle:
                                          txtBold(13, grayScaleColorBase),
                                    ),
                                  if (e.discount_percent != null)
                                    InfoContentView(
                                      title: S.of(context).discount,
                                      content: e.discount_percent != null
                                          ? e.discount_type == "Value"
                                              ? formatCurrency
                                                  .format(e.discount_percent)
                                                  .replaceAll("₫", "VND")
                                              : "${e.discount_percent} %"
                                          : "0 VND",
                                      contentStyle:
                                          txtBold(13, grayScaleColorBase),
                                    ),
                                  // InfoContentView(
                                  //   title: S.of(context).discount_type,
                                  //   content: e.discount_type == "Value"
                                  //       ? S.of(context).value
                                  //       : S.of(context).percent,
                                  //   contentStyle: txtBold(13, grayScaleColorBase),
                                  // ),
                                  InfoContentView(
                                    title: S.of(context).total_pay,
                                    content: e.amount != null
                                        ? formatCurrency
                                            .format(e.amount!)
                                            .replaceAll("₫", "VND")
                                        : '0 VND',
                                    contentStyle:
                                        txtBold(13, grayScaleColorBase),
                                  ),
                                  InfoContentView(
                                    title: S.of(context).paid_payment,
                                    content: e.amount_due != null
                                        ? formatCurrency
                                            .format(paid)
                                            .replaceAll("₫", "VND")
                                        : '0 VND',
                                    contentStyle:
                                        txtBold(13, grayScaleColorBase),
                                  ),
                                  InfoContentView(
                                    title: S.of(context).need_pay,
                                    content: e.amount != null
                                        ? formatCurrency
                                            .format(e.amount! - paid)
                                            .replaceAll("₫", "VND")
                                        : '0 VND',
                                    contentStyle:
                                        txtBold(13, grayScaleColorBase),
                                  ),
                                ];
                                return PrimaryCard(
                                    margin: const EdgeInsets.only(
                                        bottom: 16, left: 24, right: 24),
                                    padding: const EdgeInsets.only(
                                        top: 16, left: 12, right: 12),
                                    child: Row(
                                      children: [
                                        Transform.translate(
                                          offset: const Offset(0.0, -65),
                                          child: const PrimaryIcon(
                                            icons: PrimaryIcons.spreadsheet,
                                            style: PrimaryIconStyle.gradient,
                                            gradients:
                                                PrimaryIconGradient.green,
                                            size: 32,
                                            padding: EdgeInsets.all(12),
                                            color: Colors.white,
                                          ),
                                        ),
                                        Expanded(
                                          child: Table(
                                            textBaseline:
                                                TextBaseline.ideographic,
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .baseline,
                                            columnWidths: const {
                                              0: FlexColumnWidth(2),
                                              1: FlexColumnWidth(3),
                                            },
                                            children: [
                                              ...listContent.map<TableRow>(
                                                (e) => TableRow(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 16,
                                                              left: 10),
                                                      child: Text(
                                                        '${e.title}:',
                                                        style: txtMedium(12,
                                                            grayScaleColor2),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 16),
                                                      child: Text(
                                                          e.content ?? "",
                                                          style:
                                                              e.contentStyle),
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
                            ])),
                      ),
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
                                      horizontal: BorderSide(
                                          width: 1, color: grayScaleColor5))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              height: 50,
                              width: dvWidth(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${S.of(context).payment_method}:'),
                                  PopupMenuButton(
                                    onSelected: (v) {
                                      context.read<PaymentPrv>().changeValue(v);
                                    },
                                    child: Row(
                                      children: [
                                        if (context.watch<PaymentPrv>().value ==
                                            0)
                                          SvgPicture.asset(
                                            context.read<PaymentPrv>().link,
                                            color: Colors.red,
                                            width: 24,
                                            height: 20,
                                          ),
                                        if (context.watch<PaymentPrv>().value ==
                                            1)
                                          SvgPicture.asset(
                                            context.read<PaymentPrv>().link1,
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
                                            context.read<PaymentPrv>().link,
                                            color: Colors.red,
                                            width: 24,
                                            height: 20,
                                          )),
                                      PopupMenuItem(
                                          value: 1,
                                          child: SvgPicture.asset(
                                            context.read<PaymentPrv>().link1,
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
                                      horizontal: BorderSide(
                                          width: 1, color: grayScaleColor4))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              height: 50,
                              width: dvWidth(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${S.of(context).total}:",
                                    // style: txtRegular(14, grayScaleColorBase),
                                  ),
                                  Text(
                                    formatCurrency
                                        .format(context.read<PaymentPrv>().sum)
                                        .replaceAll("₫", "VND"),
                                    style: txtBold(14, primaryColorBase),
                                  )
                                ],
                              ),
                            ),
                            PrimaryButton(
                              buttonType: ButtonType.secondary,
                              secondaryBackgroundColor: grayScaleColor4,
                              onTap: () {
                                //  context.read<PaymentPrv>().changeConfirm();
                                // context.read<PaymentPrv>().onEnterPin(context);
                              },
                              width: dvWidth(context),
                              isRectangle: true,
                              text: S.of(context).pay,
                            )
                          ],
                        ),
                      ),
                      if (context.watch<PaymentPrv>().isSendLoading)
                        Positioned(
                          child: Container(
                            width: dvWidth(context),
                            height: dvHeight(context),
                            color: grayScaleColor1.withOpacity(0.3),
                            child: const Center(
                              child: PrimaryLoading(
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
          );
        });
  }
}
