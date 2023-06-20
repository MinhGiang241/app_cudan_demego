import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../constants/constants.dart';
import '../generated/l10n.dart';
import 'primary_card.dart';

class PrimaryTextField extends StatefulWidget {
  PrimaryTextField(
      {super.key,
      this.label,
      this.initialValue,
      this.hint,
      this.controller,
      this.obscureText = false,
      this.isReadOnly = false,
      this.onTap,
      this.keyboardType,
      this.textCapitalization = TextCapitalization.none,
      this.textInputAction,
      this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.enable = true,
      this.isRequired = false,
      this.maxLines = 1,
      this.autoFocus = false,
      this.validateString,
      this.margin,
      this.background,
      this.textColor,
      this.textAlign,
      this.maxLength,
      this.onChanged,
      this.onlyTextNotVietChar = false,
      this.filter = const [],
      this.blockSpace = false,
      this.blockSpecial = false,
      this.onlyText = false,
      this.isShow = true,
      this.onlyNum = false,
      this.unit,
      this.textStyle});
  final TextStyle? textStyle;
  final String? label;
  final String? unit;
  final String? initialValue;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final bool isReadOnly;
  final Function()? onTap;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isRequired;
  final int? maxLines;
  final bool autoFocus;
  final bool enable;
  final bool isShow;
  final bool blockSpace;
  final bool blockSpecial;
  final bool onlyText;
  final bool onlyNum;
  final bool onlyTextNotVietChar;
  final String? validateString;
  final Color? background;
  final Color? textColor;
  final TextAlign? textAlign;
  final int? maxLength;
  final List<TextInputFormatter>? filter;
  Function(String)? onChanged;
  EdgeInsetsGeometry? margin;

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  late StreamController<bool>? showPassController = StreamController<bool>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    showPassController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.label!,
                  style: txtBodySmallRegular(color: grayScaleColorBase),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.isRequired) hpad(4),
              if (widget.isRequired && widget.isShow)
                Text("*", style: txtBodySmallRegular(color: redColorBase))
            ],
          ),
        if (widget.label != null) vpad(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<bool>(
              initialData: false,
              stream: showPassController?.stream,
              builder: (context, snapshot) {
                final showPass = snapshot.data!;

                return Row(
                  children: [
                    Expanded(
                      child: PrimaryCard(
                        onTap: widget.enable ? widget.onTap : null,
                        background: widget.background,
                        margin: widget.margin,
                        child: TextFormField(
                          onChanged: widget.onChanged,
                          onFieldSubmitted: widget.controller != null
                              ? (text) {
                                  widget.controller!.text = text.trim();
                                }
                              : null,
                          maxLength: widget.maxLength,
                          onTap: widget.enable ? widget.onTap : null,
                          textAlign: widget.textAlign ?? TextAlign.start,
                          inputFormatters: <TextInputFormatter>[
                            // FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            if (widget.onlyTextNotVietChar)
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9a-zA-Z]')),
                            if (widget.onlyNum)
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            if (widget.onlyText)
                              FilteringTextInputFormatter.allow(RegExp(
                                  r"[ 0-9a-zA-ZàÀảẢãÃáÁạẠăĂằẰẳẲẵẴắẮặẶâÂầẦẩẨẫẪấẤậẬđĐèÈẻẺẽẼéÉẹẸêÊềỀểỂễỄếẾệỆìÌỉỈĩĨíÍịỊòÒỏỎõÕóÓọỌôÔồỒổỔỗỖốỐộỘơƠờỜởỞỡỠớỚợỢùÙủỦũŨúÚụỤưƯừỪửỬữỮứỨựỰỳỲỷỶỹỸýÝỵỴ]")),
                            if (widget.blockSpace)
                              FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
                            if (widget.blockSpecial)
                              FilteringTextInputFormatter.deny(RegExp(
                                r'''(?=.*[@$!%*#?&)(\-+=\[\]\{\}\.\,<>\'\`~:;\\|/])[A-Za-z\d@$!%_*#?&\[\]\(\)<>`\'+-={}"|\\/]''',
                              )),
                            if (widget.blockSpecial)
                              FilteringTextInputFormatter.deny(
                                  RegExp(r'''["]''')),
                            if (widget.blockSpecial)
                              FilteringTextInputFormatter.deny(
                                  RegExp(r'''[_]''')),
                            ...?widget.filter
                          ],
                          enabled: widget.enable,
                          autofocus: widget.autoFocus,
                          controller: widget.controller,
                          initialValue: widget.initialValue,
                          obscureText: !showPass && widget.obscureText,
                          readOnly: widget.isReadOnly,
                          // onTap: onTap,
                          cursorHeight: 15,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: widget.keyboardType,
                          textCapitalization: widget.textCapitalization,
                          textInputAction: widget.textInputAction ??
                              (widget.maxLines! < 2
                                  ? TextInputAction.done
                                  : null),
                          style: widget.textStyle ??
                              txtBodySmallBold(
                                  color: widget.enable
                                      ? widget.textColor
                                      : grayScaleColor3),
                          cursorColor: primaryColor2,
                          maxLines: widget.maxLines,
                          decoration: InputDecoration(
                              // enabledBorder: widget.validateString != null
                              //     ? OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(12),
                              //         borderSide: const BorderSide(
                              //             color: redColor2, width: 2),
                              //       )
                              //     : OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(12),
                              //         borderSide: BorderSide.none,
                              //       ),

                              counterText: '',
                              hintText: widget.hint,
                              hintStyle:
                                  txtBodySmallBold(color: grayScaleColor3),
                              errorStyle:
                                  const TextStyle(fontSize: 0, height: 0),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              prefixIcon: widget.prefixIcon,
                              suffixIconConstraints: const BoxConstraints(
                                  minHeight: 35, minWidth: 35),
                              suffixIcon: widget.obscureText
                                  ? showPass
                                      ? IconButton(
                                          onPressed: () {
                                            showPassController?.add(false);
                                          },
                                          icon:
                                              const Icon(Icons.visibility_off))
                                      : IconButton(
                                          onPressed: () {
                                            showPassController?.add(true);
                                          },
                                          icon: const Icon(Icons.visibility))
                                  : widget.suffixIcon,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: primaryColor2, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: redColor2, width: 2)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none)),
                          validator: widget.isRequired
                              ? widget.validator
                              : (val) {
                                  return null;
                                },
                        ),
                      ),
                    ),
                    if (widget.unit != null)
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.unit!,
                          style: txtBodySmallBold(color: grayScaleColor3),
                        ),
                      )
                  ],
                );
              },
            ),
            if (widget.validateString != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 4),
                child: Text(
                  widget.validateString!,
                  style: txtRegular(13, redColorBase),
                ),
              )
          ],
        )
      ],
    );
  }
}
