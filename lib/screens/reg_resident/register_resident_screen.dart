import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_dialog.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/dependence_sign_up.dart';
import '../../models/info_content_view.dart';
import '../../utils/utils.dart';
import '../../widgets/item_selected.dart';
import '../../widgets/primary_bottom_sheet.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_dropdown.dart';
import '../../widgets/primary_empty_widget.dart';
import '../../widgets/primary_error_widget.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_loading.dart';
import '../home/home_screen.dart';
import './prv/register_resident_prv.dart';
import 'add_existed_resident.dart';
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
                context,
                HomeScreen.routeName,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
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
                          child: Text(
                            S.of(context).dependent_person,
                            overflow: TextOverflow.ellipsis,
                            style: txtLinkSmall(color: grayScaleColor1),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      ItemSelected(
                        text: S.of(context).dependence_has_info,
                        onTap: () {
                          Navigator.pop(context);
                          Utils.showDialog(
                            context: context,
                            dialog: PrimaryDialog.custom(
                              title: S
                                  .of(context)
                                  .add_dependent_person_to_apartment,
                              content: AddExistedResident(ctx: context),
                            ),
                          );
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
                            context,
                            AddNewResidentScreen.routeName,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            backgroundColor: primaryColorBase,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
          ),
          body: SafeArea(
            child: FutureBuilder(
              future: context.read<RegisterResidentPrv>().getListForm(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: PrimaryLoading());
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return PrimaryErrorWidget(
                    code: snapshot.hasError ? 'err' : '1',
                    message: snapshot.data.toString(),
                    onRetry: () async {
                      setState(() {});
                      // init = false;
                    },
                  );
                }
                List<DependenceSignUp> listData =
                    context.watch<RegisterResidentPrv>().listForm;

                List<DependenceSignUp> listApproved = [];
                List<DependenceSignUp> listNew = [];
                List<DependenceSignUp> listCancel = [];

                for (var i in listData) {
                  if (i.status == 'NEW') {
                    listNew.add(i);
                  } else if (i.status == 'CANCEL') {
                    listCancel.add(i);
                  } else {
                    listApproved.add(i);
                  }
                }
                listNew.sort(
                  (a, b) => b.updatedTime!.compareTo(a.updatedTime!),
                );
                listApproved.sort(
                  (a, b) => b.updatedTime!.compareTo(a.updatedTime!),
                );
                listCancel.sort(
                  (a, b) => b.updatedTime!.compareTo(a.updatedTime!),
                );

                var list = listNew + listCancel + listApproved;

                var listApartmentChoice = context
                    .read<ResidentInfoPrv>()
                    .listOwn
                    .where((e) => (e.type == 'BUY' || e.type == 'RENT'))
                    .map(
                      (i) => DropdownMenuItem(
                        value: i.apartmentId,
                        child: Text(
                          '${i.apartment!.name} - ${i.floor!.name} - ${i.building!.name}',
                        ),
                      ),
                    )
                    .toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SmartRefresher(
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
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            vpad(12),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                S.of(context).apartment,
                                style: txtBold(12, grayScaleColor2),
                              ),
                            ),
                            vpad(12),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: PrimaryDropDown(
                                hint: S.of(context).all,
                                isDense: false,
                                value: context
                                    .watch<RegisterResidentPrv>()
                                    .sellectedApartment,
                                onChange: (v) {
                                  context
                                      .read<RegisterResidentPrv>()
                                      .onChangeApartment(v);
                                  setState(() {});
                                },
                                selectList: listApartmentChoice,
                              ),
                            ),
                            vpad(12),
                            if (list.isEmpty) vpad(70),
                            if (list.isEmpty)
                              PrimaryEmptyWidget(
                                emptyText: S.of(context).no_dependence,
                                icons: PrimaryIcons.avatar,
                                action: () {},
                              ),
                            if (list.isNotEmpty)
                              ...list.map((e) {
                                var listContent = [
                                  InfoContentView(
                                    title: '${S.of(context).apartment}',
                                    content:
                                        '${e.a!.name} - ${e.f!.name} - ${e.b!.name}',
                                    contentStyle:
                                        txtBold(14, grayScaleColorBase),
                                  ),
                                  InfoContentView(
                                    title: '${S.of(context).res_name}:',
                                    content: e.info_name,
                                    contentStyle: txtBold(16, purpleColorBase),
                                  ),
                                  InfoContentView(
                                    title: '${S.of(context).dob}:',
                                    content: Utils.dateFormat(
                                      e.date_birth ?? '',
                                      1,
                                    ),
                                    contentStyle:
                                        txtBold(14, grayScaleColorBase),
                                  ),
                                  InfoContentView(
                                    title:
                                        '${S.of(context).relation_with_owner}:',
                                    content: e.r?.name ?? '',
                                    contentStyle:
                                        txtBold(14, grayScaleColorBase),
                                  ),
                                  InfoContentView(
                                    title: '${S.of(context).reg_date}:',
                                    content: Utils.dateFormat(
                                      e.createdTime ?? '',
                                      1,
                                    ),
                                    contentStyle:
                                        txtBold(14, grayScaleColorBase),
                                  ),
                                  InfoContentView(
                                    title: '${S.of(context).reg_code}:',
                                    content: e.ticket_code,
                                    contentStyle:
                                        txtBold(14, grayScaleColorBase),
                                  ),
                                  InfoContentView(
                                    title: '${S.of(context).status}:',
                                    content: e.s?.name ?? '',
                                    contentStyle: txtBold(
                                      14,
                                      genStatusColor(e.status ?? ''),
                                    ),
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
                                        context,
                                        AddNewResidentScreen.routeName,
                                        arguments: e,
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        vpad(12),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
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
                                                return TableRow(
                                                  children: [
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: 16,
                                                        ),
                                                        child: Text(
                                                          i.title,
                                                          style: txtMedium(
                                                            12,
                                                            grayScaleColor2,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Text(
                                                        i.content ?? '',
                                                        style: i.contentStyle,
                                                      ),
                                                    )
                                                  ],
                                                );
                                              })
                                            ],
                                          ),
                                        ),
                                        if (e.status == 'NEW' ||
                                            e.status == 'WAIT')
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              hpad(16),
                                              PrimaryButton(
                                                onTap: () {
                                                  context
                                                      .read<
                                                          RegisterResidentPrv>()
                                                      .cancelLetter(
                                                        context,
                                                        e,
                                                      );
                                                },
                                                text: S
                                                    .of(context)
                                                    .cancel_register,
                                                buttonSize: ButtonSize.xsmall,
                                                buttonType:
                                                    ButtonType.secondary,
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
                            if (list.isNotEmpty) vpad(60)
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
