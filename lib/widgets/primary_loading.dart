import 'package:flutter/material.dart';

import '../constants/constants.dart';

class PrimaryLoading extends StatelessWidget {
  final double? width;
  final double? height;
  const PrimaryLoading({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: const CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation(primaryColorBase)),
    );
  }
}
