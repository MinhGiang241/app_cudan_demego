import 'package:app_cudan/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../generated/l10n.dart';

customFooter() {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = Text(
          S.current.pull_to_load,
          style: txtRegular(14, grayScaleColor3),
        );
      } else if (mode == LoadStatus.loading) {
        body = const CircularProgressIndicator();
      } else if (mode == LoadStatus.failed) {
        body = Text(
          S.current.pull_load_failed,
          style: txtRegular(14, grayScaleColor3),
        );
      } else if (mode == LoadStatus.canLoading) {
        body = Text(
          S.current.release_to_load,
          style: txtRegular(14, grayScaleColor3),
        );
      } else {
        body = Text(
          S.current.no_more_data,
          style: txtRegular(14, grayScaleColor3),
        );
      }
      return SizedBox(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}
