import '../values/colors.dart';
import 'package:flutter/material.dart';

class MyLoadingIndicator {
  static Widget circular({Color? color, EdgeInsetsGeometry? margin}) {
    return Container(
      alignment: Alignment.center,
      margin: margin,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? MyColors.primary,
        ),
      ),
    );
  }
}
