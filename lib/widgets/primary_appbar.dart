import 'dart:ui';

import '../constants/constants.dart';
import 'package:flutter/material.dart';

class PrimaryAppbar extends StatelessWidget with PreferredSizeWidget {
  const PrimaryAppbar({
    Key? key,
    this.title,
    this.actions,
    this.tabController,
    this.tabs,
    this.isTabScrollabel = true,
    this.child,
    this.leading,
    this.height,
  }) : super(key: key);
  final String? title;
  final List<Widget>? actions;
  final TabController? tabController;
  final List<Widget>? tabs;
  final bool isTabScrollabel;
  final Widget? child;
  final Widget? leading;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 32,
            color: const Color(0xff6575A7).withOpacity(0.08),
            offset: const Offset(0, 8))
      ]),
      child: ClipRRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: Colors.white54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: leading,
                      centerTitle: true,
                      title: Text(title ?? ""),
                      actions: actions,
                    ),
                    if ((tabController != null || tabs != null) &&
                        child == null)
                      TabBar(
                        controller: tabController,
                        tabs: tabs!,
                        unselectedLabelColor: grayScaleColor2,
                        unselectedLabelStyle: txtRegular(),
                        labelColor: grayScaleColor1,
                        labelStyle: txtLinkSmall(),
                        indicatorColor: primaryColor1,
                        indicatorWeight: 4,
                        isScrollable: isTabScrollabel,
                      ),
                    if ((tabController == null && tabs == null) &&
                        child != null)
                      Expanded(child: child!)
                  ],
                ),
              ))),
    );
  }

  @override
  Size get preferredSize => Size(
      AppBar().preferredSize.width,
      (tabController != null || tabs != null || child != null)
          ? AppBar().preferredSize.height + (height ?? 50)
          : AppBar().preferredSize.height);
}
