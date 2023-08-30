import 'package:flutter/material.dart';

import '../constants/constants.dart';

class PrimaryCheckBox extends StatelessWidget {
  const PrimaryCheckBox({
    Key? key,
    required this.value,
    this.onChanged,
    required this.text,
  }) : super(key: key);
  final bool value;
  final Function(bool?)? onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            side: const BorderSide(color: secondaryColor3, width: 2),
            onChanged: onChanged,
            activeColor: secondaryColor2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
        hpad(8),
        Text(text, style: txtLinkXSmall()),
      ],
    );
  }
}
