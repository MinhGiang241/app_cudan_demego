import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_dialog.dart';

class NotPassWidget extends StatefulWidget {
  const NotPassWidget({
    super.key,
    required this.list,
    required this.status,
  });
  final list;
  final String status;

  @override
  State<NotPassWidget> createState() => _NotPassWidgetState();
}

class _NotPassWidgetState extends State<NotPassWidget>
    with TickerProviderStateMixin {
  bool expand = false;
  late AnimationController animationItemController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));

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
              ]),
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
                  ]),
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
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    e.value['name'],
                                    textAlign: TextAlign.center,
                                    style: txtMedium(12, grayScaleColor2),
                                  )),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0),
                                                        child: Text(
                                                            "${S.of(context).asset_name}:"),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0),
                                                        child: Text(
                                                            "${e.value['name']}"),
                                                      ),
                                                    ]),
                                                    TableRow(children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0),
                                                        child: Text(
                                                            "${S.of(context).region}:"),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0),
                                                        child: Text(
                                                            e.value['region']),
                                                      ),
                                                    ]),
                                                    TableRow(children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0),
                                                        child: Text(
                                                            "${S.of(context).material}:"),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0),
                                                        child: Text(
                                                            "${e.value['material']}"),
                                                      ),
                                                    ]),
                                                    TableRow(children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0),
                                                        child: Text(
                                                            "${S.of(context).amount}:"),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0),
                                                        child: Text(e
                                                            .value['amount']
                                                            .toString()),
                                                      ),
                                                    ]),
                                                    TableRow(children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0),
                                                        child: Text(
                                                            "${S.of(context).note}:"),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
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
                                                        // widget.selectPass(true,
                                                        //     widget.index, e.key);
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

                                                        // addReasonReject(
                                                        //   () => widget.selectPass(
                                                        //       false,
                                                        //       widget.index,
                                                        //       e.key),
                                                        // );
                                                      },
                                                      buttonSize:
                                                          ButtonSize.xsmall,
                                                      buttonType:
                                                          ButtonType.red,
                                                      text: S
                                                          .of(context)
                                                          .not_pass,
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
                                  )),
                            ],
                          ),
                        ),
                      ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: (genStatusColor(widget.status)),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(8))),
                      child: Text(
                        genStatus(widget.status),
                        style: txtSemiBold(12, Colors.white),
                      ),
                    ),
                  )
                ],
              )),
        ),
        vpad(12),
      ],
    );
  }
}
