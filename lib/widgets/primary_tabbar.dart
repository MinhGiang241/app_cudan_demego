import 'package:flutter/material.dart';

import '../constants/constants.dart';

// ignore: must_be_immutable
class PrimaryTabBar extends StatelessWidget {
  PrimaryTabBar({
    super.key,
    required this.titles,
    this.controller,
    this.isScrollable = false,
    this.onTap,
  });
  final List<String> titles;
  final TabController? controller;
  Function(int)? onTap;
  bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: TabBar(
          onTap: onTap,
          isScrollable: isScrollable,
          labelStyle: txtBodySmallBold(),
          labelColor: grayScaleColorBase,
          controller: controller,
          tabs: titles
              .map(
                (e) => Tab(
                  child: Text(
                    e,
                    style: txtBodySmallBold(),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
