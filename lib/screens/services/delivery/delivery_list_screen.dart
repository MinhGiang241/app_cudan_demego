import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/delivery.dart';
import '../../../models/info_content_view.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../service_screen.dart';
import 'package_details_screen.dart';
import 'provider/delivery_list_prv.dart';

class DeliveryListScreen extends StatefulWidget {
  static const routeName = '/delivery';
  const DeliveryListScreen({super.key});

  @override
  State<DeliveryListScreen> createState() => _DeliveryListScreenState();
}

class _DeliveryListScreenState extends State<DeliveryListScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeliveryListPrv(),
      builder: (context, child) {
        return PrimaryScreen(
            appBar: PrimaryAppbar(
              leading: BackButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, ServiceScreen.routeName)),
              title: S.of(context).transfer_list,
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: S.of(context).add_trans_card,
              onPressed: () {
                // Navigator.pushNamed(context, RegisterTransportationCard.routeName,
                //     arguments: {"isEdit": false});
              },
              backgroundColor: primaryColorBase,
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
            body: FutureBuilder(
              future: context.read<DeliveryListPrv>().getDeliveryList(
                  context, context.read<ResidentInfoPrv>().residentId ?? ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: PrimaryLoading());
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return PrimaryErrorWidget(
                      code: snapshot.hasError ? "err" : "1",
                      message: snapshot.data.toString(),
                      onRetry: () async {
                        setState(() {});
                      });
                } else if (context.read<DeliveryListPrv>().listItems.isEmpty) {
                  return PrimaryEmptyWidget(
                    emptyText: S.of(context).no_delivery,
                    // buttonText: S.of(context).add_trans_card,
                    icons: PrimaryIcons.box,
                    action: () {
                      // Utils.pushScreen(context, const RegisterParkingCard());
                    },
                  );
                } else {
                  return ListView(
                    children: [
                      vpad(24),
                      ...context.read<DeliveryListPrv>().listItems.map(
                        (e) {
                          var listContent = [
                            InfoContentView(
                              title: S.of(context).card_num,
                              content: e.code,
                              contentStyle: txtBold(14, grayScaleColorBase),
                            ),
                            InfoContentView(
                              title: S.of(context).package,
                              content: e.item_added_list!
                                  .map((x) => x.item_name)
                                  .join(', '),
                              contentStyle: txtBold(14, grayScaleColorBase),
                            ),
                            InfoContentView(
                              title: S.of(context).start_time,
                              content:
                                  '${Utils.dateFormat(e.start_hour ?? "")}${Utils.dateFormat(e.start_time ?? "")}',
                              contentStyle: txtBold(14, grayScaleColorBase),
                            ),
                            InfoContentView(
                              title: S.of(context).end_time,
                              content:
                                  '${Utils.dateFormat(e.end_hour ?? "")}${Utils.dateFormat(e.end_time ?? "")}',
                              contentStyle: txtBold(14, grayScaleColorBase),
                            ),
                            InfoContentView(
                              title: S.of(context).status,
                              content: genStatus(e.status ?? ''),
                              contentStyle:
                                  txtBold(14, genStatusColor(e.status ?? '')),
                            ),
                          ];

                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                              bottom: 16,
                            ),
                            child: PrimaryCard(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PackageDetailScreen.routeName,
                                    arguments: e);
                              },
                              child: Column(
                                children: [
                                  vpad(12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        e.type_transfer == 'IN'
                                            ? S.of(context).tranfer_in_reg
                                            : 'OUT',
                                        textAlign: TextAlign.right,
                                        style: txtBodySmallRegular(
                                            color: grayScaleColorBase),
                                      ),
                                    ),
                                  ),
                                  vpad(12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(2),
                                        1: FlexColumnWidth(3)
                                      },
                                      children: [
                                        ...listContent.map<TableRow>((i) {
                                          return TableRow(children: [
                                            Text(
                                              i.title,
                                              style: txtMedium(
                                                  12, grayScaleColor2),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: Text(i.content ?? "",
                                                  style: i.contentStyle),
                                            )
                                          ]);
                                        })
                                      ],
                                    ),
                                  ),
                                  if (e.status == "NEW")
                                    Row(
                                      children: [
                                        hpad(16),
                                        PrimaryButton(
                                          onTap: () {},
                                          text: S.of(context).cancel_register,
                                          buttonSize: ButtonSize.xsmall,
                                          buttonType: ButtonType.secondary,
                                          secondaryBackgroundColor: redColor5,
                                          textColor: redColorBase,
                                        )
                                      ],
                                    ),
                                  if (e.status == "WAIT")
                                    Row(
                                      children: [
                                        PrimaryButton(
                                          onTap: () {},
                                          text: S.of(context).send_request,
                                          buttonSize: ButtonSize.xsmall,
                                          buttonType: ButtonType.secondary,
                                          secondaryBackgroundColor: greenColor4,
                                          textColor: greenColor,
                                        ),
                                        PrimaryButton(
                                          onTap: () {},
                                          text: S.of(context).edit,
                                          buttonSize: ButtonSize.xsmall,
                                          buttonType: ButtonType.secondary,
                                          secondaryBackgroundColor:
                                              primaryColor5,
                                          textColor: primaryColorBase,
                                        ),
                                        PrimaryButton(
                                          onTap: () {},
                                          text: S.of(context).cancel_register,
                                          buttonSize: ButtonSize.xsmall,
                                          buttonType: ButtonType.secondary,
                                          secondaryBackgroundColor: redColor5,
                                          textColor: redColorBase,
                                        ),
                                      ],
                                    ),
                                  vpad(16),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      vpad(60)
                    ],
                  );
                }
              },
            ));
      },
    );
  }
}
