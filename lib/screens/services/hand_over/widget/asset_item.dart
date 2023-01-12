// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_dialog.dart';
import '../prv/accept_hand_over_prv.dart';

class AssetItem extends StatefulWidget {
  const AssetItem(
      {super.key,
      required this.data,
      required this.index,
      required this.selectPass,
      required this.toggleAssetExpand,
      required this.region});
  final data;
  final index;
  final Function(bool, int, int) selectPass;
  final Function(int) toggleAssetExpand;
  final String region;

  @override
  State<AssetItem> createState() => _AssetItemState();
}

class _AssetItemState extends State<AssetItem> with TickerProviderStateMixin {
  late AnimationController animationItemController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));

  // @override
  // void dispose() {
  //   animationItemController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Animation<double> animationItemDrop = CurvedAnimation(
      parent: animationItemController,
      curve: Curves.easeInOut,
      // reverseCurve: Curves.easeInOut,
    );

    return Column(
      children: [
        vpad(12),
        PrimaryCard(
          onTap: () {
            if (widget.data['expand'] as bool) {
              // isShowAsset = false;
              animationItemController.reverse();
            } else {
              // isShowAsset = true;
              animationItemController.forward();
            }

            return widget.toggleAssetExpand(widget.index);
          },
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                  blurRadius: 2,
                ),
              ]),
          child: ListTile(
            title: Text(
              widget.data["title"] as String,
              style: txtRegular(14, grayScaleColorBase),
            ),
            trailing: Icon((widget.data['expand'] as bool)
                ? Icons.expand_more
                : Icons.expand_less),
          ),
        ),
        SizeTransition(
          sizeFactor: animationItemDrop,
          child: PrimaryCard(
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Đạt',
                          textAlign: TextAlign.center,
                          style: txtMedium(12, grayScaleColor2),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Không đạt',
                          textAlign: TextAlign.center,
                          style: txtMedium(12, grayScaleColor2),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Số lượng',
                          textAlign: TextAlign.center,
                          style: txtMedium(12, grayScaleColor2),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Tên',
                          textAlign: TextAlign.center,
                          style: txtMedium(12, grayScaleColor2),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Chi tiết',
                          textAlign: TextAlign.center,
                          style: txtMedium(12, grayScaleColor2),
                        ),
                      ),
                    ],
                  ),
                  ...widget.data["assets"].asMap().entries.map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Checkbox(
                                        onChanged: (v) {
                                          widget.selectPass(
                                              true, widget.index, e.key);
                                        },
                                        value: e.value['pass'])),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Checkbox(
                                        onChanged: (v) {
                                          widget.selectPass(
                                              false, widget.index, e.key);
                                        },
                                        value: !e.value['pass'])),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  e.value['amount'].toString(),
                                  textAlign: TextAlign.center,
                                  style: txtMedium(13),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  e.value['name'].toString(),
                                  textAlign: TextAlign.center,
                                  style: txtMedium(13),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Utils.showDialog(
                                        context: context,
                                        dialog: PrimaryDialog.custom(
                                          title: S.of(context).asset_detais,
                                          content: SingleChildScrollView(
                                            child: Column(children: [
                                              Table(
                                                textBaseline:
                                                    TextBaseline.ideographic,
                                                defaultVerticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .baseline,
                                                columnWidths: const {
                                                  0: FlexColumnWidth(3),
                                                  1: FlexColumnWidth(3)
                                                },
                                                children: [
                                                  TableRow(children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                          "${S.of(context).asset_name}:"),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                          "${e.value['name']}"),
                                                    ),
                                                  ]),
                                                  TableRow(children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                          "${S.of(context).region}:"),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child:
                                                          Text(widget.region),
                                                    ),
                                                  ]),
                                                  TableRow(children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                          "${S.of(context).material}:"),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                          "${e.value['material']}"),
                                                    ),
                                                  ]),
                                                  TableRow(children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                          "${S.of(context).amount}:"),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(e
                                                          .value['amount']
                                                          .toString()),
                                                    ),
                                                  ]),
                                                  TableRow(children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                          "${S.of(context).note}:"),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8.0),
                                                      child: Text("${1}"),
                                                    ),
                                                  ]),
                                                ],
                                              ),
                                              vpad(12),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: PrimaryButton(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      widget.selectPass(true,
                                                          widget.index, e.key);
                                                    },
                                                    buttonSize:
                                                        ButtonSize.xsmall,
                                                    buttonType:
                                                        ButtonType.primary,
                                                    text: S.of(context).pass,
                                                  )),
                                                  hpad(30),
                                                  Expanded(
                                                      child: PrimaryButton(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      widget.selectPass(false,
                                                          widget.index, e.key);
                                                    },
                                                    buttonSize:
                                                        ButtonSize.xsmall,
                                                    buttonType: ButtonType.red,
                                                    text:
                                                        S.of(context).not_pass,
                                                  ))
                                                ],
                                              )
                                            ]),
                                          ),
                                        ));
                                  },
                                  child: Text(
                                    "Xem",
                                    textAlign: TextAlign.center,
                                    style: txtSemiBoldUnderline(
                                        13, greenColorBase),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              )),
        ),
      ],
    );
  }
}
