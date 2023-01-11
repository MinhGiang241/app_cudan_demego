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

import 'primary_image_netword.dart';

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
    this.text,
    this.icon,
    this.isRequired = false,
  });
  final String? title;
  final String? text;
  final Widget? icon;
  final List existFiles;
  final List<File> files;
  final Function()? onSelect;
  final Function(int)? onRemove;
  final Function(int)? onRemoveExist;
  final bool isRequired;
  final bool isDash;

  @override
  Widget build(BuildContext context) {
    var listImage = [
      'jpg',
      'jpeg',
      'png',
    ];
    List imageExist = [];
    List fileExist = [];
    List<File> imageList = [];
    List<File> filesList = [];
    for (var a in existFiles) {
      if (listImage.contains(a.name.split('.').last)) {
        imageExist.add(a);
      } else {
        fileExist.add(a);
      }
    }
    for (var i in files) {
      if (listImage.contains(i.path.split('.').last)) {
        imageList.add(i);
      } else {
        filesList.add(i);
      }
    }
    return Column(children: [
      Row(
        children: [
          DashButton(
            isDash: isDash,
            text: text ?? S.of(context).upload,
            lable: title,
            isRequired: isRequired,
            icon: icon ?? const PrimaryIcon(icons: PrimaryIcons.plus),
            onTap: onSelect,
          ),
        ],
      ),
      Column(
        children: [
          if (imageExist.isNotEmpty || imageList.isNotEmpty) vpad(12),
          if (imageExist.isNotEmpty || imageList.isNotEmpty)
            SizedBox(
                height: 116,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  ...imageExist.asMap().entries.map(
                        (e) => Padding(
                            padding: const EdgeInsets.only(right: 14.0),
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: PrimaryImageNetwork(
                                      canShowPhotoView: true,
                                      path:
                                          '${ApiConstants.uploadURL}/?load=${e.value.id!}',
                                    )),
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: PrimaryIcon(
                                    icons: PrimaryIcons.close,
                                    style: PrimaryIconStyle.gradient,
                                    gradients: PrimaryIconGradient.red,
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(4),
                                    onTap: () {
                                      var index = existFiles.indexWhere(
                                          (element) =>
                                              element.id == e.value.id);
                                      onRemoveExist?.call(index);
                                    },
                                  ),
                                )
                              ],
                            )),
                      ),
                  ...imageList.asMap().entries.map(
                        (e) => Padding(
                            padding: const EdgeInsets.only(right: 14.0),
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: PrimaryImageNetwork(
                                      file: e.value,
                                    )

                                    //  Image.file(e.value),
                                    ),
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: PrimaryIcon(
                                    icons: PrimaryIcons.close,
                                    style: PrimaryIconStyle.gradient,
                                    gradients: PrimaryIconGradient.red,
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(4),
                                    onTap: () {
                                      onRemove?.call(e.key);
                                    },
                                  ),
                                )
                              ],
                            )),
                      )
                ])),
          vpad(12),
          ...existFiles.asMap().entries.map(
            (e) {
              if (listImage.contains(e.value.name.split('.').last)) {
                return vpad(0);
              }
              return Row(
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
                      var index = existFiles
                          .indexWhere((element) => element.id == e.value.id);
                      onRemoveExist?.call(index);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                ],
              );
            },
          ),
          ...filesList.asMap().entries.map(
            (e) {
              if (listImage.contains(e.value.path.split('.').last)) {
                return vpad(0);
              }
              return Row(
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
              );
            },
          ),
        ],
      )
    ]);
  }
}
