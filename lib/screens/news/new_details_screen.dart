import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/api_constant.dart';
import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/new.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_image_netword.dart';
import '../../widgets/primary_screen.dart';

class NewDetailsScreen extends StatelessWidget {
  static const routeName = '/new/details';
  const NewDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as New;

    return PrimaryScreen(
        appBar: PrimaryAppbar(
          title: S.of(context).news,
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
              Text(Utils.dateFormat(arg.date ?? '', 1),
                  style: txtRegular(14, grayScaleColorBase)),
              vpad(12),
              Text(arg.content ?? '', style: txtBodyMediumRegular()),
              vpad(16),
              if (arg.image != null)
                PrimaryImageNetwork(
                  canShowPhotoView: false,
                  path: "${ApiConstants.uploadURL}?load=${arg.image}",
                ),

              vpad(16),
              // Text(document.outerHtml),
              HtmlWidget(
                '''${arg.detail}''',
                onTapUrl: (url) {
                  launchUrl(Uri.parse(url));
                  return false;
                },
                textStyle: txtBodyMediumRegular(),
                // onTapImage: (v) {
                //   launchUrl(Uri.parse(v.sources.first.url));
                // },
              ),
              vpad(60),
            ],
          ),
        ));
  }
}
