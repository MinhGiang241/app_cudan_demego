import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'primary_icon.dart';

class ItemSelected extends StatelessWidget {
  const ItemSelected({
    Key? key,
    this.onTap,
    required this.text,
    this.isSelected = false,
    this.icon,
  }) : super(key: key);
  final Function()? onTap;
  final String text;
  final bool isSelected;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 62,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (icon != null) icon!,
              if (icon != null) hpad(16),
              Text(text, style: txtLinkSmall(color: grayScaleColor2)),
              const Spacer(),
              //  if (isSelected)
              AnimatedOpacity(
                opacity: isSelected ? 1 : 0,
                duration: const Duration(milliseconds: 250),
                child: AnimatedScale(
                    scale: isSelected ? 1 : 0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutBack,
                    child: const PrimaryIcon(icons: PrimaryIcons.check)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
