import 'package:flutter/material.dart';

import '../constants/constants.dart';

class PrimaryBottomSheet extends StatelessWidget {
  const PrimaryBottomSheet({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
          // border: Border.all(color: Colors.white54, width: 0.5),
        ),
        child: child,
      ),
    );
  }
}
