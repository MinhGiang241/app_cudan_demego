import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/constants.dart';

enum ButtonType {
  primary,
  secondary,
  white,
  black,
  yellow,
  red,
  green,
  cyan,
  orange
}

enum ButtonSize { large, medium, small, xsmall }

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.text,
    this.onTap,
    this.margin,
    this.secondaryBackgroundColor,
    this.textColor,
    this.buttonType,
    this.buttonSize,
    this.width,
    this.icon,
    this.isRectangle = false,
    this.isFit = false,
    this.isLoading = false,
  });

  final String? text;
  final Function()? onTap;
  final EdgeInsets? margin;
  final Color? secondaryBackgroundColor;
  final Color? textColor;
  final ButtonType? buttonType;
  final ButtonSize? buttonSize;
  final double? width;
  final Widget? icon;
  final bool isRectangle;
  final bool isFit;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: _backgroundColor(buttonType ?? ButtonType.primary),
        gradient: _gradientColor(buttonType ?? ButtonType.primary),
        borderRadius: isRectangle ? null : BorderRadius.circular(28),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: isRectangle ? null : BorderRadius.circular(28),
          onTap: isLoading ? () {} : onTap,
          child: Padding(
            padding: _paddingContent(buttonSize ?? ButtonSize.large),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) icon!,
                if (icon != null && text != null) hpad(8),
                if (text != null)
                  Flexible(
                    child: isFit
                        ? FittedBox(
                            fit: BoxFit.contain,
                            child: isLoading
                                ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: textColor ?? Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  )
                                : AutoSizeText(
                                    text ?? "",
                                    style: _txtStyle(
                                      buttonSize ?? ButtonSize.large,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            //  Text(
                            //     text ?? "",
                            //     softWrap: true,
                            //     style: _txtStyle(
                            //       buttonSize ?? ButtonSize.large,
                            //     ),
                            //     textAlign: TextAlign.center,
                            //   ),
                          )
                        : isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: textColor ?? Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : AutoSizeText(
                                text ?? "",
                                style: _txtStyle(
                                  buttonSize ?? ButtonSize.large,
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _txtStyle(ButtonSize size) {
    switch (size) {
      case ButtonSize.large:
        return txtLinkMedium(color: textColor ?? Colors.white);
      case ButtonSize.medium:
        return txtLinkMedium(color: textColor ?? Colors.white);
      case ButtonSize.small:
        return txtLinkSmall(color: textColor ?? Colors.white);
      case ButtonSize.xsmall:
        return txtSemiBold(13, textColor ?? Colors.white);
      default:
        return txtLinkMedium(color: textColor ?? Colors.white);
    }
  }

  EdgeInsets _paddingContent(ButtonSize size) {
    switch (size) {
      case ButtonSize.large:
        return const EdgeInsets.symmetric(vertical: 16, horizontal: 26);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(vertical: 12, horizontal: 24);
      case ButtonSize.small:
        return const EdgeInsets.symmetric(vertical: 10, horizontal: 16);
      case ButtonSize.xsmall:
        return const EdgeInsets.symmetric(vertical: 6, horizontal: 12);
      default:
        return const EdgeInsets.symmetric(vertical: 16, horizontal: 32);
    }
  }

  Color? _backgroundColor(ButtonType type) {
    if (type != ButtonType.secondary) {
      return null;
    } else {
      return secondaryBackgroundColor ?? primaryColor5;
    }
  }

  LinearGradient? _gradientColor(ButtonType type) {
    switch (type) {
      case ButtonType.primary:
        return gradientPrimary;
      case ButtonType.secondary:
        return null;
      case ButtonType.white:
        return gradientPrimaryWhite;
      case ButtonType.black:
        return gradientPrimaryBlack;
      case ButtonType.yellow:
        return gradientPrimaryYellow;
      case ButtonType.red:
        return gradientPrimaryRed;
      case ButtonType.green:
        return gradientPrimaryGreen;
      case ButtonType.cyan:
        return gradientPrimaryCyan;
      case ButtonType.orange:
        return gradientPrimaryOrange;
      default:
        return gradientPrimary;
    }
  }
}
