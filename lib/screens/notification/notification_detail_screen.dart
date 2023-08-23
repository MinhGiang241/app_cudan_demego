import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/utils/utils.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_info_widget.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/notification.dart';

class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({super.key});
  static const routeName = '/notification/details';

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as NotificationAccessor;
    List<InfoContentView> listInfoView = [
      InfoContentView(
        title: '${S.of(context).notification_type}',
        content: arg.message?.subject ?? '',
        //contentStyle: txtBold(14, grayScaleColorBase),
      ),
      InfoContentView(
        title: '${S.of(context).content}',
        content: arg.message?.content ?? '',
        //contentStyle: txtBold(14, grayScaleColorBase),
      ),
      InfoContentView(
        title: '${S.of(context).date}',
        content: Utils.dateTimeFormat(arg.message?.createdTime ?? '', 1),
        //contentStyle: txtBold(14, grayScaleColorBase),
      ),
      // InfoContentView(
      //   title: S.of(context).image,
      //   images: arg.message
      // )
    ];
    return PrimaryScreen(
      appBar: PrimaryAppbar(title: S.of(context).notification),
      body: SafeArea(
        child: ListView(
          children: [
            vpad(20),
            PrimaryInfoWidget(listInfoView: listInfoView),
          ],
        ),
      ),
    );
  }
}
