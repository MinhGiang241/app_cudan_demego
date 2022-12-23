import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../generated/l10n.dart';

class DropDownTextFiled extends StatelessWidget {
  DropDownTextFiled({
    super.key,
    this.isRequired = false,
    this.enable = true,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.initialValue,
    this.onChanged,
    this.validateString,
    this.controller,
    this.onTap,
    this.validator,
  });
  final bool isRequired;
  final String? validateString;
  Function(String)? onChanged;
  final bool enable;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final String? initialValue;
  final bool isReadOnly = true;
  final String hint = '--${S.current.select}--';
  final TextEditingController? controller;
  final Function()? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    return PopupMenuButton(
      onSelected: (v) {
        print('sss');
      },
      itemBuilder: (v) => [
        PopupMenuItem(
          child: Container(
            width: dvWidth(context),
            child: const Text('Dogec'),
          ),
          value: 1,
        )
      ],
      child: PrimaryTextField(
        isRequired: isRequired,
        validateString: validateString,
        onChanged: onChanged,
        enable: enable,
        prefixIcon: prefixIcon,
        suffixIcon: const Icon(Icons.expand_more),
        label: label,
        initialValue: initialValue,
        isReadOnly: true,
        controller: controller,
        validator: validator,
        onTap: null,
      ),
    );
  }
}
