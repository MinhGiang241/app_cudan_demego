import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'primary_button.dart';
import 'primary_icon.dart';

class PrimaryEmptyWidget extends StatelessWidget {
  const PrimaryEmptyWidget({
    Key? key,
    required this.icons,
    required this.emptyText,
    this.buttonText,
    this.action,
  }) : super(key: key);
  final PrimaryIcons icons;
  final String emptyText;
  final String? buttonText;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryIcon(
            icons: icons,
            size: 48,
            padding: const EdgeInsets.all(20),
            style: PrimaryIconStyle.round,
            backgroundColor: primaryColor5,
            color: primaryColor4,
          ),
          vpad(16),
          Text(emptyText, style: txtLinkSmall(color: grayScaleColor2)),
          vpad(16),
          if (buttonText != null)
            PrimaryButton(
              text: buttonText,
              buttonSize: ButtonSize.medium,
              onTap: action,
            )
        ],
      ),
    );
  }
}
