import 'dart:io';

import 'package:flutter/material.dart';

import '../constants/api_constant.dart';
import '../constants/constants.dart';

import '../generated/l10n.dart';
import '../models/transportation_card.dart';
import 'dash_button.dart';
import 'primary_icon.dart';
import 'primary_image_netword.dart';

class SelectMediaWidget extends StatelessWidget {
  const SelectMediaWidget(
      {Key? key,
      this.title,
      this.images = const [],
      this.existImages = const [],
      this.onSelect,
      this.onRemove,
      this.onRemoveExist,
      this.isDash = true,
      this.enable = true,
      this.isRequired = false})
      : super(key: key);
  final String? title;
  final List existImages;
  final List<File> images;
  final Function()? onSelect;
  final Function(int)? onRemove;
  final Function(int)? onRemoveExist;
  final bool isRequired;
  final bool isDash;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            DashButton(
              isDash: isDash && enable,
              text: S.of(context).add_photo,
              lable: title,
              isRequired: isRequired,
              icon: const PrimaryIcon(icons: PrimaryIcons.image_add),
              onTap: onSelect,
            ),
          ],
        ),
        if (images.isNotEmpty || existImages.isNotEmpty)
          Column(
            children: [
              vpad(16),
              SizedBox(
                  height: 116,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    ...existImages.asMap().entries.map(
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
                                  if (enable)
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
                                          onRemoveExist?.call(e.key);
                                        },
                                      ),
                                    )
                                ],
                              )),
                        ),
                    ...images.asMap().entries.map(
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
                                  if (!enable)
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
            ],
          )
      ],
    );
  }
}
