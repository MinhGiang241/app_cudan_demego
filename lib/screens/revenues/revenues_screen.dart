// ignore_for_file: unused_import

import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/components/HtmlViewerWidget.dart';
import 'package:app_cudan/screens/components/WebViewerWidget.dart';
import 'package:app_cudan/services/api_revenues.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../widgets/primary_image_netword.dart';
import '../../widgets/primary_loading.dart';
import '../../widgets/primary_screen.dart';
import 'prv/revenues_prv.dart';


class RevenuesScreen extends StatelessWidget {
  const RevenuesScreen({super.key});
  static const routeName = '/revenues';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RevenuesPrv(),
      builder: (context, state) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).revenues,
          ),
          body: FutureBuilder(
            future: context.read<RevenuesPrv>().get(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: PrimaryLoading(),
                );
              }
              var htmlWidget = context.watch<RevenuesPrv>().htmlWidget;
              if (htmlWidget != null) {

                return HtmlViewerWidget(htmlContent: htmlWidget,withAppBar: false,);
              }
              return vpad(0);
            },
          ),
        );
      },
    );
  }
}
