import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class AppTheme {
  static ThemeData lightTheme() => ThemeData.light().copyWith(
      primaryColor: primaryColorBase,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          // Apply this to every platforms you need.
        },
      ),
      scaffoldBackgroundColor: backgroundColor,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: txtBold(16, grayScaleColorBase),
        iconTheme: IconThemeData(color: Colors.grey[850]),
        shadowColor: Colors.black26,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ));
}
