import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlViewerWidget extends StatefulWidget {
  final String title;
  final String htmlContent;
  final bool withAppBar;
  const HtmlViewerWidget({required this.htmlContent,this.title="",this.withAppBar=true});

  @override
  State<HtmlViewerWidget> createState() => _HtmlViewerWidgetState();
}

class _HtmlViewerWidgetState extends State<HtmlViewerWidget> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {

            if (request.url.startsWith("http")) {
              // launchUrl(Uri.parse(request.url));
              return NavigationDecision.navigate;
            } else {
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..loadHtmlString(widget.htmlContent);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.withAppBar){
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title??""),
        ),
        body: WebViewWidget(
          controller: controller,
        ),
      );
    }else{
      return WebViewWidget(controller: controller);
    }

  }
}
