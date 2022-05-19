import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class MyTheme {
  static ThemeData themeData = ThemeData(
    primaryColor: MyColors.primary,
    canvasColor: MyColors.canvas,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'GeneralSans',
    textTheme: TextTheme(
      subtitle1: TextStyle(
        fontFamily: 'GeneralSans',
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: MyColors.midGrey,
      primary: MyColors.primary,
    ),
  );

  static SystemUiOverlayStyle mySystemUIOverlaySyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    systemNavigationBarDividerColor: MyColors.canvas,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent, // status bar
  );
}
