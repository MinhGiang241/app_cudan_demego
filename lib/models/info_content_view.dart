import 'package:flutter/material.dart';

import '../constants/constants.dart';

class InfoContentView {
  final String title;
  final String? content;
  final TextStyle contentStyle;
  final List<String>? images;
  final List<String>? dateRange;
  final bool isCheckType;
  final bool isCheck;
  final String? rowKey;

  InfoContentView(
      {required this.title,
      this.rowKey,
      this.content,
      this.images,
      this.isCheckType = false,
      this.isCheck = false,
      this.dateRange,
      this.contentStyle = const TextStyle(
          fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)});
}
