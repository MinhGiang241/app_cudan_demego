// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:app_cudan/models/file_upload.dart';
import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/models/workarising.dart';
import 'package:app_cudan/services/api_hand_over.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:app_cudan/widgets/select_media_widget.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/asset_Item_view_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_dialog.dart';
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
    required this.selectPass,
    required this.region,
    required this.type,
    required this.keyMap,
    required this.complete,
    required this.functionSave,
  });
  final AssetItemViewModel data;
  final String keyMap;
  final Function(
    bool,
    String,
    int,
    DetailType,
    List<FileUploadModel>,
    String,
  ) selectPass;
  final String region;
  final bool vote;
  final bool complete;
  final DetailType type;
  final Function functionSave;

  @override
  State<AssetItem> createState() => _AssetItemState();
}

class _AssetItemState extends State<AssetItem> with TickerProviderStateMixin {
  bool expand = false;
  late AnimationController animationItemController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  TableRow renderTableRow(String title, String value, TextStyle? style) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            "${title}:",
            style: txtBodySmallRegular(color: grayScaleColorBase),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            value,
            style: style ?? txtBodySmallRegular(color: grayScaleColorBase),
          ),
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
    addReasonReject(function, functionSave, int index) {
      Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.custom(
          content: ReasonDailog(
            functionSave: functionSave,
            type: widget.type,
            function: function,
            data: widget.data,
            index: index,
            keyMap: widget.keyMap,
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
                        S.of(context).category_name,
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
                    if (widget.complete)
                      Expanded(
                        flex: 1,
                        child: Text(
                          S.of(context).pass,
                          textAlign: TextAlign.center,
                          style: txtMedium(12, grayScaleColor2),
                        ),
                      ),
                    if (widget.complete)
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
                      (e) => FutureBuilder(
                        future: () async {
                          var a = await APIHandOver.getResultsWorkByVirtualId(
                            e.value.virtualId ?? '',
                            widget.data.handOverId,
                          );
                          return a;
                        }(),
                        builder: (context, snapshot) {
                          WorkArising? work;
                          if (snapshot.data != null) {
                            work = WorkArising.fromMap(snapshot.data);
                          }

                          print(work);
                          return Padding(
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
                                                      null,
                                                    ),
                                                    renderTableRow(
                                                      S.of(context).asset,
                                                      "${e.value.name}",
                                                      null,
                                                    ),
                                                    renderTableRow(
                                                      widget.type ==
                                                              DetailType
                                                                  .MATERIAL
                                                          ? S
                                                              .of(context)
                                                              .material_specification
                                                          : S
                                                              .of(context)
                                                              .material0,
                                                      e.value.material_specification ??
                                                          "",
                                                      null,
                                                    ),
                                                    renderTableRow(
                                                      S.of(context).brand,
                                                      "${e.value.brand}",
                                                      null,
                                                    ),
                                                    if (widget.type ==
                                                        DetailType.ASSET)
                                                      renderTableRow(
                                                        S.of(context).amount,
                                                        e.value.amount
                                                            .toString(),
                                                        null,
                                                      ),
                                                    if (widget.type ==
                                                        DetailType.ASSET)
                                                      renderTableRow(
                                                        S
                                                            .of(context)
                                                            .unit_count,
                                                        e.value.unit ?? '',
                                                        null,
                                                      ),
                                                    renderTableRow(
                                                      S.of(context).note,
                                                      e.value.note ?? '',
                                                      null,
                                                    ),
                                                    renderTableRow(
                                                      S.of(context).status,
                                                      e.value.achieve == true
                                                          ? S.of(context).pass
                                                          : e.value.not_achieve ==
                                                                  true
                                                              ? S
                                                                  .of(context)
                                                                  .not_pass
                                                              : '',
                                                      (e.value.achieve == true
                                                          ? txtBold(
                                                              14,
                                                              primaryColorBase,
                                                            )
                                                          : txtBold(
                                                              14,
                                                              redColorBase,
                                                            )),
                                                    ),
                                                  ],
                                                ),
                                                vpad(12),
                                                SelectMediaWidget(
                                                  enable: false,
                                                  title:
                                                      S.of(context).file_image,
                                                  existImages: e.value.photos,
                                                ),
                                                if (e.value.error_notpass !=
                                                    null)
                                                  vpad(12),
                                                if (e.value.error_notpass !=
                                                    null)
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S
                                                          .of(context)
                                                          .not_pass_reason,
                                                      style: txtBodySmallBold(
                                                        color:
                                                            grayScaleColorBase,
                                                      ),
                                                    ),
                                                  ),
                                                if (e.value.error_notpass !=
                                                    null)
                                                  vpad(12),
                                                if (e.value.error_notpass !=
                                                    null)
                                                  PrimaryTextField(
                                                    // label: S
                                                    //     .of(context)
                                                    //     .not_pass_reason,
                                                    enable: false,
                                                    initialValue:
                                                        e.value.error_notpass,
                                                    maxLines: 2,
                                                  ),
                                                if (e.value.photosError
                                                    .isNotEmpty)
                                                  vpad(12),
                                                if (e.value.photosError
                                                    .isNotEmpty)
                                                  SelectMediaWidget(
                                                    enable: false,
                                                    title: S
                                                        .of(context)
                                                        .file_image,
                                                    existImages:
                                                        e.value.photosError,
                                                  ),
                                                if (work?.to_do_list_result?[0]
                                                        .result !=
                                                    null)
                                                  vpad(12),
                                                if (work?.to_do_list_result?[0]
                                                        .result !=
                                                    null)
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S
                                                          .of(context)
                                                          .processing_result,
                                                      style: txtBodySmallBold(
                                                        color:
                                                            grayScaleColorBase,
                                                      ),
                                                    ),
                                                  ),
                                                if (work?.to_do_list_result?[0]
                                                        .result !=
                                                    null)
                                                  vpad(12),
                                                if (work?.to_do_list_result?[0]
                                                        .result !=
                                                    null)
                                                  PrimaryTextField(
                                                    label: S
                                                        .of(context)
                                                        .processing_content,
                                                    enable: false,
                                                    initialValue: work
                                                        ?.to_do_list_result?[0]
                                                        .result,
                                                    maxLines: 2,
                                                  ),
                                                if ((work?.to_do_list_result?[0]
                                                            .file ??
                                                        [])
                                                    .isNotEmpty)
                                                  vpad(12),
                                                if ((work?.to_do_list_result?[0]
                                                            .file ??
                                                        [])
                                                    .isNotEmpty)
                                                  SelectMediaWidget(
                                                    enable: false,
                                                    title: S
                                                        .of(context)
                                                        .file_image,
                                                    existImages: work
                                                            ?.to_do_list_result?[
                                                                0]
                                                            .file ??
                                                        [],
                                                  ),
                                                vpad(12),
                                                if (widget.vote)
                                                  Row(
                                                    children: [
                                                      if (e.value.not_achieve !=
                                                          true)
                                                        Expanded(
                                                          child: PrimaryButton(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                context,
                                                              );

                                                              addReasonReject(
                                                                () => widget
                                                                    .selectPass(
                                                                  false,
                                                                  widget.keyMap,
                                                                  e.key,
                                                                  widget.type,
                                                                  e.value
                                                                      .photos,
                                                                  '',
                                                                ),
                                                                widget
                                                                    .functionSave,
                                                                e.key,
                                                              );
                                                            },
                                                            buttonSize:
                                                                ButtonSize
                                                                    .xsmall,
                                                            buttonType:
                                                                ButtonType.red,
                                                            text: S
                                                                .of(context)
                                                                .not_pass,
                                                          ),
                                                        ),
                                                      if (e.value.achieve !=
                                                              true &&
                                                          e.value.not_achieve !=
                                                              true)
                                                        hpad(10),
                                                      if (e.value.achieve !=
                                                          true)
                                                        Expanded(
                                                          child: PrimaryButton(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                              widget.selectPass(
                                                                true,
                                                                widget.keyMap,
                                                                e.key,
                                                                widget.type,
                                                                e.value.photos,
                                                                '',
                                                              );
                                                            },
                                                            buttonSize:
                                                                ButtonSize
                                                                    .xsmall,
                                                            buttonType:
                                                                ButtonType
                                                                    .green,
                                                            text: S
                                                                .of(context)
                                                                .pass,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                vpad(12),
                                                PrimaryButton(
                                                  width: double.infinity,
                                                  text: S.of(context).close,
                                                  buttonType:
                                                      ButtonType.secondary,
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
                                if (widget.complete)
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Checkbox(
                                        onChanged: (v) {
                                          widget.vote
                                              ? widget.selectPass(
                                                  true,
                                                  widget.keyMap,
                                                  e.key,
                                                  widget.type,
                                                  e.value.photos,
                                                  '',
                                                )
                                              : null;
                                        },
                                        value: e.value.achieve,
                                      ),
                                    ),
                                  ),
                                if (widget.complete)
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Checkbox(
                                        onChanged: (v) {
                                          widget.vote
                                              ? addReasonReject(
                                                  () => widget.selectPass(
                                                    false,
                                                    widget.keyMap,
                                                    e.key,
                                                    widget.type,
                                                    e.value.photos,
                                                    '',
                                                  ),
                                                  widget.functionSave,
                                                  e.key,
                                                )
                                              : null;
                                        },
                                        value: e.value.not_achieve,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
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
