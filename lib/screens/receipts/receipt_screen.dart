import 'package:app_cudan/screens/receipts/prv/receipt_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_info_widget.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/info_content_view.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_empty_widget.dart';
import '../../widgets/primary_error_widget.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_loading.dart';
import '../../widgets/primary_screen.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});
  static const routeName = '/receipts';

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final formatCurrency = NumberFormat.simpleCurrency(locale: "vi");
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReceiptPrv(),
      builder: (context, state) {
        var loading = context.watch<ReceiptPrv>().loading;

        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).receipt,
          ),
          body: SafeArea(
            child: Column(
              children: [
                vpad(12),
                Form(
                  onChanged: context.read<ReceiptPrv>().validate,
                  autovalidateMode: AutovalidateMode.always,
                  key: context.read<ReceiptPrv>().formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: PrimaryTextField(
                          validateString:
                              context.watch<ReceiptPrv>().validateFrom,
                          validator: context.read<ReceiptPrv>().validateForm,
                          controller: context.read<ReceiptPrv>().fromController,
                          isRequired: true,
                          hint: 'dd/mm/yyyy',
                          label: S.of(context).from_date,
                          isReadOnly: true,
                          onTap: () {
                            context.read<ReceiptPrv>().pickFromDate(context);
                          },
                          suffixIcon: PrimaryIcon(icons: PrimaryIcons.calendar),
                        ),
                      ),
                      hpad(10),
                      Expanded(
                        child: PrimaryTextField(
                          validator: context.read<ReceiptPrv>().validateForm,
                          validateString:
                              context.watch<ReceiptPrv>().validateTo,
                          controller: context.read<ReceiptPrv>().toController,
                          isRequired: true,
                          hint: 'dd/mm/yyyy',
                          label: S.of(context).to_date,
                          isReadOnly: true,
                          onTap: () {
                            context.read<ReceiptPrv>().pickToDate(context);
                          },
                          suffixIcon: PrimaryIcon(icons: PrimaryIcons.calendar),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: context.read<ReceiptPrv>().getReceiptsList(context),
                    builder: (context, snapshot) {
                      var list = context.watch<ReceiptPrv>().list;
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          loading) {
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

                      if (list.isEmpty) {
                        return SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: false,
                          header: WaterDropMaterialHeader(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          controller: refreshController,
                          onRefresh: () {
                            refreshController.refreshCompleted();
                            setState(() {});
                          },
                          child: PrimaryEmptyWidget(
                            emptyText: S.of(context).no_receipt,
                            icons: PrimaryIcons.dollar,
                            action: () {},
                          ),
                        );
                      }
                      return SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: false,
                        header: WaterDropMaterialHeader(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        controller: refreshController,
                        onLoading: () {
                          refreshController.loadComplete();
                          setState(() {});
                        },
                        onRefresh: () {
                          setState(() {});
                          refreshController.refreshCompleted();
                        },
                        child: ListView(
                          children: [
                            vpad(10),
                            ...list.map((e) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: PrimaryInfoWidget(
                                  listInfoView: [
                                    InfoContentView(
                                      title: S.of(context).date,
                                      content:
                                          Utils.dateFormat(e.createdTime!, 1),
                                    ),
                                    InfoContentView(
                                      title: S.of(context).transaction_code,
                                      content: e.code,
                                    ),
                                    InfoContentView(
                                      title: S.of(context).money,
                                      content: formatCurrency
                                          .format(e.amount_money ?? 0),
                                      contentStyle: txtBold(14, orangeColor),
                                    ),
                                    InfoContentView(
                                      title: S.of(context).content,
                                      content: e.note,
                                    ),
                                    InfoContentView(
                                      title: S.of(context).in_debt,
                                      content:
                                          formatCurrency.format(e.debt ?? 0),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            vpad(60),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
