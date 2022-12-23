import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/info_content_view.dart';
import 'primary_button.dart';
import 'primary_card.dart';
import 'primary_image_netword.dart';

class PrimaryInfoWidget extends StatelessWidget {
  const PrimaryInfoWidget({
    Key? key,
    required this.listInfoView,
    this.label,
    this.child,
  }) : super(key: key);

  final List<InfoContentView> listInfoView;
  final String? label;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (label != null) Text(label!, style: txtMedium(14, grayScaleColor2)),
      if (label != null) vpad(12),
      PrimaryCard(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Wrap(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(listInfoView.length, (index) {
                  if (listInfoView[index].isCheckType) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Text("${listInfoView[index].title} :",
                              style: txtMedium(14, grayScaleColor2)),
                          hpad(16),
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: listInfoView[index].isCheck,
                              onChanged: (v) {},
                              checkColor: Colors.white,
                              activeColor: secondaryColor2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  if (listInfoView[index].isHorizontal) {
                    return Table(
                      textBaseline: TextBaseline.ideographic,
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.baseline,
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(3)
                      },
                      children: [
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text("${listInfoView[index].title}:",
                                style: txtMedium(14, grayScaleColor2)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(listInfoView[index].content ?? "",
                                style: listInfoView[index].contentStyle),
                          ),
                        ])
                      ],
                    );
                  }
                  return SizedBox(
                    width: (listInfoView[index].rowKey != null)
                        ? (MediaQuery.of(context).size.width) / 3
                        : double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${listInfoView[index].title}:",
                              style: txtMedium(14, grayScaleColor2)),
                          vpad(6),
                          if (listInfoView[index].content != null)
                            Text("${listInfoView[index].content}",
                                style: listInfoView[index].contentStyle),
                          if (listInfoView[index].images != null) vpad(6),
                          if (listInfoView[index].images != null)
                            SizedBox(
                              height: 116,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: listInfoView[index].images!.length,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 14),
                                      child: PrimaryImageNetwork(
                                          path: listInfoView[index].images![i],
                                          width: 220),
                                    );
                                  }),
                            ),
                          if (listInfoView[index].dateRange != null) vpad(6),
                          if (listInfoView[index].dateRange != null)
                            Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: List.generate(
                                  listInfoView[index].dateRange!.length,
                                  (i) => PrimaryButton(
                                    text: listInfoView[index].dateRange![i],
                                    buttonType: ButtonType.secondary,
                                    buttonSize: ButtonSize.small,
                                    textColor: primaryColor1,
                                  ),
                                )),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              if (child != null) child!
            ],
          ),
        ),
      )),
    ]);
  }
}
