import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../models/response_thecudan_list.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_card.dart';
import '../../r_card/r_card_info.dart';

class RecidentInfoTab extends StatelessWidget {
  const RecidentInfoTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        vpad(24),
        const RecidentInfoItem(
          isShowInit: true,
        ),
        const RecidentInfoItem(
          isShowInit: false,
        )
      ],
    );
  }
}

class RecidentInfoItem extends StatefulWidget {
  const RecidentInfoItem({
    Key? key,
    this.isShowInit = false,
    this.header,
    this.hide,
    this.show,
  }) : super(key: key);
  final bool isShowInit;
  final Widget? header;
  final Widget? hide;
  final Widget? show;

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
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
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
                                Text("Nguyễn Văn A", style: txtMedium()),
                            if (!isShow)
                              widget.hide ??
                                  Column(
                                    children: [
                                      vpad(8),
                                      Row(
                                        children: [
                                          Text("QH với chủ hộ:",
                                              style: txtRegular(
                                                  12, grayScaleColor2)),
                                          hpad(4),
                                          Text(
                                            "Chủ sở hữu",
                                            style:
                                                txtRegular(12, grayScaleColor1),
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
                                          child: Text("QH với chủ hộ",
                                              style: txtMedium(
                                                  14, grayScaleColor2)),
                                        ),
                                        hpad(16),
                                        Text("Chủ sở hữu",
                                            style: txtLinkSmall(
                                                color: grayScaleColorBase))
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
                                                  Text("Thẻ cư dân",
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
