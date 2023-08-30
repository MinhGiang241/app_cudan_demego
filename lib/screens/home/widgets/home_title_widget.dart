import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';

class HomeTitleWidget extends StatelessWidget {
  const HomeTitleWidget({
    Key? key,
    required this.title,
    this.child,
    this.isAll = true,
    this.onTapShowAll,
  }) : super(key: key);

  final String title;
  final Widget? child;
  final bool isAll;
  final Function()? onTapShowAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(title, style: txtLinkSmall(color: grayScaleColor2)),
            const Spacer(),
            if (isAll)
              InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: onTapShowAll,
                child: Text(
                  S.of(context).all,
                  style: txtLinkSmall(color: grayScaleColor2)
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
          ],
        ),
        vpad(16),
        if (child != null) child!,
      ],
    );
  }
}
