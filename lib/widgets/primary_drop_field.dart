import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

class PrimaryDropField extends StatelessWidget {
  const PrimaryDropField({super.key, this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: PrimaryTextField(
        label: 'ss',
        onTap: onTap,
      ),
    );
  }
}
