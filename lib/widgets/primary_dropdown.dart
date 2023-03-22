// ignore_for_file: iterable_contains_unrelated_type

import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_dialog.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../constants/constants.dart';
import '../generated/l10n.dart';
import '../models/multi_select_view_model.dart';
import '../utils/utils.dart';
import 'primary_card.dart';

var data = [
  'Lựa chọn 1',
  'Lựa chọn 2',
  'Lựa chọn 3',
  'Lựa chọn 4',
];

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
    this.selectMultileList = const [],
    this.selectedMultileList = const [],
    this.hint,
    this.validateString,
    this.isError = false,
    this.isDense = true,
    this.controller,
    this.enable = true,
    this.isFull = false,
    this.isShow = false,
    this.maxSellect,
    this.onSelectMulti,
  });
  final bool isError;
  final String? label;
  final String? hint;
  final bool isDense;
  final bool isRequired;
  final bool isMultiple;
  final bool isFull;
  final bool isShow;
  final GlobalKey<FormFieldState>? dropKey;
  final String? Function(dynamic)? validator;
  dynamic value;
  bool enable;
  String? validateString;
  Function(dynamic)? onChange;
  final List<DropdownMenuItem>? selectList;
  final List<MultiSelectViewModel>? selectMultileList;
  final List<MultiSelectViewModel>? selectedMultileList;
  final int? maxSellect;
  final Function(List<dynamic>, dynamic)? onSelectMulti;
  TextEditingController? controller = TextEditingController();

  @override
  State<PrimaryDropDown> createState() => _PrimaryDropDownState();
}

class _PrimaryDropDownState extends State<PrimaryDropDown> {
  int indexSelected = 1;
  List<String> selectedList = [];
  MultiSelectController<dynamic>? _controller;

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
        if (widget.isMultiple)
          PrimaryTextField(
            validator: widget.validator,
            isRequired: widget.isRequired,
            isShow: widget.isShow,
            // validateString: widget.validateString,
            isReadOnly: true,
            hint: widget.hint ?? '--${S.of(context).select}--',
            suffixIcon: const Icon(Icons.playlist_add_check),
            onTap: widget.selectMultileList!.isEmpty || !widget.enable
                ? null
                : () async {
                    await Utils.showDialog(
                      context: context,
                      dialog: Dialog(
                        alignment: Alignment.center,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.label != null)
                                Text(
                                  widget.label!,
                                  style: txtDisplayMedium(),
                                  textAlign: TextAlign.center,
                                ),
                              vpad(10),
                              Flexible(
                                child: MultiSelectCheckList(
                                  isMaxSelectableWithPerpetualSelects: true,
                                  maxSelectableCount: widget.maxSellect ??
                                      widget.selectMultileList!.length,
                                  textStyles: const MultiSelectTextStyles(
                                    selectedTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  itemsDecoration: MultiSelectDecorations(
                                    selectedDecoration: BoxDecoration(
                                      color: purpleColor7.withOpacity(0.8),
                                    ),
                                  ),
                                  listViewSettings: ListViewSettings(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                      height: 0,
                                    ),
                                  ),
                                  controller: _controller,
                                  items: List.generate(
                                    widget.selectMultileList!.length,
                                    (index) => CheckListCard(
                                      contentPadding: EdgeInsets.zero,
                                      selected: widget.selectMultileList![index]
                                              .isSelected ??
                                          false,
                                      value: widget
                                          .selectMultileList![index].value,
                                      title: Text(
                                        widget.selectMultileList![index].title!,
                                      ),
                                      subtitle: widget.selectMultileList![index]
                                                  .subTitle !=
                                              null
                                          ? Text(
                                              widget.selectMultileList![index]
                                                  .subTitle!,
                                            )
                                          : null,
                                      selectedColor: Colors.white,
                                      checkColor: primaryColorBase,
                                      checkBoxBorderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  onChange: (allSelectedItems, selectedItem) {
                                    var a =
                                        widget.selectMultileList!.firstWhere(
                                      ((element) =>
                                          element.value == selectedItem),
                                    );
                                    setState(() {
                                      a.isSelected = !a.isSelected!;
                                    });

                                    widget.onSelectMulti!(
                                      allSelectedItems,
                                      selectedItem,
                                    );
                                  },
                                ),
                              ),
                              vpad(10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  hpad(10),
                                  PrimaryButton(
                                    buttonType: ButtonType.secondary,
                                    secondaryBackgroundColor: redColor4,
                                    textColor: redColor1,
                                    buttonSize: ButtonSize.medium,
                                    text: S.of(context).close,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  hpad(20),
                                  PrimaryButton(
                                    buttonSize: ButtonSize.medium,
                                    text: S.of(context).confirm,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  hpad(10),
                                ],
                              ),
                              vpad(20),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
          ),
        if (widget.isMultiple) vpad(5),
        if (widget.isMultiple)
          Wrap(
            children: [
              ...widget.selectMultileList!.map(
                (e) {
                  if (e.isSelected ?? false) {
                    return Chip(
                      label: Text(e.title ?? ""),
                      backgroundColor: greenColor4,
                    );
                  } else {
                    return hpad(0);
                  }
                },
              )
            ],
          ),
        if (!widget.isMultiple)
          PrimaryCard(
            child: Column(
              children: [
                DropdownButtonFormField<dynamic>(
                  key: widget.dropKey,
                  borderRadius: BorderRadius.circular(12),
                  isDense: widget.isDense,
                  validator: widget.isRequired
                      ? ((widget.validator) ??
                          (v) {
                            if (v != null &&
                                widget.controller != null &&
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
                          .map((s) => s.value)
                          .contains(widget.controller!.text)) {
                        return widget.controller!.text;
                      } else {
                        // widget.controller!.clear();
                        return null;
                      }
                    } else {
                      return null;
                    }
                  }(),
                  isExpanded: true,
                  hint: Text(
                    widget.hint ?? "--${S.of(context).select}--",
                    overflow: TextOverflow.ellipsis,
                    style: txtBodySmallBold(color: grayScaleColor3),
                  ),
                  style: txtBodySmallBold(color: grayScaleColorBase),
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontSize: 0, height: 0),
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: txtBodySmallBold(color: grayScaleColor3),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: primaryColor2, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: redColor2, width: 2),
                    ),
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
                errorText: field.hasError ? field.errorText : null,
              ),
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
