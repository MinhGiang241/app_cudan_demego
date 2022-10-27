import 'package:flutter/material.dart';

import '../constants/constants.dart';

class PrimaryScreen extends StatelessWidget {
  const PrimaryScreen({
    super.key,
    this.appBar,
    this.body,
    this.drawer,
    this.floatingActionButton,
    this.isPadding = true,
    this.bottomNavigationBar,
  });
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool isPadding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: backgroundColor,
          extendBodyBehindAppBar: true,
          drawer: drawer,
          appBar: appBar,
          body: isPadding
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: body,
                )
              : body,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
        ));
  }
}
