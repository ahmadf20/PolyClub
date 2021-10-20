import 'package:flutter/material.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/const.dart';

class MyIconButton extends StatelessWidget {
  @required
  final String iconPath;
  final Function? onPressed;
  final Color? color;
  final Color? iconColor;
  final Color? outlineColor;
  final bool isOutlined;
  final double? radius;
  final bool isSmall;

  const MyIconButton({
    Key? key,
    this.onPressed,
    required this.iconPath,
    this.color,
    this.iconColor,
    this.isOutlined = false,
    this.outlineColor,
    this.radius,
    this.isSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed as void Function()?,
      style: TextButton.styleFrom(
        backgroundColor:
            color ?? (isOutlined ? Colors.transparent : MyColors.primary),
        primary: MyColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? Const.defaultBRadius),
        ),
        side: BorderSide(
          color: outlineColor ??
              color ??
              (isOutlined ? Colors.transparent : MyColors.primary),
        ),
        minimumSize: isSmall ? Size(35, 35) : Size(45, 45),
      ),
      child: Image.asset(
        iconPath,
        height: 20,
        width: 20,
        color: iconColor ?? (isOutlined ? MyColors.primary : MyColors.white),
      ),
    );
  }
}
