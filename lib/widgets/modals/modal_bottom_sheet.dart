import 'package:flutter/material.dart';
import 'package:poly_club/values/const.dart';

Future<dynamic> showMyModalBottomSheet(BuildContext context, Widget widget,
    {bool isScrollControlled = true}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Const.defaultBRadius),
          topRight: Radius.circular(Const.defaultBRadius),
        ),
      ),
      builder: (context) {
        return widget;
      });
}
