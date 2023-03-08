// ignore_for_file: iterable_contains_unrelated_type

import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../constants/constants.dart';
import '../generated/l10n.dart';
import 'primary_card.dart';

var data = [
  'Lựa chọn 1',
  'Lựa chọn 2',
  'Lựa chọn 3',
  'Lựa chọn 4',
];

var text = ['1', '2', '3', '4'];

var items = data.asMap().entries.map((v) {
  return DropdownMenuItem(
    value: v.key,
    child: Text(v.value),
  );
}).toList();

class PrimaryDropDown extends StatefulWidget {
  PrimaryDropDown({
    super.key,
    this.dropKey,
    this.label,
    this.isRequired = false,
    this.value,
    this.onChange,
    this.selectList,
    this.isMultiple = false,
    this.validator,
    this.selectMultileList,
    this.hint,
    this.validateString,
    this.isError = false,
    this.isDense = true,
    this.controller,
    this.enable = true,
    this.isFull = false,
  });
  final bool isError;
  final String? label;
  final String? hint;
  final bool isDense;
  final bool isRequired;
  final bool isMultiple;
  final bool isFull;
  final GlobalKey<FormFieldState>? dropKey;
  final String? Function(dynamic)? validator;
  dynamic value;
  bool enable;
  String? validateString;
  Function(dynamic)? onChange;
  final List<DropdownMenuItem>? selectList;
  final List<String>? selectMultileList;
  TextEditingController? controller = TextEditingController();

  @override
  State<PrimaryDropDown> createState() => _PrimaryDropDownState();
}

class _PrimaryDropDownState extends State<PrimaryDropDown> {
  int indexSelected = 1;
  List<String> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (widget.label != null)
              Text(
                widget.label!,
                style: txtBodySmallRegular(color: grayScaleColorBase),
              ),
            if (widget.isRequired) hpad(4),
            if (widget.isRequired)
              Text("*", style: txtBodySmallRegular(color: redColorBase))
          ],
        ),
        if (widget.label != null) vpad(8),
        widget.isMultiple
            ? MultiSelectDialogField(
                validator: widget.validator,
                title: Text(S.of(context).select),
                selectedColor: secondaryColorBase,
                buttonText: Text(
                  widget.hint ?? "--${S.of(context).select}--",
                  overflow: TextOverflow.ellipsis,
                ),
                buttonIcon: const Icon(Icons.arrow_drop_down),
                searchHint: '--${S.of(context).select}--',
                searchHintStyle: txtBodySmallBold(color: grayScaleColor3),
                onConfirm: (v) {
                  selectedList = v;
                },
                items: widget.selectMultileList != null
                    ? widget.selectMultileList!
                        .map((e) => MultiSelectItem(e, e))
                        .toList()
                    : data.map((e) => MultiSelectItem(e, e)).toList(),
                decoration: BoxDecoration(
                  // border: Border.all(color: BorderSide.none),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              )
            : PrimaryCard(
                child: Column(
                  children: [
                    DropdownButtonFormField<dynamic>(
                      key: widget.dropKey,
                      borderRadius: BorderRadius.circular(12),
                      isDense: widget.isDense,
                      // menuMaxHeight: widget.isFull
                      //     ? double.infinity
                      //     : dvHeight(context) / 3,
                      validator: widget.isRequired
                          ? ((widget.validator) ??
                              (v) {
                                if (v != null &&
                                    widget.selectList!.isNotEmpty) {
                                  widget.controller!.text = v;
                                  return null;
                                }

                                return '';
                              })
                          : null,
                      dropdownColor: Colors.white,
                      value: () {
                        if (widget.value != null) {
                          return widget.value;
                        } else if (widget.controller != null &&
                            widget.controller!.text.isEmpty) {
                          return null;
                        } else if (widget.controller != null &&
                            widget.controller!.text.isNotEmpty) {
                          if (widget.selectList!
                              .contains(widget.controller!.text)) {
                            return widget.controller!.text;
                          } else {
                            widget.controller!.clear();
                            return null;
                          }
                        } else {
                          return null;
                        }
                      }(),
                      //  widget.value ??
                      //     (widget.controller != null
                      //         ? widget.controller!.text.isEmpty
                      //             ? null
                      //             : widget.selectList!.isNotEmpty
                      //                 ? widget.controller!.text
                      //                 : null
                      //         : null),
                      // ??
                      //     (widget.selectList!.isNotEmpty
                      //         ? widget.selectList![0].value
                      //         : null),
                      isExpanded: true,
                      // value: items[indexSelected],
                      // dropdownColor: Colors.black,
                      hint: Text(
                        "--${S.of(context).select}--",
                        overflow: TextOverflow.ellipsis,
                        style: txtBodySmallBold(color: grayScaleColor3),
                      ),
                      style: txtBodySmallBold(color: grayScaleColorBase),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(fontSize: 0, height: 0),
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
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: txtBodySmallBold(color: grayScaleColor3),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: primaryColor2, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: redColor2, width: 2)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: widget.enable
                          ? (widget.onChange) ??
                              (v) {
                                if (widget.controller != null) {
                                  widget.controller!.text = v;
                                }
                                if (widget.value != null) {
                                  widget.value = v.toString();
                                }
                              }
                          : null,
                      items: widget.selectList ?? items,
                    ),
                  ],
                ),
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
    );
  }
}

class DropdownFormField<T> extends FormField<T> {
  DropdownFormField({
    Key? key,
    required InputDecoration decoration,
    required T initialValue,
    required List<DropdownMenuItem<T>> items,
    bool autovalidate = false,
    FormFieldSetter<T>? onSaved,
    FormFieldValidator<T>? validator,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          // autovalidate: autovalidate,
          initialValue: items.contains(initialValue) ? initialValue : null,
          builder: (FormFieldState<T> field) {
            final InputDecoration effectiveDecoration = (decoration)
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                  errorText: field.hasError ? field.errorText : null),
              isEmpty: field.value == '' || field.value == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: field.value,
                  isDense: true,
                  onChanged: field.didChange,
                  items: items.toList(),
                ),
              ),
            );
          },
        );
}
