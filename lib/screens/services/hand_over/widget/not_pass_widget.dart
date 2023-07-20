import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_dialog.dart';

class NotPassWidget extends StatefulWidget {
  const NotPassWidget({
    super.key,
    required this.list,
    required this.status,
    required this.selectItem,
  });

  final List list;
  final String status;
  final Function selectItem;

  @override
  State<NotPassWidget> createState() => _NotPassWidgetState();
}

class _NotPassWidgetState extends State<NotPassWidget>
    with TickerProviderStateMixin {
  bool expand = false;
  late AnimationController animationItemController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  addReasonReject(
    function,
  ) {
    // Utils.showDialog(
    //     context: context,
    //     dialog: PrimaryDialog.custom(
    //         content: ReasonDailog(
    //       type: DetailType.ASSET,
    //       function: function,
    //     )));
  }

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
            if (expand) {
              animationItemController.reverse();
            } else {
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
              "Tài sản không đạt",
              style: txtRegular(14, grayScaleColorBase),
            ),
            trailing: Icon(expand ? Icons.expand_more : Icons.expand_less),
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
                ...widget.list.asMap().entries.map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                e.value['amount'].toString(),
                                textAlign: TextAlign.center,
                                style: txtMedium(12, grayScaleColor2),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                e.value['name'],
                                textAlign: TextAlign.center,
                                style: txtMedium(12, grayScaleColor2),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Utils.showDialog(
                                    context: context,
                                    dialog: PrimaryDialog.custom(
                                      title: S.of(context).asset_details,
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
                                                TableRow(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8.0,
                                                      ),
                                                      child: Text(
                                                        "${S.of(context).asset_name}:",
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8.0,
                                                      ),
                                                      child: Text(
                                                        "${e.value['name']}",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                TableRow(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8.0,
                                                      ),
                                                      child: Text(
                                                        "${S.of(context).region}:",
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8.0,
                                                      ),
                                                      child: Text(
                                                        e.value['region'],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                TableRow(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8.0,
                                                      ),
                                                      child: Text(
                                                        "${S.of(context).material}:",
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8.0,
                                                      ),
                                                      child: Text(
                                                        "${e.value['material']}",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                TableRow(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8.0,
                                                      ),
                                                      child: Text(
                                                        "${S.of(context).amount}:",
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8.0,
                                                      ),
                                                      child: Text(
                                                        e.value['amount']
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                TableRow(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8.0,
                                                      ),
                                                      child: Text(
                                                        "${S.of(context).note}:",
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                      ),
                                                      child: Text("${1}"),
                                                    ),
                                                  ],
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
                                                      widget.selectItem(
                                                        true,
                                                        e.value['indexRegion'],
                                                        e.value['indexAsset'],
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
                                                        () => widget.selectItem(
                                                          false,
                                                          e.value[
                                                              'indexRegion'],
                                                          e.value['indexAsset'],
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
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Xem",
                                  textAlign: TextAlign.center,
                                  style: txtSemiBoldUnderline(
                                    13,
                                    greenColorBase,
                                  ),
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
        vpad(12),
      ],
    );
  }
}
