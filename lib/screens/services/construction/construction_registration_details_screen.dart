import 'package:app_cudan/models/construction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/timeline_view.dart';

class ConstructionRegistrationDetailsScreen extends StatefulWidget {
  const ConstructionRegistrationDetailsScreen({super.key});
  static const routeName = '/construction/reg-details';

  @override
  State<ConstructionRegistrationDetailsScreen> createState() =>
      _ConstructionRegistrationDetailsScreenState();
}

class _ConstructionRegistrationDetailsScreenState
    extends State<ConstructionRegistrationDetailsScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    ConstructionRegistration reg = ConstructionRegistration();
    if (arg['cons'] != null) {
      reg = arg['cons'];
    }
    return PrimaryScreen(
        appBar: PrimaryAppbar(
          title: S.of(context).details,
          tabController: tabController,
          isTabScrollabel: false,
          tabs: [
            Tab(text: S.of(context).details),
            Tab(text: S.of(context).history),
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            ListView(
              children: [
                vpad(24),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: PrimaryInfoWidget(
                      label: S.of(context).file_info,
                      listInfoView: [
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).reg_code,
                          content: reg.code,
                          contentStyle: txtBold(16, primaryColor1),
                        ),
                      ],
                    )),
              ],
            ),
            ListView(
              children: [
                vpad(24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TimeLineView(),
                )
              ],
            )
          ],
        ));
  }
}
