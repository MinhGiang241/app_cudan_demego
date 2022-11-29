import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../generated/l10n.dart';

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

genStatus(String status) {
  switch (status) {
    case "ACTIVE":
      return S.current.active;
    case "INACTIVE":
      return S.current.lock;
    case "LOCK":
      return S.current.lock;
    case "APPROVED":
      return S.current.approved;
    case "NEW":
      return S.current.l_new;
    case "WAIT":
      return S.current.wait_approve;
    case "CANCEL":
      return S.current.cancel;
    default:
      return '';
  }
}

genStatusColor(String status) {
  switch (status) {
    case "NEW":
      return grayScaleColor1;
    case "WAIT":
      return primaryColor1;
    case "CANCEL":
      return redColorBase;
    case "APPROVED":
      return greenColorBase;
    default:
      return grayScaleColor1;
  }
}

genOrder(String status) {
  switch (status) {
    case "NEW":
      return 1;
    case "APPROVED":
      return 2;
    case "WAIT":
      return 3;
    case "CANCEL":
      return 4;
    case "INACTIVE":
      return 5;
    case "ACTiVE":
      return 6;
    default:
      return 0;
  }
}

genContentStyle(String content) {
  switch (content) {
    case "ACTIVE":
      return txtBold(14, yellowColor);
    case "INACTIVE":
      return txtBold(14, redColor2);
    case "LOCK":
      return txtBold(14, pinkColorBase);
    case "APPROVED":
      return txtBold(14, greenColor);
    case "NEW":
      return txtBold(14, grayScaleColor1);
    case "WAIT":
      return txtBold(14, primaryColor1);
    case "CANCEL":
      return txtBold(14, redColorBase);
    default:
      return txtRegular(14);
  }
}
