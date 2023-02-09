import 'package:flutter/material.dart';
import '../constants/constants.dart';

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    Key? key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.decoration,
    this.background,
    this.onLongPress,
    this.onTapDown,
    this.onTapCancel,
    this.gradient,
    this.constraints,
    this.border,
    this.isShadow = true,
  }) : super(key: key);
  final Widget child;
  final Function()? onTap;
  final Function()? onLongPress;
  final Function(TapDownDetails)? onTapDown;
  final Function()? onTapCancel;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;
  final Decoration? decoration;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? background;
  final Gradient? gradient;
  final bool isShadow;
  final BoxConstraints? constraints;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.topCenter,
      child: Container(
        constraints: constraints,
        margin: margin,
        height: height,
        width: width,
        decoration: decoration ??
            BoxDecoration(
                gradient: gradient,
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                color: background ?? Colors.white.withOpacity(1),
                border: border ?? Border.all(color: Colors.white54, width: 0.5),
                boxShadow: isShadow
                    ? [
                        BoxShadow(
                          blurRadius: 32,
                          color: shadowColor.withOpacity(0.12),
                          offset: const Offset(0, 8),
                        )
                      ]
                    : null),
        child: InkWell(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          onTap: onTap,
          onLongPress: onLongPress,
          onTapDown: onTapDown,
          onTapCancel: onTapCancel,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(0),
            child: Material(
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                color: Colors.transparent,
                child: child),
          ),
        ),
      ),
    );
  }
}
