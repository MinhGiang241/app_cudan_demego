import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/response_thecudan_list.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/timeline_view.dart';

class RecidentCardInfo extends StatefulWidget {
  const RecidentCardInfo({Key? key, required this.items}) : super(key: key);

  final TheCuDanItems items;

  @override
  State<RecidentCardInfo> createState() => _RecidentCardInfoState();
}

class _RecidentCardInfoState extends State<RecidentCardInfo>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: ' S.of(context).r_card_details',
        tabController: tabController,
        isTabScrollabel: false,
        tabs: [
          Tab(text: 'S.of(context).details'),
          Tab(text: 'S.of(context).timeline'),
        ],
      ),
      body: TabBarView(controller: tabController, children: [
        ListView(
          children: [
            vpad(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: PrimaryInfoWidget(
                  lable: 'S.of(context).r_card_info',
                  listInfoView: [
                    InfoContentView(
                        title: 'S.of(context).signal',
                        content: widget.items.theCuDan?.soThe?.text ?? ""),
                    InfoContentView(
                        title: 'S.of(context).plan_name',
                        content:
                            widget.items.theCuDan?.canHo?.displayTexts?[0] ??
                                ""),
                    InfoContentView(
                        title: S.of(context).full_name,
                        content:
                            widget.items.theCuDan?.chuThe?.displayTexts?[0] ??
                                ""),
                    InfoContentView(
                        title: S.of(context).phone_num,
                        content:
                            widget.items.theCuDan?.soDienThoai?.text ?? ""),
                    InfoContentView(
                        title: 'S.of(context).card_num',
                        content: widget.items.theCuDan?.soThe?.text ?? ""),
                    InfoContentView(
                        title: S.of(context).status,
                        content: 'S.of(context).active',
                        contentStyle: txtLinkSmall(color: greenColorBase)),
                  ]),
            )
          ],
        ),
        ListView(
          children: [
            vpad(24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TimeLineView(),
            )
          ],
        )
      ]),
    );
  }
}
