import 'package:app_cudan/screens/services/pet/pet_details_screen.dart';
import 'package:app_cudan/screens/services/pet/prv/pet_list_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/pet.dart';
import '../../../services/api_service.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_image_netword.dart';
import '../../../widgets/primary_loading.dart';
import '../service_screen.dart';
import 'register_pet_screen.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});
  static const routeName = '/pet';

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  var initIndex = 0;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PetListPrv(),
      builder: (context, child) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).reg_pet_list,
            leading: BackButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                ServiceScreen.routeName,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            tooltip: S.of(context).reg_pet,
            onPressed: () {
              Navigator.pushNamed(
                context,
                RegisterPetScreen.routeName,
                arguments: {"isEdit": false},
              );
            },
            backgroundColor: primaryColorBase,
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
          ),
          body: FutureBuilder(
            future: context.read<PetListPrv>().getPetList(context),
            builder: (context, snapshot) {
              List<Pet> newLetter = [];
              List<Pet> approvedLetter = [];
              List<Pet> waitLetter = [];
              List<Pet> cancelLetter = [];
              for (var i in context.read<PetListPrv>().listPet) {
                if (i.pet_status == "NEW") {
                  newLetter.add(i);
                } else if (i.pet_status == "APPROVED") {
                  approvedLetter.add(i);
                } else if (i.pet_status == "WAIT") {
                  waitLetter.add(i);
                } else if (i.pet_status == "CANCEL") {
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

              List<Pet> list =
                  newLetter + waitLetter + approvedLetter + cancelLetter;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: PrimaryLoading());
              } else if (snapshot.connectionState == ConnectionState.none) {
                return PrimaryErrorWidget(
                  code: snapshot.hasError ? "err" : "1",
                  message: snapshot.data.toString(),
                  onRetry: () async {
                    setState(() {});
                  },
                );
              } else if (list.isEmpty) {
                return SafeArea(
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
                    child: PrimaryEmptyWidget(
                      emptyText: S.of(context).no_pet,
                      icons: PrimaryIcons.bone,
                      action: () {},
                    ),
                  ),
                );
              }

              return SafeArea(
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
                    children: [
                      vpad(24),
                      ...list.map(
                        (e) {
                          var listContent = [
                            InfoContentView(
                              title: "${S.of(context).reg_code}:",
                              content: e.code,
                              contentStyle: txtBold(14, grayScaleColorBase),
                            ),
                            InfoContentView(
                              title: "${S.of(context).pet_name}:",
                              content: e.pet_name,
                              contentStyle: txtBold(14, grayScaleColorBase),
                            ),
                            InfoContentView(
                              title: "${S.of(context).pet_type}:",
                              content: genType(e.pet_type ?? ""),
                              contentStyle: txtBold(14, grayScaleColorBase),
                            ),
                            InfoContentView(
                              title: "${S.of(context).color}:",
                              content: e.color,
                              contentStyle: txtBold(14, grayScaleColorBase),
                            ),
                            InfoContentView(
                              title: "${S.of(context).pet_images}:",
                              images: [
                                ...e.avt_pet!.map(
                                  (i) =>
                                      "${ApiService.shared.uploadURL}?load=${i.id}&regcode=${ApiService.shared.regCode}",
                                )
                              ],
                            ),
                            InfoContentView(
                              title: "${S.of(context).status}:",
                              content: genStatus(e.pet_status ?? ""),
                              contentStyle: txtBold(
                                14,
                                genStatusColor(e.pet_status ?? ""),
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
                                  PetDetailsScreen.routeName,
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
                                      textBaseline: TextBaseline.ideographic,
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.baseline,
                                      columnWidths: const {
                                        0: FlexColumnWidth(2),
                                        1: FlexColumnWidth(3)
                                      },
                                      children: [
                                        ...listContent.map<TableRow>((i) {
                                          if (i.images != null &&
                                              i.images!.isNotEmpty) {
                                            return TableRow(
                                              children: [
                                                TableCell(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        bottom: 20,
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
                                                ),
                                                TableCell(
                                                  verticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .top,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Row(
                                                        children: [
                                                          ...i.images!.map(
                                                            (o) =>
                                                                PrimaryImageNetwork(
                                                              path: o,
                                                              width: 60,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          }
                                          return TableRow(
                                            children: [
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                  i.content ?? "",
                                                  style: i.contentStyle,
                                                ),
                                              )
                                            ],
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                  if (e.pet_status == "WAIT")
                                    Row(
                                      children: [
                                        hpad(16),
                                        PrimaryButton(
                                          onTap: () {
                                            context
                                                .read<PetListPrv>()
                                                .cancelRequetsAprrove(
                                                  context,
                                                  e,
                                                );
                                          },
                                          text: S.of(context).cancel_register,
                                          buttonSize: ButtonSize.xsmall,
                                          buttonType: ButtonType.secondary,
                                          secondaryBackgroundColor: redColor5,
                                          textColor: redColorBase,
                                        )
                                      ],
                                    ),
                                  if (e.pet_status == "NEW")
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: PrimaryButton(
                                            onTap: () {
                                              context
                                                  .read<PetListPrv>()
                                                  .sendToApprove(context, e);
                                            },
                                            text: S.of(context).send_request,
                                            buttonSize: ButtonSize.xsmall,
                                            buttonType: ButtonType.secondary,
                                            secondaryBackgroundColor:
                                                greenColor7,
                                            textColor: greenColor8,
                                          ),
                                        ),
                                        hpad(5),
                                        Expanded(
                                          child: PrimaryButton(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                RegisterPetScreen.routeName,
                                                arguments: {
                                                  "isEdit": true,
                                                  "data": e,
                                                },
                                              );
                                            },
                                            text: S.of(context).edit,
                                            buttonSize: ButtonSize.xsmall,
                                            buttonType: ButtonType.secondary,
                                            secondaryBackgroundColor:
                                                primaryColor5,
                                            textColor: primaryColorBase,
                                          ),
                                        ),
                                        hpad(5),
                                        Expanded(
                                          child: PrimaryButton(
                                            onTap: () {
                                              context
                                                  .read<PetListPrv>()
                                                  .deleteLetter(context, e);
                                            },
                                            text: S.of(context).delete_letter,
                                            buttonSize: ButtonSize.xsmall,
                                            buttonType: ButtonType.secondary,
                                            secondaryBackgroundColor: redColor5,
                                            textColor: redColorBase,
                                          ),
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
                      vpad(60),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
