import 'package:flutter/material.dart';

import 'colors.dart';

class MyTextStyle {
  //headlines
  static TextStyle headline1 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 96,
    fontWeight: FontWeight.w500,
    color: MyColors.primary,
    height: 1,
  );
  static TextStyle headline2 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 60,
    fontWeight: FontWeight.w500,
    color: MyColors.primary,
    height: 1,
  );
  static TextStyle headline3 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 48,
    fontWeight: FontWeight.w500,
    color: MyColors.primary,
    height: 1,
  );
  static TextStyle headline4 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 34,
    fontWeight: FontWeight.w500,
    color: MyColors.primary,
    height: 1,
  );
  static TextStyle headline5 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: MyColors.primary,
    height: 1,
  );
  static TextStyle headline6 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: MyColors.primary,
    height: 1,
  );
  static TextStyle headline7 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: MyColors.primary,
    height: 1,
  );

  /// 16px - medium - w500
  static TextStyle subtitle1 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  /// 14px
  static TextStyle subtitle2 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// 16px
  static TextStyle body1 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 16,
  );

  /// 16px - semibold - w600
  static TextStyle bodySemibold1 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  /// 14px
  static TextStyle body2 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 14,
  );

  /// 14px - semibold - w600
  static TextStyle bodySemibold2 = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  /// 10px
  static TextStyle overline = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 10,
  );

  /// 12px
  static TextStyle caption = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 12,
  );

  /// 10px
  static TextStyle topicLabel = const TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle textFieldLabel = body2.copyWith(
    fontWeight: FontWeight.w400,
    color: MyColors.darkerGrey,
  );
}
