// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:app_cudan/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../generated/l10n.dart';
import 'primary_card.dart';

class ChooseMonthYear extends StatefulWidget {
  final Function? onRefresh;
  DateTime? selectedDate;
  final int year;
  final int month;
  final Function selectMonthAndYear;
  String? title;
  List<int>? custom;
  ChooseMonthYear({
    super.key,
    this.onRefresh,
    this.selectedDate,
    this.title,
    this.custom,
    required this.selectMonthAndYear,
    required this.year,
    required this.month,
  });
  @override
  _ChooseMonthYearState createState() => _ChooseMonthYearState();
}

class _ChooseMonthYearState extends State<ChooseMonthYear> {
  // DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // _buildMaterialDatePicker(context);
          DatePicker.showPicker(
            context,
            onChanged: (v) {},
            onConfirm: (v) {
              // setState(() {
              //   widget.selectedDate = v;
              //   // widget!.onLoad!();
              // });

              widget.selectMonthAndYear(v.year, v.month);
            },
            pickerModel: CustomMonthPicker(
              minTime: DateTime(DateTime.now().year - 10, 1, 1),
              maxTime: DateTime(DateTime.now().year + 10, 12, 31),
              currentTime: DateTime(widget.year, widget.month, 1),
              locale: LocaleType.vi,
              custom: widget.custom,
            ),
          );
        },
        child: Column(
          children: [
            if (widget.title != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    widget.title!,
                    style: txtBodySmallBold(color: grayScaleColorBase),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            if (widget.title != null) vpad(12),
            PrimaryCard(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${S.of(context).month}: ${widget.month} - ${widget.year}',
                      style: txtBodySmallBold(color: grayScaleColorBase),
                      textAlign: TextAlign.left,
                    ),
                    const Icon(Icons.expand_more),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomMonthPicker extends DatePickerModel {
  CustomMonthPicker({
    DateTime? currentTime,
    DateTime? minTime,
    DateTime? maxTime,
    LocaleType? locale,
    this.custom,
  }) : super(
          locale: LocaleType.vi,
          minTime: minTime,
          maxTime: maxTime,
          currentTime: currentTime,
        );
  List<int>? custom;

  @override
  List<int> layoutProportions() {
    return custom ?? [1, 1, 0];
  }
}
