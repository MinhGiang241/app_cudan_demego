import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_revenues.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
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
              WebViewController controller = WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setBackgroundColor(const Color(0x00000000))
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {
                      // Update loading bar.
                    },
                    onPageStarted: (String url) {},
                    onPageFinished: (String url) {},
                    onWebResourceError: (WebResourceError error) {},
                    onNavigationRequest: (NavigationRequest request) {
                      if (request.url.startsWith(htmlWidget ?? '')) {
                        return NavigationDecision.prevent;
                      }
                      return NavigationDecision.navigate;
                    },
                  ),
                )
                ..loadRequest(Uri.parse(htmlWidget ?? ''));
              if (htmlWidget != null) {
                return WebViewWidget(controller: controller);
              }
              return vpad(0);
            },
          ),
        );
      },
    );
  }
}
