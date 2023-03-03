import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_construction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../models/receipt.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_info_widget.dart';
import '../../../../widgets/primary_loading.dart';
import '../../../payment/payment_screen.dart';
import '../../../payment/widget/payment_item.dart';

class ConstructionBillTab extends StatefulWidget {
  const ConstructionBillTab(
      {super.key,
      required this.constructionregistrationId,
      required this.isPay});
  final String constructionregistrationId;
  final bool isPay;

  @override
  State<ConstructionBillTab> createState() => _ConstructionBillTabState();
}

class _ConstructionBillTabState extends State<ConstructionBillTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    var residentId = context.read<ResidentInfoPrv>().residentId;
    List<Receipt> listReceipts = [];
    return SafeArea(
      child: FutureBuilder(
        future: () async {
          var data = await APIConstruction.getConstructionReceipts(
              widget.constructionregistrationId, residentId);
          listReceipts.clear();
          for (var i in data) {
            listReceipts.add(Receipt.fromJson(i));
          }
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: PrimaryLoading());
          } else if (snapshot.connectionState == ConnectionState.none) {
            return PrimaryErrorWidget(
                code: snapshot.hasError ? "err" : "1",
                message: snapshot.data.toString(),
                onRetry: () async {
                  setState(() {});
                  // init = false;
                });
          } else if (listReceipts.isEmpty) {
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(
                  backgroundColor: Theme.of(context).primaryColor),
              controller: _refreshController,
              onRefresh: () {
                setState(() {});
                _refreshController.refreshCompleted();
              },
              child: PrimaryEmptyWidget(
                emptyText: S.of(context).no_bill,
                icons: PrimaryIcons.credit,
                action: () {},
              ),
            );
          }
          return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(
                  backgroundColor: Theme.of(context).primaryColor),
              controller: _refreshController,
              onRefresh: () {
                setState(() {});
                _refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...listReceipts.map(
                      (e) {
                        String? payDate;
                        double paid = 0;
                        if (e.transactions.isNotEmpty) {
                          // var a = bill.transactions[0].createdTime;

                          payDate = e.transactions
                              .map((e) => e.createdTime)
                              .reduce((a, e) {
                            if (a!.compareTo(e!) > 0) {
                              return a;
                            } else {
                              return e;
                            }
                          });
                          paid = e.transactions
                              .fold(0, (a, b) => a += (b.payment_amount ?? 0));
                        }
                        var listContent = [
                          InfoContentView(
                            title: S.of(context).bill_name,
                            content: e.reason,
                            contentStyle:
                                txtBodySmallBold(color: grayScaleColorBase),
                          ),
                          InfoContentView(
                            title: S.of(context).bill_code,
                            content: e.code ?? e.id,
                            contentStyle:
                                txtBodySmallBold(color: grayScaleColorBase),
                          ),
                          if (e.content != null)
                            InfoContentView(
                              title: S.of(context).content,
                              content: e.content ?? "",
                              contentStyle:
                                  txtBodySmallBold(color: grayScaleColorBase),
                            ),
                          InfoContentView(
                            title: S.of(context).total_bill,
                            content: formatCurrency
                                .format(e.amount_due)
                                .replaceAll("₫", "VND"),
                            contentStyle:
                                txtBodySmallBold(color: grayScaleColorBase),
                          ),
                          if (e.vat != null)
                            InfoContentView(
                              title: S.of(context).vat,
                              content: e.vat != null ? "${e.vat} %" : '0 %',
                              contentStyle:
                                  txtBodySmallBold(color: grayScaleColorBase),
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
                                  txtBodySmallBold(color: grayScaleColorBase),
                            ),
                          InfoContentView(
                            title: S.of(context).total_pay,
                            content: e.discount_money != null
                                ? formatCurrency
                                    .format(e.discount_money!)
                                    .replaceAll("₫", "VND")
                                : '0 VND',
                            contentStyle:
                                txtBodySmallBold(color: grayScaleColorBase),
                          ),
                          InfoContentView(
                            title: S.of(context).paid_payment,
                            content: e.amount_due != null
                                ? formatCurrency
                                    .format(paid)
                                    .replaceAll("₫", "VND")
                                : '0 VND',
                            contentStyle:
                                txtBodySmallBold(color: grayScaleColorBase),
                          ),
                          // if (bill.payment_status != "PAID")
                          InfoContentView(
                            title: S.of(context).need_pay,
                            content: e.discount_money != null
                                ? formatCurrency
                                    .format(e.discount_money! - paid)
                                    .replaceAll("₫", "VND")
                                : '0 VND',
                            contentStyle:
                                txtBodySmallBold(color: grayScaleColorBase),
                          ),
                          if (e.expiration_date != null)
                            InfoContentView(
                              title: S.of(context).due_bill,
                              content:
                                  Utils.dateFormat(e.expiration_date ?? "", 1),
                              contentStyle:
                                  txtBodySmallBold(color: grayScaleColorBase),
                            ),
                          if (e.transactions.isNotEmpty)
                            InfoContentView(
                              title: S.of(context).pay_date,
                              content: Utils.dateFormat(payDate ?? "", 1),
                              contentStyle:
                                  txtBodySmallBold(color: grayScaleColorBase),
                            ),
                          // if (e.date != null)
                          //   InfoContentView(
                          //     title: S.of(context).pay_date,
                          //     content: Utils.dateFormat(e.date ?? "", 1),
                          //     contentStyle:
                          //         txtBodySmallBold(color: grayScaleColorBase),
                          //   ),
                        ];
                        var date = DateTime.parse(e.date ?? "");
                        return Padding(
                          padding: const EdgeInsets.only(top: 28),
                          child: Column(
                            children: [
                              PrimaryInfoWidget(
                                listInfoView: listContent,
                              ),
                              vpad(20),
                              if (e.payment_status != "PAID" && widget.isPay)
                                PrimaryButton(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      PaymentScreen.routeName,
                                      arguments: {
                                        "list": [e],
                                        "year": date.year,
                                        "month": date.month,
                                      },
                                    );
                                  },
                                  width: dvWidth(context) - 24,
                                  text: S.of(context).pay,
                                ),
                              vpad(30)
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
