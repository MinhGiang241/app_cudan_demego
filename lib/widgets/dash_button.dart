import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class DashButton extends StatelessWidget {
  const DashButton({
    Key? key,
    required this.text,
    this.icon,
    this.onTap,
    this.lable,
    this.isRequired = false,
    this.isDash = true,
  }) : super(key: key);
  final String text;
  final Widget? icon;
  final Function()? onTap;
  final String? lable;
  final bool isRequired;
  final bool isDash;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lable != null)
          Row(
            children: [
              Text(lable!, style: txtBodySmallRegular()),
              if (isRequired) hpad(4),
              if (isRequired)
                Text("*", style: txtBodySmallRegular(color: redColor1))
            ],
          ),
        if (lable != null) vpad(8),
        if (isDash)
          InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                onTap!();
              },
              borderRadius: BorderRadius.circular(12),
              child: DottedBorder(
                  color: primaryColor3,
                  radius: const Radius.circular(12),
                  borderType: BorderType.RRect,
                  strokeWidth: 1,
                  dashPattern: const [4, 4],
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 32),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (icon != null) icon!,
                            Text(text,
                                style: txtLinkMedium(color: primaryColorBase))
                          ])))),
      ],
    );
  }
}
