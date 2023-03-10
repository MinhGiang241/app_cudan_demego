import 'dart:async';
import 'dart:math';

import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_tower.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/response_resident_own.dart';
import '../../../../models/response_thecudan_list.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_card.dart';
import '../../r_card/r_card_info.dart';

class ResidentInfoTab extends StatelessWidget {
  const ResidentInfoTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ResponseResidentOwn> listResOwn = [];
    var apartmentId =
        context.read<ResidentInfoPrv>().selectedApartment?.apartmentId;
    return FutureBuilder(future: () async {
      listResOwn.clear();
      await APITower.getResidentOwnInfo(apartmentId).then((v) {
        for (var i in v) {
          listResOwn.add(ResponseResidentOwn.fromJson(i));
        }
      });
    }(), builder: (context, snapshot) {
      return ListView(
        children: [
          vpad(24),
          ...listResOwn.asMap().entries.map((e) {
            return RecidentInfoItem(
              isShowInit: e.key == 0,
              own: e.value,
            );
          }),
        ],
      );
    });
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

class RecidentInfoItem extends StatefulWidget {
  const RecidentInfoItem({
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
  final ResponseResidentOwn own;

  @override
  State<RecidentInfoItem> createState() => _RecidentInfoItemState();
}

class _RecidentInfoItemState extends State<RecidentInfoItem>
    with TickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));
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
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
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
                                Text(
                                  widget.own.resident?.info_name ?? "",
                                  style: txtMedium(),
                                ),
                            if (!isShow)
                              widget.hide ??
                                  Column(
                                    children: [
                                      vpad(8),
                                      Row(
                                        children: [
                                          Text(
                                              '${S.of(context).relation_owner}:',
                                              style: txtRegular(
                                                  12, grayScaleColor2)),
                                          hpad(4),
                                          Expanded(
                                            child: Text(
                                              genDependentType(widget.own.type),
                                              style: txtRegular(
                                                  12, grayScaleColor1),
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
                                      vpad(16),
                                      Row(children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                              '${S.of(context).relation_owner}:',
                                              style: txtMedium(
                                                  14, grayScaleColor2)),
                                        ),
                                        hpad(16),
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                              genDependentType(widget.own.type),
                                              style: txtLinkSmall(
                                                  color: grayScaleColorBase)),
                                        )
                                      ]),
                                    ],
                                  ),
                            if (isShow && widget.show == null)
                              ...List.generate(
                                  2,
                                  (index) => Column(
                                        children: [
                                          vpad(16),
                                          const Divider(),
                                          vpad(16),
                                          InkWell(
                                            onTap: () {
                                              Utils.pushScreen(
                                                  context,
                                                  RecidentCardInfo(
                                                    items: TheCuDanItems(),
                                                  ));
                                            },
                                            child: Column(
                                              children: [
                                                Row(children: [
                                                  Text("Thẻ cư dân:",
                                                      style: txtMedium(
                                                          14, grayScaleColor2)),
                                                  const Spacer(),
                                                  Text("Hoạt động",
                                                      style: txtLinkSmall(
                                                          color:
                                                              greenColorBase))
                                                ]),
                                                vpad(8),
                                                Row(children: [
                                                  Text("0XXXXXXXXX",
                                                      style: txtMedium(14)),
                                                  const Spacer(),
                                                  const Icon(Icons
                                                      .chevron_right_rounded)
                                                ]),
                                              ],
                                            ),
                                          )
                                        ],
                                      ))
                          ],
                        );
                      }),
                )),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) => Transform.rotate(
                              angle: rotateAnimation.value,
                              child: child,
                            ),
                        child: const Icon(Icons.keyboard_arrow_down_rounded)))
              ],
            ),
          )),
    );
  }
}
