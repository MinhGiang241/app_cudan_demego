import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/models/manage_card.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_tower.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/l10n.dart';
import '../../../../services/api_transport.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/item_selected.dart';
import '../../../../widgets/primary_bottom_sheet.dart';
import '../../../../widgets/primary_dialog.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_loading.dart';
import '../../../reg_resident/add_existed_resident.dart';
import '../../../reg_resident/add_new_resident_screen.dart';
import '../../../services/resident_card/register_resident_card.dart';
import '../../../services/resident_card/resident_card_details.dart';
import '../../../services/resident_card/resident_card_screen.dart';
import '../../../services/transport_card/manage_card_details_screen.dart';
import '../../../services/transport_card/transport_card_screen.dart.dart';

class CardListTab extends StatefulWidget {
  const CardListTab({super.key});

  @override
  State<CardListTab> createState() => _CardListTabState();
}

class _CardListTabState extends State<CardListTab> {
  List<ManageCard> resList = [];
  List<ManageCard> transList = [];
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future cancelTransportCard(
    BuildContext context,
    ManageCard card,
  ) async {
    Utils.showConfirmMessage(
      title: S.of(context).can_trans,
      content: S.of(context).confirm_can_trans_card,
      context: context,
      onConfirm: () async {
        Navigator.pop(context);
        var submitCard = card.copyWith();
        submitCard.status = "DESTROY";
        submitCard.reasons = 'NGUOIDUNGKHOA';
        var d = submitCard.toMap();

        await APITransport.lockManageCard(d).then((v) {
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_can_trans_card,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                TransportCardScreen.routeName,
                (route) => route.isFirst,
                arguments: 0,
              );
            },
          );
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });
      },
    );
  }

  Future cancelResCard(BuildContext context, ManageCard card) async {
    Utils.showConfirmMessage(
      title: S.of(context).can_trans_res,
      content: S.of(context).confirm_can_trans_card_res,
      context: context,
      onConfirm: () async {
        Navigator.pop(context);
        var submitCard = card.copyWith();
        submitCard.status = "DESTROY";
        submitCard.reasons = 'NGUOIDUNGKHOA';

        await APITransport.lockManageCard(submitCard.toMap()).then((v) {
          Utils.showSuccessMessage(
            context: context,
            e: S.of(context).success_can_res_card,
            onClose: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ResidentCardListScreen.routeName,
                (route) => route.isFirst,
                arguments: 0,
              );
            },
          );
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          vpad(12),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).registered_card,
                      style: txtBold(14, grayScaleColorBase),
                      textAlign: TextAlign.start,
                    ),
                    vpad(6),
                    Text(
                      S.of(context).confirmed_card,
                      style: txtRegular(12, grayScaleColorBase),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              hpad(5),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: primaryColorBase,
                          width: 2,
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
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
                                  S.of(context).select_card_type,
                                  overflow: TextOverflow.ellipsis,
                                  style: txtLinkSmall(color: grayScaleColor1),
                                ),
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ItemSelected(
                              text: S.of(context).res_card,
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                  context,
                                  RegisterResidentCard.routeName,
                                );
                              },
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ItemSelected(
                              text: S.of(context).trans_card,
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                  context,
                                  TransportCardScreen.routeName,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Text(
                    S.of(context).add,
                    style: txtMedium(14, primaryColorBase),
                  ),
                ),
              )
            ],
          ),
          vpad(12),
          Expanded(
            child: FutureBuilder(
              future: () async {
                await APITower.getManageCardList(
                  context.read<ResidentInfoPrv>().residentId,
                  context.read<ResidentInfoPrv>().userInfo?.account?.userName,
                ).then((v) {
                  if (v != null) {
                    resList.clear();
                    transList.clear();
                    for (var i in v) {
                      if (i['card_name'] == "RESIDENT") {
                        resList.add(ManageCard.fromMap(i));
                      } else {
                        transList.add(ManageCard.fromMap(i));
                      }
                    }
                  }
                });
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
                    },
                  );
                } else if ((resList + transList).isEmpty) {
                  return SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropMaterialHeader(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    controller: refreshController,
                    onLoading: () {
                      refreshController.loadComplete();
                      ;
                    },
                    onRefresh: () {
                      setState(() {});
                      refreshController.refreshCompleted();
                    },
                    child: PrimaryEmptyWidget(
                      emptyText: S.of(context).no_card,
                      icons: PrimaryIcons.identity_bg,
                      action: () {},
                    ),
                  );
                }

                resList
                    .sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
                transList
                    .sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropMaterialHeader(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  controller: refreshController,
                  onRefresh: () {
                    setState(() {});
                    refreshController.refreshCompleted();
                  },
                  child: ListView(
                    children: [
                      ...resList.map(
                        (e) => PrimaryCard(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ResidentCardDetails.routeName,
                              arguments: {"card": e, "lockCard": cancelResCard},
                            );
                          },
                          padding: EdgeInsets.only(top: 20),
                          borderRadius: BorderRadius.circular(24),
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: blueColor3,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                    )
                                  ],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      flex: 1,
                                      child: PrimaryIcon(
                                        icons: PrimaryIcons.identity_bg,
                                        color: Colors.white,
                                        size: 80,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          vpad(5),
                                          Text(
                                            S.of(context).res_card,
                                            style: txtBold(14, Colors.white),
                                          ),
                                          vpad(10),
                                          Text(
                                            e.a?.code ?? "",
                                            style: txtRegular(14, Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                // height: 120,
                                decoration: const BoxDecoration(
                                  color: grayScaleColor6,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                    )
                                  ],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(24),
                                    bottomRight: Radius.circular(24),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          vpad(12),
                                          Text(
                                            context
                                                    .read<ResidentInfoPrv>()
                                                    .userInfo
                                                    ?.info_name ??
                                                "",
                                            style:
                                                txtBold(14, primaryColorBase),
                                          ),
                                          vpad(10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${S.of(context).plan_code}:",
                                                  style: txtBold(
                                                    14,
                                                    grayScaleColor3,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  e.a?.code ?? '',
                                                  style: txtRegular(
                                                    14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          vpad(10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${S.of(context).reg_date}:",
                                                  style: txtBold(
                                                    14,
                                                    grayScaleColor3,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  Utils.dateFormat(
                                                    e.registration_date ?? "",
                                                    0,
                                                  ),
                                                  style: txtRegular(
                                                    14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          vpad(10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${S.of(context).expired_date}:",
                                                  style: txtBold(
                                                    14,
                                                    grayScaleColor3,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "02/03/2023",
                                                  style: txtRegular(
                                                    14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          vpad(10),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        right: 8,
                                        width: 60,
                                        child:
                                            Image.asset(AppImage.demeproLogo),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      ...transList.map(
                        (e) => PrimaryCard(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ManageCardDetailsScreen.routeName,
                              arguments: {
                                "card": e,
                                "cancel": cancelTransportCard,
                              },
                            );
                          },
                          padding: EdgeInsets.only(top: 20),
                          borderRadius: BorderRadius.circular(24),
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: greenColor10,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                    )
                                  ],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      flex: 1,
                                      child: PrimaryIcon(
                                        icons: PrimaryIcons.car,
                                        color: Colors.white,
                                        size: 80,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          vpad(5),
                                          Text(
                                            S.of(context).transport_card,
                                            style: txtBold(14, Colors.white),
                                          ),
                                          vpad(10),
                                          Text(
                                            e.a?.code ?? "",
                                            style: txtRegular(14, Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                // height: 120,
                                decoration: const BoxDecoration(
                                  color: grayScaleColor6,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                    )
                                  ],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(24),
                                    bottomRight: Radius.circular(24),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          vpad(12),
                                          Text(
                                            context
                                                    .read<ResidentInfoPrv>()
                                                    .userInfo
                                                    ?.info_name ??
                                                "",
                                            style:
                                                txtBold(14, primaryColorBase),
                                          ),
                                          vpad(10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  S.of(context).plan_code,
                                                  style: txtBold(
                                                    14,
                                                    grayScaleColor3,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  e.a?.code ?? '',
                                                  style: txtRegular(
                                                    14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          vpad(10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${S.of(context).reg_date}:",
                                                  style: txtBold(
                                                    14,
                                                    grayScaleColor3,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  Utils.dateFormat(
                                                    e.registration_date ?? "",
                                                    0,
                                                  ),
                                                  style: txtRegular(
                                                    14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          vpad(10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${S.of(context).expired_date}:",
                                                  style: txtBold(
                                                    14,
                                                    grayScaleColor3,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "02/03/2023",
                                                  style: txtRegular(
                                                    14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          vpad(10),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        right: 8,
                                        width: 60,
                                        child:
                                            Image.asset(AppImage.demeproLogo),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      vpad(50)
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
