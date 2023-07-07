import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../constants/constants.dart';
import 'primary_card.dart';

class PrimaryDropDownSearch extends StatefulWidget {
  const PrimaryDropDownSearch({
    super.key,
    this.label,
    this.initialValue,
    this.getSelectedValue,
    this.future,
    this.hint,
    this.textColor,
    // required this.controller,
    this.textStyle,
    this.enable = true,
    this.isRequired = false,
    this.validateString,
    this.value,
    this.futureRequest,
    this.onChanged,
    this.validator,
    this.paginatedRequest,
    this.isAuto = true,
  });
  final bool isRequired;
  final String? label;
  final String? initialValue;
  final String? hint;
  final bool isAuto;
  // final TextEditingController controller;
  final Function? getSelectedValue;
  final Function? future;
  final TextStyle? textStyle;
  final Color? textColor;
  final bool enable;
  final dynamic value;
  final String? validateString;
  final String? Function(String?)? validator;
  final Future<List<SearchableDropdownMenuItem<String>>?> Function()?
      futureRequest;
  final Future<List<SearchableDropdownMenuItem<String>>?> Function(
      int, String?)? paginatedRequest;
  final void Function(String?)? onChanged;

  @override
  State<PrimaryDropDownSearch> createState() => _PrimaryDropDownSearchState();
}

class _PrimaryDropDownSearchState extends State<PrimaryDropDownSearch> {
  bool isValid = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Row(
            children: [
              Text(
                widget.label!,
                style: txtBodySmallRegular(color: grayScaleColorBase),
                overflow: TextOverflow.ellipsis,
              ),
              if (widget.isRequired) hpad(4),
              if (widget.isRequired)
                Text("*", style: txtBodySmallRegular(color: redColorBase))
            ],
          ),
        if (widget.label != null) vpad(8),
        // SearchableDropdown<int>.future(
        //   hintText: const Text('Future request'),
        //   margin: const EdgeInsets.all(15),
        //   futureRequest: () async {
        //     // final paginatedList = await getAnimeList(page: 1, key: '');
        //     // return paginatedList?.animeList
        //     //     ?.map((e) => SearchableDropdownMenuItem(value: e.malId, label: e.title ?? '', child: Text(e.title ?? '')))
        //     //     .toList();
        //   },
        //   onChanged: (int? value) {
        //     debugPrint('$value');
        //   },
        // )

        SearchableDropdownFormField.paginated(
          requestItemCount: 100,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (v) {
            if (v == null) {
              isValid = false;
            } else {
              isValid = true;
            }
            widget.onChanged!(v);
          },
          isDialogExpanded: true,
          margin: EdgeInsets.zero,
          errorWidget: (text) => text != null
              ? Text(
                  text,
                  style: txtRegular(13, redColorBase),
                )
              : vpad(0),
          backgroundDecoration: (child) => PrimaryCard(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            margin: EdgeInsets.zero,
            child: child,
            border: isValid
                ? Border(
                    top: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                    left: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                    right: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                    bottom: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  )
                : Border(
                    top: BorderSide(
                      color: redColor2,
                      width: 2,
                    ),
                    left: BorderSide(
                      color: redColor2,
                      width: 2,
                    ),
                    right: BorderSide(
                      color: redColor2,
                      width: 2,
                    ),
                    bottom: BorderSide(
                      color: redColor2,
                      width: 2,
                    ),
                  ),
          ),
          initialValue: widget.initialValue,
          validator: (v) {
            isValid = widget.validator!(v) == null;
            return widget.validator!(v);
          },
          paginatedRequest: widget.paginatedRequest,
          searchHintText: widget.hint,
          isEnabled: widget.enable,
          hintText: widget.hint != null
              ? Text(
                  widget.hint!,
                  style: txtBodySmallBold(color: grayScaleColor3),
                )
              : null,
        ),
      ],
    );
  }
}
