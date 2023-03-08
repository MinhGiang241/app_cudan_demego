import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/info_content_view.dart';
import '../../models/selection_model.dart';
import '../../utils/utils.dart';
import '../../widgets/item_selected.dart';
import '../../widgets/primary_bottom_sheet.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_empty_widget.dart';
import '../../widgets/primary_error_widget.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_loading.dart';
import '../home/home_screen.dart';
import './prv/register_resident_prv.dart';
import 'add_new_resident_screen.dart';

class RegisterResidentScreen extends StatefulWidget {
  const RegisterResidentScreen({super.key});
  static const routeName = '/reg_resident';

  @override
  State<RegisterResidentScreen> createState() => _RegisterResidentScreenState();
}

class _RegisterResidentScreenState extends State<RegisterResidentScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RegisterResidentPrv(),
        builder: (context, child) {
          return PrimaryScreen(
              appBar: PrimaryAppbar(
                title: S.of(context).add_dependent_person,
                leading: BackButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, HomeScreen.routeName),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                tooltip: S.of(context).reg_service,
                onPressed: () {
                  Utils.showBottomSheet(
                      context: context,
                      child: PrimaryBottomSheet(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(S.of(context).dependent_person,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        txtLinkSmall(color: grayScaleColor1)),
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ItemSelected(
                              text: S.of(context).dependence_has_info,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ItemSelected(
                              text: S.of(context).dependence_not_info,
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, AddNewResidentScreen.routeName);
                              },
                            ),
                          ],
                        ),
                      ));
                },
                backgroundColor: primaryColorBase,
                child: const Icon(
                  Icons.add,
                  size: 40,
                ),
              ),
              body: SafeArea(
                child: FutureBuilder(
                  future:
                      context.watch<RegisterResidentPrv>().getListForm(context),
                  builder: (context, snapshot) {
                    var list = context.watch<RegisterResidentPrv>().listForm;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: PrimaryLoading());
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return PrimaryErrorWidget(
                          code: snapshot.hasError ? "err" : "1",
                          message: snapshot.data.toString(),
                          onRetry: () async {
                            setState(() {});
                            // init = false;
                          });
                    } else if (list.isEmpty) {
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
                        child: ListView(
                          children: [
                            vpad(12),
                            ...list.map((e) {
                              var listContent = [
                                InfoContentView(
                                  title: "${S.of(context).apartment}:",
                                  content:
                                      '${e.a!.name} - ${e.f!.name} - ${e.b!.name}',
                                  contentStyle: txtBold(14, grayScaleColorBase),
                                ),
                                InfoContentView(
                                  title: "${S.of(context).res_name}:",
                                  content: e.info_name,
                                  contentStyle: txtBold(16, purpleColorBase),
                                ),
                                InfoContentView(
                                  title: "${S.of(context).dob}:",
                                  content:
                                      Utils.dateFormat(e.date_birth ?? "", 1),
                                  contentStyle: txtBold(14, grayScaleColorBase),
                                ),
                                InfoContentView(
                                  title:
                                      "${S.of(context).relation_with_owner}:",
                                  content: e.r?.name ?? "",
                                  contentStyle: txtBold(14, grayScaleColorBase),
                                ),
                                InfoContentView(
                                  title: "${S.of(context).reg_date}:",
                                  content:
                                      Utils.dateFormat(e.createdTime ?? "", 1),
                                  contentStyle: txtBold(14, grayScaleColorBase),
                                ),
                                InfoContentView(
                                  title: "${S.of(context).reg_code}:",
                                  content: e.code,
                                  contentStyle: txtBold(14, grayScaleColorBase),
                                ),
                                InfoContentView(
                                  title: "${S.of(context).status}:",
                                  content: e.s?.name ?? '',
                                  contentStyle: txtBold(
                                      14, genStatusColor(e.status ?? "")),
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
                                    // Navigator.pushNamed(
                                    //     context, PackageDetailScreen.routeName,
                                    //     arguments: e);
                                  },
                                  child: Column(
                                    children: [
                                      vpad(12),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Table(
                                          textBaseline:
                                              TextBaseline.ideographic,
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment
                                                  .baseline,
                                          columnWidths: const {
                                            0: FlexColumnWidth(4),
                                            1: FlexColumnWidth(6)
                                          },
                                          children: [
                                            ...listContent.map<TableRow>((i) {
                                              return TableRow(children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                      if (e.status == "NEW")
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            hpad(16),
                                            PrimaryButton(
                                              onTap: () {},
                                              text:
                                                  S.of(context).cancel_register,
                                              buttonSize: ButtonSize.xsmall,
                                              buttonType: ButtonType.secondary,
                                              secondaryBackgroundColor:
                                                  redColor5,
                                              textColor: redColorBase,
                                            )
                                          ],
                                        ),
                                      vpad(16),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            vpad(50)
                          ],
                        ));
                  },
                ),
              ));
        });
  }
}
