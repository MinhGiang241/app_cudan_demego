import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_text_field.dart';
import '../../../../widgets/select_media_widget.dart';

class ReasonDailog extends StatefulWidget {
  const ReasonDailog({super.key, this.function});
  final function;

  @override
  State<ReasonDailog> createState() => _ReasonDailogState();
}

class _ReasonDailogState extends State<ReasonDailog> {
  List<File> imageResons = [];
  onRemoveFile(
    int index,
  ) {
    setState(() {
      imageResons.removeAt(index);
    });
  }

  onSelectFrontPhoto(
    BuildContext context,
  ) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        setState(() {
          imageResons.addAll(list);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      PrimaryTextField(
        maxLines: 2,
        label: S.of(context).not_pass_reason,
        isRequired: true,
      ),
      vpad(12),
      SelectMediaWidget(
        onSelect: () {
          onSelectFrontPhoto(context);
        },
        onRemove: onRemoveFile,
        images: imageResons,
        title: S.of(context).photos,
      ),
      vpad(16),
      PrimaryButton(
        text: S.of(context).save,
        onTap: () {
          widget.function();
          Navigator.pop(context);
        },
      )
    ]);
  }
}
