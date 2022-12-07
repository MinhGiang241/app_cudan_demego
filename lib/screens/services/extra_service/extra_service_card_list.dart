import 'package:app_cudan/screens/services/extra_service/prv/extra_service_card_list_prv.dart';
import 'package:app_cudan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/extra_service.dart';
import '../../../models/info_content_view.dart';
import '../../../models/service_registration.dart';
import '../../../widgets/choose_month_year.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../../auth/prv/resident_info_prv.dart';
import '../service_screen.dart';
import 'extra_service_details.dart';
import 'extra_service_registration_screen.dart';

class ExtraServiceCardListScreen extends StatefulWidget {
  static const routeName = '/extra-service';
  const ExtraServiceCardListScreen({super.key});

  @override
  State<ExtraServiceCardListScreen> createState() =>
      _ExtraServiceCardListScreenState();
}

class _ExtraServiceCardListScreenState
    extends State<ExtraServiceCardListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    final service = arg['service'];
    final y = arg["year"];
    final m = arg["month"];
    return ChangeNotifierProvider(
      create: (context) =>
          ExtraServiceCardListPrv(extraService: service, year: y, month: m),
      builder: (context, child) {
        return PrimaryScreen(
            appBar: PrimaryAppbar(
              leading: BackButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, ServiceScreen.routeName)),
              title: S.of(context).service_name(
                  service.name != null ? service.name!.toLowerCase() : ''),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: S.of(context).reg_service,
              onPressed: () {
                Navigator.pushNamed(
                    context, ExtraServiceRegistrationScreen.routeName,
                    arguments: {
                      "service": service,
                      "isEdit": false,
                      "name": service.name != null
                          ? service.name!.toLowerCase()
                          : '',
                      "serviceId": service.id
                    });
              },
              backgroundColor: primaryColorBase,
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
            body: FutureBuilder(
              future: context
                  .read<ExtraServiceCardListPrv>()
                  .getRegisterExtraServiceList(
                      context,
                      context.read<ResidentInfoPrv>().residentId ?? '',
                      service.id ?? ""),
              builder: (context, snapshot) {
                List<ServiceRegistration> newLetter = [];
                List<ServiceRegistration> approvedLetter = [];
                List<ServiceRegistration> waitLetter = [];
                List<ServiceRegistration> cancelLetter = [];
                for (var i
                    in context.read<ExtraServiceCardListPrv>().listCard) {
                  if (i.status == "NEW") {
                    newLetter.add(i);
                  } else if (i.status == "APPROVED") {
                    approvedLetter.add(i);
                  } else if (i.status == "WAIT") {
                    waitLetter.add(i);
                  } else if (i.status == "CANCEL") {
                    cancelLetter.add(i);
                  }
                }

                newLetter
                    .sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
                approvedLetter
                    .sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
                waitLetter
                    .sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
                cancelLetter
                    .sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
                List<ServiceRegistration> list =
                    newLetter + approvedLetter + waitLetter + cancelLetter;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: PrimaryLoading());
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return PrimaryErrorWidget(
                      code: snapshot.hasError ? "err" : "1",
                      message: snapshot.data.toString(),
                      onRetry: () async {
                        setState(() {});
                      });
                } else if (list.isEmpty) {
                  return SafeArea(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: false,
                      header: WaterDropMaterialHeader(
                          backgroundColor: Theme.of(context).primaryColor),
                      controller: _refreshController,
                      onRefresh: () {
                        setState(() {});
                        _refreshController.loadComplete();
                      },
                      child: Column(
                        children: [
                          vpad(24),
                          ChooseMonthYear(
                            title: S.of(context).his_reg_service,
                            selectMonthAndYear: (year, month) {
                              Provider.of<ExtraServiceCardListPrv>(context,
                                      listen: false)
                                  .chooseMonthYear(year, month);
                              setState(() {});
                            },
                            year: context.watch<ExtraServiceCardListPrv>().year,
                            month:
                                context.watch<ExtraServiceCardListPrv>().month,
                          ),
                          Expanded(
                            child: PrimaryEmptyWidget(
                              emptyText: S.of(context).no_service_regitration,
                              // buttonText: S.of(context).add_trans_card,
                              icons: PrimaryIcons.service_feedback,
                              action: () {
                                // Utils.pushScreen(context, const RegisterParkingCard());
                              },
                            ),
                          ),
                          vpad(100),
                        ],
                      ),
                    ),
                  );
                }

                return SafeArea(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropMaterialHeader(
                        backgroundColor: Theme.of(context).primaryColor),
                    controller: _refreshController,
                    onRefresh: () {
                      setState(() {});
                      _refreshController.loadComplete();
                    },
                    child: ListView(children: [
                      vpad(24),
                      ChooseMonthYear(
                        title: S.of(context).his_reg_service,
                        selectMonthAndYear: (year, month) {
                          Provider.of<ExtraServiceCardListPrv>(context,
                                  listen: false)
                              .chooseMonthYear(year, month);
                          setState(() {});
                        },
                        year: context.watch<ExtraServiceCardListPrv>().year,
                        month: context.watch<ExtraServiceCardListPrv>().month,
                      ),
                      vpad(12),
                      ...list.map((e) {
                        var listContent = [
                          InfoContentView(
                            title: "${S.of(context).reg_code}:",
                            content: e.code,
                            contentStyle: txtBold(14, primaryColor1),
                          ),
                          InfoContentView(
                            title: "${S.of(context).payment_circle}:",
                            content: e.pay!.name,
                            contentStyle: txtBold(14, grayScaleColorBase),
                          ),
                          InfoContentView(
                            title: "${S.of(context).reg_date}:",
                            content:
                                Utils.dateFormat(e.registration_date ?? "", 0),
                            contentStyle: txtBold(14, grayScaleColorBase),
                          ),
                          InfoContentView(
                            title: "${S.of(context).status}:",
                            content: genStatus(e.status ?? ""),
                            contentStyle:
                                txtBold(14, genStatusColor(e.status ?? "")),
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
                                  context, ExtraServiceDetailsScreen.routeName,
                                  arguments: e);
                            },
                            child: Column(
                              children: [
                                vpad(12),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Table(
                                    textBaseline: TextBaseline.ideographic,
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.baseline,
                                    columnWidths: const {
                                      0: FlexColumnWidth(4),
                                      1: FlexColumnWidth(6)
                                    },
                                    children: [
                                      ...listContent.map<TableRow>((i) {
                                        return TableRow(children: [
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: Text(
                                                i.title,
                                                style: txtMedium(
                                                    12, grayScaleColor2),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(i.content ?? "",
                                                style: i.contentStyle),
                                          )
                                        ]);
                                      })
                                    ],
                                  ),
                                ),
                                if (e.status == "WAIT")
                                  Row(
                                    children: [
                                      hpad(16),
                                      PrimaryButton(
                                        onTap: () {
                                          context
                                              .read<ExtraServiceCardListPrv>()
                                              .cancelRequetsAprrove(context, e);
                                        },
                                        text: S.of(context).cancel_register,
                                        buttonSize: ButtonSize.xsmall,
                                        buttonType: ButtonType.secondary,
                                        secondaryBackgroundColor: redColor5,
                                        textColor: redColorBase,
                                      )
                                    ],
                                  ),
                                if (e.status == "NEW")
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      PrimaryButton(
                                        onTap: () {
                                          context
                                              .read<ExtraServiceCardListPrv>()
                                              .sendToApprove(context, e);
                                        },
                                        text: S.of(context).send_request,
                                        buttonSize: ButtonSize.xsmall,
                                        buttonType: ButtonType.secondary,
                                        secondaryBackgroundColor: greenColor7,
                                        textColor: greenColor8,
                                      ),
                                      PrimaryButton(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context,
                                              ExtraServiceRegistrationScreen
                                                  .routeName,
                                              arguments: {
                                                "service": service,
                                                "isEdit": true,
                                                "name": service.name != null
                                                    ? service.name!
                                                        .toLowerCase()
                                                    : '',
                                                "serviceId": service.id,
                                                "data": e
                                                // "data": arg,
                                              });
                                        },
                                        text: S.of(context).edit,
                                        buttonSize: ButtonSize.xsmall,
                                        buttonType: ButtonType.secondary,
                                        secondaryBackgroundColor: primaryColor5,
                                        textColor: primaryColorBase,
                                      ),
                                      PrimaryButton(
                                        onTap: () {
                                          context
                                              .read<ExtraServiceCardListPrv>()
                                              .deleteLetter(context, e);
                                        },
                                        text: S.of(context).delete_letter,
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
                      })
                    ]),
                  ),
                );
              },
            ));
      },
    );
  }
}
