import 'dart:async';
import 'dart:math';

import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/apartment_relationship.dart';
import '../../../../services/api_tower.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../auth/prv/resident_info_prv.dart';
import '../../../reg_resident/add_new_resident_screen.dart';

class NewPlanInfoTab extends StatefulWidget {
  const NewPlanInfoTab({super.key});

  @override
  State<NewPlanInfoTab> createState() => _NewPlanInfoTabState();
}

class _NewPlanInfoTabState extends State<NewPlanInfoTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<ApartmentRelationship> listResOwn = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: FutureBuilder(
          future: () async {
            var residentId = context.read<ResidentInfoPrv>().residentId;
            listResOwn.clear();
            await APITower.getResidentOwnInfo(residentId).then((v) {
              for (var i in v) {
                listResOwn.add(ApartmentRelationship.fromMap(i));
              }
            });
          }(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: PrimaryLoading());
            } else if (snapshot.hasError) {
              return PrimaryErrorWidget(
                code: snapshot.hasError ? "err" : "1",
                message: snapshot.data.toString(),
                onRetry: () async {
                  setState(() {});
                },
              );
            }
            // if (listResOwn.isEmpty) {
            //   return SmartRefresher(
            //     enablePullDown: true,
            //     enablePullUp: false,
            //     header: WaterDropMaterialHeader(
            //         backgroundColor: Theme.of(context).primaryColor),
            //     controller: _refreshController,
            //     onRefresh: () {
            //       setState(() {});
            //       _refreshController.refreshCompleted();
            //     },
            //     child: PrimaryEmptyWidget(
            //       emptyText: S.of(context).no_home,
            //       icons: PrimaryIcons.home,
            //       action: () {},
            //     ),
            //   );
            // }
            var listAll = context
                .read<ResidentInfoPrv>()
                .listOwn
                .where((e) => e.status == "BUY" || e.status == "RENT");
            return Column(
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
                            S.of(context).registed_resident,
                            style: txtBold(14, grayScaleColorBase),
                            textAlign: TextAlign.start,
                          ),
                          vpad(6),
                          Text(
                            S.of(context).confirmed_by_manager_resident,
                            style: txtRegular(14, grayScaleColorBase),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    hpad(5),
                    if (listAll.isNotEmpty)
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                  color: primaryColorBase,
                                  width: 2,
                                ),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AddNewResidentScreen.routeName,
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
                listResOwn.isEmpty
                    ? Expanded(
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
                            emptyText: S.of(context).no_home,
                            icons: PrimaryIcons.home,
                            action: () {},
                          ),
                        ),
                      )
                    : Expanded(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: false,
                          header: WaterDropMaterialHeader(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          controller: _refreshController,
                          onRefresh: () async {
                            setState(() {});
                            _refreshController.refreshCompleted();
                          },
                          child: ListView(
                            // addAutomaticKeepAlives: true,
                            children: [
                              vpad(12),
                              ...listResOwn.map((v) {
                                return RRecidentInfoItem(
                                  own: v,
                                );
                              }),
                              vpad(12),
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
  }
}

class RRecidentInfoItem extends StatefulWidget {
  const RRecidentInfoItem({
    Key? key,
    this.isShowInit = false,
    this.header,
    this.hide,
    this.show,
    required this.own,
  }) : super(key: key);
  final bool isShowInit;
  final Widget? header;
  final Widget? hide;
  final Widget? show;
  final ApartmentRelationship own;

  @override
  State<RRecidentInfoItem> createState() => _RRecidentInfoItemState();
}

class _RRecidentInfoItemState extends State<RRecidentInfoItem>
    with TickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late Animation<double> rotateAnimation;
  bool isShow = false;
  final StreamController<bool> showController = StreamController<bool>();
  @override
  void initState() {
    super.initState();
    rotateAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationController);
    isShow = widget.isShowInit;
    showController.add(isShow);
  }

  @override
  Widget build(BuildContext context) {
    var res = context.read<ResidentInfoPrv>().residentId;
    var listOwn = context.read<ResidentInfoPrv>().listOwnAll;
    var listO = context.read<ResidentInfoPrv>().listOwn;
    var idListOwn = listO.map(
      (i) => i.apartmentId,
    );
    var a = widget.own.residents!;
    var ownInfoApartIndex = listOwn.indexWhere(
      (element) => element.apartmentId == widget.own.apartment?.id,
    );
    var apartOwn = listOwn[ownInfoApartIndex];

    var resList = widget.own.residents!.where((e) {
      // if (apartOwn.type == "RENT" || apartOwn.type == "BUY") {
      //   return true;
      // } else
      // if (e.type == 'RENT' || e.type == 'BUY') {
      //   return true;
      // }
      if (e.id == res) {
        return true;
      }
      return false;
    }).toList();

    print(resList);
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 16),
      child: PrimaryCard(
        onTap: () {
          if (isShow) {
            isShow = false;
            animationController.reverse();
          } else {
            isShow = true;
            animationController.forward();
          }
          showController.add(isShow);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: StreamBuilder<bool>(
                    initialData: widget.isShowInit,
                    stream: showController.stream,
                    builder: (context, snapshot) {
                      final isShow = snapshot.data ?? false;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.header ??
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${widget.own.apartment?.name} - ${widget.own.floor?.name} - ${widget.own.building?.name}",
                                      style: txtMedium(),
                                    ),
                                  ),
                                  hpad(10),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      genStatus(
                                        apartOwn.status ?? "",
                                      ),
                                      style: txtLinkSmall(
                                        color: greenColorBase,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                          if (!isShow)
                            widget.hide ??
                                Column(
                                  children: [
                                    vpad(8),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            '${S.of(context).area}:',
                                            style: txtRegular(
                                              12,
                                              grayScaleColor2,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "${widget.own.apartment?.area} m2",
                                            style: txtRegular(
                                              12,
                                              grayScaleColor1,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                    vpad(5),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            '${S.of(context).member_num}:',
                                            style: txtRegular(
                                              12,
                                              grayScaleColor2,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            widget.own.residents!.length
                                                .toString(),
                                            style: txtRegular(
                                              12,
                                              grayScaleColor1,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                          if (isShow)
                            widget.show ??
                                Column(
                                  children: [
                                    vpad(16),
                                    const Divider(),
                                    // vpad(16),
                                    // Row(children: [
                                    //   Expanded(
                                    //     flex: 1,
                                    //     child: Text(
                                    //         '${S.of(context).relation_owner}:',
                                    //         style: txtMedium(
                                    //             14, grayScaleColor2)),
                                    //   ),
                                    //   hpad(16),
                                    //   Flexible(
                                    //     flex: 1,
                                    //     child: Text(
                                    //         genDependentType(
                                    //             widget.own.ownInfo?.type),
                                    //         style: txtLinkSmall(
                                    //             color: grayScaleColorBase)),
                                    //   )
                                    // ]),
                                  ],
                                ),
                          if (isShow && widget.show == null)
                            ...List.generate(resList.length ?? 0, (index) {
                              var a = resList[index].re;
                              var r = resList[index];
                              var o = widget.own.ownInfo;

                              var render = Column(
                                children: [
                                  Text(r.id ?? "null"),
                                  Text(res ?? "null"),
                                  // vpad(16),
                                  // const Divider(),
                                  vpad(16),
                                  InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${S.of(context).full_name}:",
                                              style: txtMedium(
                                                14,
                                                grayScaleColor2,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              widget.own.residents?[index]
                                                      .info_name ??
                                                  "",
                                              style: txtLinkSmall(
                                                color: grayScaleColorBase,
                                              ),
                                            )
                                          ],
                                        ),
                                        vpad(5),
                                        Row(
                                          children: [
                                            Text(
                                              "${S.of(context).relation_owner}:",
                                              style: txtMedium(
                                                14,
                                                grayScaleColor2,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              r.type ?? "",
                                              // r.re != null
                                              //     ? r.re?.name ?? ""
                                              //     : genDependentType(
                                              //         r.type ?? "",
                                              //       ),
                                              style: txtLinkSmall(
                                                color: grayScaleColorBase,
                                              ),
                                            )
                                          ],
                                        ),
                                        vpad(5),
                                        const Divider(),
                                        // Row(children: [
                                        //   Text("0XXXXXXXXX",
                                        //       style: txtMedium(14)),
                                        //   const Spacer(),
                                        //   const Icon(Icons
                                        //       .chevron_right_rounded)
                                        // ]),
                                      ],
                                    ),
                                  )
                                ],
                              );
                              return render;
                              // if ((r!.type == "RENT" || r.type == 'BUY')) {
                              //   return render;
                              // } else if ((r.type == "DEPENDENT_RENT" ||
                              //         r.type == 'DEPENDENT_BUY') &&
                              //     r.id == res) {
                              //   return render;
                              // } else {
                              //   return vpad(0);
                              // }
                            }),
                          vpad(12),
                          Center(
                            child: AnimatedBuilder(
                              animation: animationController,
                              builder: (context, child) => Transform.rotate(
                                angle: rotateAnimation.value,
                                child: child,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: yellowColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              // Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: AnimatedBuilder(
              //         animation: animationController,
              //         builder: (context, child) => Transform.rotate(
              //               angle: rotateAnimation.value,
              //               child: child,
              //             ),
              //         child: const Icon(Icons.keyboard_arrow_down_rounded)))
            ],
          ),
        ),
      ),
    );
  }
}

genDependentType(String? v) {
  switch (v) {
    case "BUY":
      return S.current.buyer;
    case "RENT":
      return S.current.renter;
    case "DEPENDENT_HOST":
      return S.current.dependent_host;
    case "DEPENDENT_RENT":
      return S.current.dependent_rent;
    default:
      return S.current.unkhown;
  }
}
