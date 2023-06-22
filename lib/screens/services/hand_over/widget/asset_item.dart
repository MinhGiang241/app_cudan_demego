// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_checkbox.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:app_cudan/widgets/select_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/asset_Item_view_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_dialog.dart';
import '../prv/accept_hand_over_prv.dart';
import 'dailog_reason.dart';

enum DetailType {
  ASSET,
  MATERIAL,
}

class AssetItem extends StatefulWidget {
  const AssetItem({
    super.key,
    this.vote = false,
    required this.data,
    required this.index,
    required this.selectPass,
    required this.region,
    required this.type,
  });
  final AssetItemViewModel data;
  final index;
  final Function(bool, String, int, DetailType) selectPass;
  final String region;
  final bool vote;
  final DetailType type;

  @override
  State<AssetItem> createState() => _AssetItemState();
}

class _AssetItemState extends State<AssetItem> with TickerProviderStateMixin {
  bool expand = false;
  late AnimationController animationItemController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  TableRow renderTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            "${title}:",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(value),
        ),
      ],
    );
  }
  // @override
  // void dispose() {
  //   animationItemController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    addReasonReject(
      function,
    ) {
      Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.custom(
          content: ReasonDailog(
            function: function,
          ),
        ),
      );
    }

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
            if (expand) {
              // isShowAsset = false;
              animationItemController.reverse();
            } else {
              // isShowAsset = true;
              animationItemController.forward();
            }
            setState(() {
              expand = !expand;
            });
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
            ],
          ),
          child: ListTile(
            title: Text(
              widget.data.title ?? '',
              style: txtRegular(14, grayScaleColorBase),
            ),
            trailing: Icon((expand) ? Icons.expand_more : Icons.expand_less),
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
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        S.of(context).stt,
                        textAlign: TextAlign.center,
                        style: txtMedium(12, grayScaleColor2),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        S.of(context).name,
                        textAlign: TextAlign.center,
                        style: txtMedium(12, grayScaleColor2),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        S.of(context).details,
                        textAlign: TextAlign.center,
                        style: txtMedium(12, grayScaleColor2),
                      ),
                    ),
                    if (widget.vote)
                      Expanded(
                        flex: 1,
                        child: Text(
                          S.of(context).pass,
                          textAlign: TextAlign.center,
                          style: txtMedium(12, grayScaleColor2),
                        ),
                      ),
                    if (widget.vote)
                      Expanded(
                        flex: 1,
                        child: Text(
                          S.of(context).not_pass,
                          textAlign: TextAlign.center,
                          style: txtMedium(12, grayScaleColor2),
                        ),
                      ),
                  ],
                ),
                ...widget.data.list.asMap().entries.map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                (e.key + 1).toString(),
                                textAlign: TextAlign.center,
                                style: txtMedium(13),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                e.value.name ?? "",
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
                                      title: widget.type == DetailType.ASSET
                                          ? S.of(context).asset_details
                                          : S.of(context).material_details,
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
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
                                                renderTableRow(
                                                  S.of(context).location,
                                                  widget.region,
                                                ),
                                                renderTableRow(
                                                  S.of(context).asset,
                                                  "${e.value.name}",
                                                ),
                                                renderTableRow(
                                                  widget.type ==
                                                          DetailType.MATERIAL
                                                      ? S
                                                          .of(context)
                                                          .material_specification
                                                      : S.of(context).material,
                                                  e.value.material_specification ??
                                                      "",
                                                ),
                                                renderTableRow(
                                                  S.of(context).brand,
                                                  "${e.value.brand}",
                                                ),
                                                if (widget.type ==
                                                    DetailType.ASSET)
                                                  renderTableRow(
                                                    S.of(context).amount,
                                                    e.value.amount.toString(),
                                                  ),
                                                if (widget.type ==
                                                    DetailType.ASSET)
                                                  renderTableRow(
                                                    S.of(context).unit_count,
                                                    e.value.unit ?? '',
                                                  ),
                                                renderTableRow(
                                                  S.of(context).note,
                                                  e.value.note ?? '',
                                                ),
                                              ],
                                            ),
                                            vpad(12),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: PrimaryButton(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      widget.selectPass(
                                                        true,
                                                        widget.index,
                                                        e.key,
                                                        widget.type,
                                                      );
                                                    },
                                                    buttonSize:
                                                        ButtonSize.xsmall,
                                                    buttonType:
                                                        ButtonType.primary,
                                                    text: S.of(context).pass,
                                                  ),
                                                ),
                                                hpad(30),
                                                Expanded(
                                                  child: PrimaryButton(
                                                    onTap: () {
                                                      Navigator.pop(context);

                                                      addReasonReject(
                                                        () => widget.selectPass(
                                                          false,
                                                          widget.index,
                                                          e.key,
                                                          widget.type,
                                                        ),
                                                      );
                                                    },
                                                    buttonSize:
                                                        ButtonSize.xsmall,
                                                    buttonType: ButtonType.red,
                                                    text:
                                                        S.of(context).not_pass,
                                                  ),
                                                )
                                              ],
                                            ),
                                            vpad(12),
                                            PrimaryButton(
                                              width: double.infinity,
                                              text: S.of(context).cancel,
                                              buttonType: ButtonType.secondary,
                                              secondaryBackgroundColor:
                                                  redColor4,
                                              textColor: redColor1,
                                              buttonSize: ButtonSize.xsmall,
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  S.of(context).view,
                                  textAlign: TextAlign.center,
                                  style: txtSemiBoldUnderline(
                                    13,
                                    greenColorBase,
                                  ),
                                ),
                              ),
                            ),
                            if (widget.vote)
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Checkbox(
                                    onChanged: (v) {
                                      widget.selectPass(
                                        true,
                                        widget.index,
                                        e.key,
                                        widget.type,
                                      );
                                    },
                                    value: e.value.achieve,
                                  ),
                                ),
                              ),
                            if (widget.vote)
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Checkbox(
                                    onChanged: (v) {
                                      addReasonReject(
                                        () => widget.selectPass(
                                          false,
                                          widget.index,
                                          e.key,
                                          widget.type,
                                        ),
                                      );
                                    },
                                    value: !e.value.achieve,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
