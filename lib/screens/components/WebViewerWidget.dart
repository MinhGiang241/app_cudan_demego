


import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';


class WebViewerWidget extends StatefulWidget {
  final String url;
  final String title;
  final bool withAppBar;
  static const String routeName="/custom-web-view";
  const WebViewerWidget({required this.url, this.title="", this.withAppBar=true});

  @override
  State<WebViewerWidget> createState() => _WebViewerWidgetState();
}

class _WebViewerWidgetState extends State<WebViewerWidget> {
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
            if (request.url.startsWith(widget.url ?? '')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url),
      );
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
      return WebViewWidget(
        controller: controller,
      );
    }

  }
}
