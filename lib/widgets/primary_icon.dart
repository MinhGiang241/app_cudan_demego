// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:badges/src/badge.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/constants.dart';

enum PrimaryIconStyle { none, round, gradient }

enum PrimaryIcons {
  search_outline,
  home_smile,
  home,
  detail,
  chat,
  user_circle,
  bell_outline,
  electricity,
  internet,
  water,
  pet,
  car,
  wrench,
  calendar_check,
  check,
  filter,
  home_alt,
  lock,
  log_out,
  news,
  planet,
  user_circle_outline,
  calendar,
  camera,
  image_add,
  heart_outline,
  heart,
  comment,
  share_outline,
  inbox,
  binoculars,
  box,
  package,
  user_detail,
  error,
  image,
  close,
  add_to_queue,
  bone,
  folder_open,
  follow_service,
  credit_card_alt,
  window_alt,
  menu_round,
  phone_call,
  bell_fill,
  birthday,
  event,
  new_user,
  remind_debt,
  service_feedback,
  system,
  gym,
  extension
}

enum PrimaryIconGradient {
  white,
  primary,
  blue,
  turquoise,
  green,
  pink,
  yellow,
  purple,
  red
}

class PrimaryIcon extends StatelessWidget {
  const PrimaryIcon(
      {super.key,
      this.size,
      required this.icons,
      this.color = primaryColorBase,
      this.style = PrimaryIconStyle.none,
      this.padding,
      this.backgroundColor,
      this.badge,
      this.borderRadius,
      this.gradients = PrimaryIconGradient.white,
      this.onTap});

  final double? size;
  final Color color;
  final PrimaryIcons icons;
  final PrimaryIconStyle style;
  final PrimaryIconGradient gradients;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final String? badge;
  final BorderRadius? borderRadius;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case PrimaryIconStyle.round:
        return Container(
          decoration:
              BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: onTap,
                borderRadius: borderRadius ?? BorderRadius.circular(24),
                child: Padding(
                    padding: padding ?? const EdgeInsets.all(8),
                    child: Badge(
                      badgeContent:
                          Text(badge ?? "", style: txtBold(10, Colors.white)),
                      showBadge: badge != null,
                      child: SvgPicture.asset(
                        _assetName(),
                        width: size ?? 24,
                        height: size ?? 24,
                        color: color,
                      ),
                    ))),
          ),
        );

      case PrimaryIconStyle.none:
        return Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: onTap,
                borderRadius: borderRadius ?? BorderRadius.circular(24),
                child: Badge(
                  badgeContent:
                      Text(badge ?? "", style: txtBold(10, Colors.white)),
                  showBadge: badge != null,
                  child: SvgPicture.asset(
                    _assetName(),
                    width: size ?? 24,
                    height: size ?? 24,
                    color: color,
                  ),
                )));

      default:
        return Container(
          decoration: BoxDecoration(
            color: _gradientWhite(),
            borderRadius: borderRadius ?? BorderRadius.circular(24),
            // gradient: _gradientWhite(),
            border: Border.all(color: Colors.white30, width: 0.5),
            // boxShadow: [
            //   BoxShadow(
            //       blurRadius: 24,
            //       color: _shadowColor(),
            //       offset: const Offset(0, 16))
            // ]
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: borderRadius ?? BorderRadius.circular(24),
              child: Padding(
                padding: padding ?? const EdgeInsets.all(8),
                child: Badge(
                  badgeContent:
                      Text(badge ?? "", style: txtBold(10, Colors.white)),
                  showBadge: badge != null,
                  child: SvgPicture.asset(
                    _assetName(),
                    width: size ?? 24,
                    height: size ?? 24,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }

  String _assetName() {
    return "assets/icons/${icons.name}.svg";
  }

  Color _gradientWhite() {
    switch (gradients) {
      case PrimaryIconGradient.blue:
        return blueColor;
      case PrimaryIconGradient.primary:
        return primaryColorBase;
      case PrimaryIconGradient.green:
        return greenColor;
      case PrimaryIconGradient.pink:
        return pinkColor;
      case PrimaryIconGradient.purple:
        return purpleColor;
      case PrimaryIconGradient.turquoise:
        return turquoiseColor;
      case PrimaryIconGradient.yellow:
        return yellowColor;
      case PrimaryIconGradient.red:
        return redColor;
      default:
        return Colors.white;
    }
  }
}
