// ignore_for_file: unused_local_variable

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
import '../../../../models/response_resident_own.dart';
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
            if (residentId == null) return;
            await APITower.getResidentOwnInfo(residentId).then((v) {
              context.read<ResidentInfoPrv>().listOwnAll.clear();
              context.read<ResidentInfoPrv>().listOwn.clear();
              for (var i in v) {
                var a = ApartmentRelationship.fromMap(i);

                listResOwn.add(ApartmentRelationship.fromMap(i));
                for (var e in a.ownInfo!) {
                  var apr = ResponseResidentOwn.fromJson(e.toJson());
                  apr.apartment = a.apartment;
                  apr.building = a.building;
                  apr.floor = a.floor;
                  if (e.residentId == residentId) {
                    context.read<ResidentInfoPrv>().listOwnAll.add(apr);
                  }

                  if (e.status == "ACTIVE" && e.residentId == residentId) {
                    context.read<ResidentInfoPrv>().listOwn.add(apr);
                  }
                }
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
            var listAll = context.read<ResidentInfoPrv>().listOwn.where(
                  (e) => (e.type == "BUY" ||
                      e.type == "RENT" && e.status == 'ACTIVE'),
                );
            return Column(
              children: [
                vpad(12),
                if (context.read<ResidentInfoPrv>().residentId != null)
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
                              style: txtRegular(12, grayScaleColorBase),
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
      (element) {
        return (element.apartmentId == widget.own.apartment?.id);
      },
    );

    var apartOwn = listOwn[ownInfoApartIndex];

    var resList = widget.own.residents!.where((e) {
      var p = widget.own.ownInfo
          ?.firstWhere((element) => element.residentId == e.id);
      if (apartOwn.status == "INACTIVE") {
        if (e.id == context.read<ResidentInfoPrv>().residentId) {
          return true;
        }

        if ((e.type == 'RENT' || e.type == 'BUY') &&
            p != null &&
            p.status == "ACTIVE") {
          return true;
        }
        return false;
      }
      if (apartOwn.type == "RENT" || apartOwn.type == "BUY") {
        return true;
      } else if ((e.type == 'RENT' || e.type == 'BUY') &&
          p != null &&
          p.status == "ACTIVE") {
        return true;
      }
      if (e.id == res) {
        return true;
      }
      return false;
    }).toList();

    var resRelate = widget.own.residents!.firstWhere((e) => e.id == res);
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
                                        color: genStatusColor(
                                          apartOwn.status ?? "",
                                        ),
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
                                            '${S.of(context).relation_with_owner}:',
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
                                            resRelate.re?.name ??
                                                genDependentType(
                                                  resRelate.type,
                                                ),
                                            style: txtRegular(
                                              12,
                                              grayScaleColor1,
                                            ),
                                            //  overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),

                                    // Text(apartOwn.type ?? ''),
                                    // Text(apartOwn.apartmentId ?? ''),
                                    // Text(widget.own.apartment!.id ?? ''),
                                    // Text(apartOwn.status ?? ''),
                                    if ((apartOwn.type == "RENT" ||
                                            apartOwn.type == "BUY") &&
                                        apartOwn.status == "ACTIVE")
                                      vpad(5),
                                    if ((apartOwn.type == "RENT" ||
                                            apartOwn.type == "BUY") &&
                                        apartOwn.status == "ACTIVE")
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
                                              style: txtBold(
                                                12,
                                                yellowColor7,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    vpad(5),
                                    FutureBuilder(
                                      future: () async {
                                        return await APITower
                                            .getCardCountOwnInfo(
                                          context
                                              .read<ResidentInfoPrv>()
                                              .residentId,
                                          widget.own.apartment?.id,
                                        );
                                      }(),
                                      builder: (ctx, snap) {
                                        if (snap.hasData) {
                                          print(snap.data);
                                          var resCount = snap.data['resident'];
                                          var transCount =
                                              snap.data['transport'];
                                          return Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "${S.of(context).res_card}: ${resCount}",
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
                                                  "${S.of(context).trans_card}: ${transCount}",
                                                  style: txtRegular(
                                                    12,
                                                    grayScaleColor2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        return vpad(0);
                                      },
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
                            ...List.generate(resList.length, (index) {
                              var r = resList[index];

                              var render = Column(
                                children: [
                                  vpad(16),
                                  InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${S.of(context).full_name}:",
                                                style: txtMedium(
                                                  14,
                                                  grayScaleColor2,
                                                ),
                                              ),
                                            ),
                                            // const Spacer(),
                                            hpad(10),
                                            Expanded(
                                              child: Text(
                                                resList[index].info_name ?? "",
                                                style: txtLinkSmall(
                                                    // color: grayScaleColorBase,
                                                    ),
                                              ),
                                            )
                                          ],
                                        ),
                                        vpad(5),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${S.of(context).relation_owner}:",
                                                style: txtMedium(
                                                  14,
                                                  grayScaleColor2,
                                                ),
                                              ),
                                            ),
                                            // const Spacer(),
                                            hpad(10),
                                            Expanded(
                                              child: Text(
                                                r.re != null
                                                    ? r.re?.name ?? ""
                                                    : genDependentType(
                                                        r.type ?? "",
                                                      ),
                                                style: txtLinkSmall(
                                                  color: grayScaleColorBase,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        vpad(5),
                                        const Divider(),
                                      ],
                                    ),
                                  )
                                ],
                              );
                              return render;
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
