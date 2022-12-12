import 'package:app_cudan/widgets/primary_image_netword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/api_constant.dart';
import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/event.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});
  static const routeName = '/event/details';

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Event;
    return PrimaryScreen(
        appBar: PrimaryAppbar(
          title: S.of(context).event,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              vpad(16),
              Text(
                arg.title ?? '',
                style: txtBodyLargeBold(),
                textAlign: TextAlign.center,
              ),
              vpad(12),
              Text(
                  '${S.of(context).time_happening}: ${Utils.dateFormat(arg.start_time ?? '', 0)} - ${Utils.dateFormat(arg.end_time ?? '', 0)}',
                  style: txtRegular(14, grayScaleColorBase)),
              vpad(12),
              Text('${S.of(context).happening_location}:  ${arg.location}',
                  style: txtRegular(14, grayScaleColorBase)),
              vpad(12),
              Text(
                  '${S.of(context).end_time_reg}:  ${Utils.dateFormat(arg.approve_date ?? '', 0)}',
                  style: txtRegular(14, grayScaleColorBase)),
              if (arg.file_upload != null && arg.file_upload!.isNotEmpty)
                vpad(12),
              if (arg.file_upload != null && arg.file_upload!.isNotEmpty)
                PrimaryImageNetwork(
                  canShowPhotoView: false,
                  path:
                      "${ApiConstants.uploadURL}?load=${arg.file_upload![0].id}",
                ),
              vpad(12),
              HtmlWidget(
                '''${arg.content_event}''',
                onTapUrl: (url) {
                  launchUrl(Uri.parse(url));
                  return false;
                },
                textStyle: txtBodyMediumRegular(),
              ),
              vpad(60),
            ],
          ),
        ));
  }
}
