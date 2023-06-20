import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../generated/l10n.dart';

class InfoContentView {
  final String title;
  final String? content;
  final TextStyle contentStyle;
  final List<String>? images;
  final List<dynamic>? files;
  final List<String>? dateRange;
  final bool isCheckType;
  final bool isCheck;
  final bool isHorizontal;
  final String? rowKey;
  final Widget? widget;

  InfoContentView(
      {required this.title,
      this.rowKey,
      this.content,
      this.images,
      this.files,
      this.isCheckType = false,
      this.isCheck = false,
      this.isHorizontal = false,
      this.widget,
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
    case "HANDING_OVER":
      return S.current.handing_over;
    case "WAIT_HAND_OVER":
      return S.current.wait_hand_over;
    case "HANDED_OVER":
      return S.current.handed_over;
    case "WAIT_EXECUTE":
      return S.current.wait_execute;
    case "EXECUTED":
      return S.current.executed;
    case "COMPLAIN":
      return S.current.complain;
    case "FEEDBACK":
      return S.current.feedback;
    case "UNPAID":
      return S.current.wait_pay;
    case "APPROVEDFIRST":
      return S.current.wait_approve;
    case "APPROVEDSECOND":
      return S.current.approved;
    default:
      return '';
  }
}

Color genStatusColor(String? status) {
  switch (status) {
    case "NEW":
      return grayScaleColor1;
    case "WAIT":
      return primaryColor1;
    case "CANCEL":
      return redColor9;
    case "APPROVED":
      return greenColor6;
    case "WAIT_OWNER":
      return yellowColor7;
    case "WAIT_TECHNICAL":
      return greenColor9;
    case "WAIT_MANAGER":
      return primaryColorBase;
    case "WAIT_CONSTRUCTION":
      return grayScaleColor1;
    case "UNDER_CONSTRUCTION":
      return primaryColor6;
    case "PAUSE_CONSTRUCTION":
      return redColor9;
    case "WAIT_ACCEPTANCE":
      return yellowColor7;
    case "WAIT_PAY":
      return yellowColor8;
    case "UNDER_ACCEPTANCE":
      return primaryColorBase;
    case "HANDING_OVER":
      return greenColor9;
    case "WAIT_HAND_OVER":
      return yellowColor7;
    case "HANDED_OVER":
      return greenColor8;
    case "WAIT_PROGRESS":
      return yellowColor7;
    case "EXECUTED":
      return greenColor8;
    case "COMPLAIN":
      return redColorBase;
    case "FEEDBACK":
      return yellowColor1;
    case "YES":
      return yellowColor7;
    case "FOUND":
      return yellowColor7;
    case "NOTFOUND":
      return redColor9;
    case "ACCEPT":
      return greenColorBase;
    case "WAIT_RETURN":
      return redColorBase;
    case "RETURNED":
      return primaryColor6;
    case "ACTIVE":
      return primaryColorBase;
    case "INACTIVE":
      return redColorBase;
    case "UNPAID":
      return yellowColor7;
    case "ACTIVED":
      return blueColor3;
    case "INACTIVED":
      return redColor3;
    case "LOST":
      return redColor9;
    case "LOCK":
      return yellowColor7;
    case "DESTROY":
      return yellowColor7;
    case "HANDING":
      return primaryColor6;
    case "DONE":
      return greenColor8;
    case "WAIT_PROCESSING":
      return yellowColor7;
    case "PROCESSING":
      return blueColor3;
    case "PROCESSED":
      return greenColorBase;
    case "COMPLETE":
      return greenColor8;
    case "APPROVEDFIRST":
      return primaryColor1;
    case "APPROVEDSECOND":
      return greenColor6;
    default:
      return grayScaleColor1;
  }
}

Color genStatusColorHandOver(String? status) {
  switch (status) {
    case "WAIT":
      return yellowColor7;
    case "HANDING":
      return primaryColor6;
    case "DONE":
      return greenColor8;
    case "WAIT_PROCESSING":
      return yellowColor7;
    case "PROCESSING":
      return blueColor3;
    case "PROCEED":
      return greenColorBase;
    case "COMPLETE":
      return greenColor8;
    default:
      return grayScaleColor1;
  }
}

genOrder(String status) {
  switch (status) {
    case "NEW":
      return 1;
    case "WAIT":
      return 2;
    case "APPROVED":
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
    // case "ACTIVE":
    //   return txtBold(14, yellowColor);
    // case "INACTIVE":
    //   return txtBold(14, redColor2);
    // case "LOCK":
    //   return txtBold(14, pinkColorBase);
    // case "APPROVED":
    //   return txtBold(14, greenColor6);
    // case "NEW":
    //   return txtBold(14, grayScaleColor1);
    // case "WAIT":
    //   return txtBold(14, primaryColor1);
    // case "CANCEL":
    //   return txtBold(14, redColorBase);
    default:
      return txtBold(14, genStatusColor(content));
  }
}
