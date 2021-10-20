import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData themeData = ThemeData(
  primaryColor: MyColors.primary,
  canvasColor: MyColors.canvas,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Poppins',
  textTheme: TextTheme(
    subtitle1: TextStyle(
      fontFamily: 'NunitoSans',
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: MyColors.midGrey,
    primary: MyColors.primary,
  ),
);

SystemUiOverlayStyle mySystemUIOverlaySyle = SystemUiOverlayStyle(
  systemNavigationBarColor: MyColors.canvas, // navigation bar color
  systemNavigationBarDividerColor: Colors.black26,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  statusBarColor: Colors.transparent, // status bar color
);
