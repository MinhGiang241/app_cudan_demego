import 'package:app_cudan/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import 'primary_card.dart';

class TimeLineView extends StatelessWidget {
  const TimeLineView({
    Key? key,
  }) : super(key: key);

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
                color: i == 0 ? Colors.transparent : grayScaleColor3);
          },
          endConnectorBuilder: (context, i) => SolidLineConnector(
              thickness: 2,
              color: i == 9 ? Colors.transparent : grayScaleColor3),
          indicatorBuilder: (context, i) =>
              DotIndicator(color: i == 0 ? yellowColor1 : greenColorBase),
          indicatorPositionBuilder: (context, i) => 0,
          nodePositionBuilder: (context, i) {
            return 0.15;
          },
          oppositeContentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 16),
            child: Text('20/04\n11:00',
                style:
                    txtRegular(10, index == 0 ? yellowColor1 : greenColorBase)),
          ),
          contentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index != 0)
                  Text('Tiêu đề timeline',
                      style: txtLinkXSmall(color: greenColorBase)),
                if (index != 0)
                  Text('Hoàn thành', style: txtMedium(12, greenColorBase)),
                if (index == 0)
                  Text('Tiêu đề timeline',
                      style: txtLinkXSmall(color: yellowColor1)),
                if (index == 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text('Nơi xử lý : ....',
                        style: txtMedium(12, yellowColor1)),
                  ),
                if (index == 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text('Trạng thái : Đang xử lý',
                        style: txtMedium(12, yellowColor1)),
                  ),
              ],
            ),
          ),
          itemCount: 10,
        ),
      ),
    ));
  }
}
