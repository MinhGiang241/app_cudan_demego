import 'dart:io';

import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/api_constant.dart';
import '../constants/constants.dart';
import '../generated/l10n.dart';
import 'dash_button.dart';
import 'package:path/path.dart';
import 'package:open_file_plus/open_file_plus.dart';

class SelectFileWidget extends StatelessWidget {
  const SelectFileWidget({
    super.key,
    this.title,
    this.files = const [],
    this.existFiles = const [],
    this.onSelect,
    this.onRemove,
    this.onRemoveExist,
    this.isDash = true,
    this.isRequired = false,
  });
  final String? title;
  final List existFiles;
  final List<File> files;
  final Function()? onSelect;
  final Function(int)? onRemove;
  final Function(int)? onRemoveExist;
  final bool isRequired;
  final bool isDash;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          DashButton(
            isDash: isDash,
            text: S.of(context).upload,
            lable: title,
            isRequired: isRequired,
            icon: const PrimaryIcon(icons: PrimaryIcons.plus),
            onTap: onSelect,
          ),
        ],
      ),
      if (files.isNotEmpty || existFiles.isNotEmpty)
        Column(
          children: [
            vpad(12),
            ...existFiles.asMap().entries.map(
                  (e) => Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await launchUrl(
                              Uri.parse(
                                  "${ApiConstants.uploadURL}?load=${e.value.id}"),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: Text(
                            e.value.name ?? "",
                            textAlign: TextAlign.left,
                            style: txtMedium(
                              14,
                              primaryColor6,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          onRemoveExist?.call(e.key);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
            ...files.asMap().entries.map(
                  (e) => Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            OpenFile.open(e.value.path);
                          },
                          child: Text(
                            basename(e.value.path),
                            textAlign: TextAlign.left,
                            style: txtMedium(
                              14,
                              primaryColor6,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          onRemove?.call(e.key);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        ),
                      )
                    ],
                  ),
                ),
          ],
        )
    ]);
  }
}
