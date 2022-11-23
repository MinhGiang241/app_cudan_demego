import 'dart:io';

import 'package:flutter/material.dart';

import '../constants/constants.dart';

import '../generated/l10n.dart';
import 'dash_button.dart';
import 'primary_icon.dart';

class SelectMediaWidget extends StatelessWidget {
  const SelectMediaWidget(
      {Key? key,
      this.title,
      this.images = const [],
      this.onSelect,
      this.onRemove,
      this.isDash = true,
      this.isRequired = false})
      : super(key: key);
  final String? title;
  final List<File> images;
  final Function()? onSelect;
  final Function(int)? onRemove;
  final bool isRequired;
  final bool isDash;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            DashButton(
              isDash: isDash,
              text: S.of(context).add_photo,
              lable: title,
              isRequired: isRequired,
              icon: const PrimaryIcon(icons: PrimaryIcons.image_add),
              onTap: onSelect,
            ),
          ],
        ),
        if (images.isNotEmpty)
          Column(
            children: [
              vpad(16),
              SizedBox(
                height: 116,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(images[index])),
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
                              onRemove?.call(index);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }
}
