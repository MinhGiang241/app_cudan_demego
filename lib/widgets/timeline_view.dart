import 'package:app_cudan/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../models/timeline_model.dart';
import '../utils/utils.dart';
import 'primary_card.dart';

// ignore: must_be_immutable
class TimeLineView extends StatelessWidget {
  TimeLineView({Key? key, this.content = const []}) : super(key: key);
  List<TimelineModel> content = [];
  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FixedTimeline.tileBuilder(
          builder: TimelineTileBuilder(
            contentsAlign: ContentsAlign.basic,
            startConnectorBuilder: (context, i) {
              return SolidLineConnector(
                thickness: 2,
                color: content[i].color ??
                    (i == 0 ? Colors.transparent : grayScaleColor3),
              );
            },
            endConnectorBuilder: (context, i) => SolidLineConnector(
              thickness: 2,
              color: content[i].color ??
                  (i == 9 ? Colors.transparent : grayScaleColor3),
            ),
            indicatorBuilder: (context, i) => DotIndicator(
              color:
                  content[i].color ?? (i == 0 ? yellowColor1 : greenColorBase),
            ),
            indicatorPositionBuilder: (context, i) => 0,
            nodePositionBuilder: (context, i) {
              return 0.3;
            },
            oppositeContentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 16),
              child: content.isNotEmpty
                  ? Text(
                      Utils.dateTimeFormat(content[index].date ?? "", 1),
                      style: txtRegular(
                        10,
                        content[index].color ??
                            (index == 0 ? yellowColor1 : greenColorBase),
                      ),
                    )
                  : Text(
                      '20/04\n11:00',
                      style: txtRegular(
                        10,
                        content[index].color ??
                            (index == 0 ? yellowColor1 : greenColorBase),
                      ),
                    ),
            ),
            contentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content.isNotEmpty
                    ? [
                        if (index != 0)
                          Text(
                            content[index].title ?? "",
                            style: txtLinkXSmall(
                              color: content[index].color ?? greenColorBase,
                            ),
                          ),
                        if (index != 0 && content[index].subTitle != null)
                          Text(
                            content[index].subTitle ?? "",
                            style: txtLinkXXSmall(
                              color: content[index].color ?? greenColorBase,
                            ),
                          ),
                        if (index == 0)
                          Text(
                            content[index].title ?? "",
                            style: txtLinkXSmall(
                              color: content[index].color ?? yellowColor1,
                            ),
                          ),
                        if (index == 0 && content[index].subTitle != null)
                          Text(
                            content[index].subTitle ?? "",
                            style: txtLinkXXSmall(
                              color: content[index].color ?? yellowColor1,
                            ),
                          )
                      ]
                    : [
                        if (index != 0)
                          Text(
                            'Tiêu đề timeline',
                            style: txtLinkXSmall(color: greenColorBase),
                          ),
                        if (index != 0)
                          Text(
                            'Hoàn thành',
                            style: txtMedium(12, greenColorBase),
                          ),
                        if (index == 0)
                          Text(
                            'Tiêu đề timeline',
                            style: txtLinkXSmall(color: yellowColor1),
                          ),
                        if (index == 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'Nơi xử lý : ....',
                              style: txtMedium(12, yellowColor1),
                            ),
                          ),
                        if (index == 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'Trạng thái : Đang xử lý',
                              style: txtMedium(12, yellowColor1),
                            ),
                          ),
                      ],
              ),
            ),
            itemCount: content.length,
          ),
        ),
      ),
    );
  }
}
