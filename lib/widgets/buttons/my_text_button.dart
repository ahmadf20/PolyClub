import 'package:poly_club/values/const.dart';
import 'package:poly_club/values/text_style.dart';

import '../../values/colors.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  @required
  final String? text;
  final Function? onPressed;
  final Color? color;
  final Color? textColor;
  final bool isOutlined;
  final String? iconPath;
  final Color? iconColor;
  final bool isFullWidth;
  final double? width;
  final bool isSmall;

  const MyTextButton({
    Key? key,
    this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.isOutlined = false,
    this.iconPath,
    this.iconColor,
    this.isFullWidth = true,
    this.width,
    this.isSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? width ?? MediaQuery.of(context).size.width : null,
      child: TextButton(
        onPressed: onPressed as void Function()?,
        style: TextButton.styleFrom(
          backgroundColor:
              color ?? (isOutlined ? Colors.transparent : MyColors.primary),
          primary:
              textColor ?? (isOutlined ? MyColors.primary : MyColors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              isSmall ? Const.smallBRadius : Const.mediumBRadius,
            ),
          ),
          side: BorderSide(color: textColor ?? MyColors.primary),
          padding: EdgeInsets.symmetric(
            vertical: isSmall ? 10 : 17.5,
            horizontal: isSmall ? 12.5 : 17.5,
          ),
          minimumSize: Size(0, 35),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconPath != null) ...[
              Image.asset(
                iconPath!,
                color: iconColor ??
                    (isOutlined ? MyColors.primary : MyColors.white),
                width: 24,
                height: 24,
              ),
            ],
            if (iconPath != null && text != null) SizedBox(width: 7.5),
            if (text != null)
              Text(
                text!,
                style: MyTextStyle.body1.copyWith(
                  color: textColor ??
                      (isOutlined ? MyColors.primary : MyColors.white),
                  fontWeight: FontWeight.w600,
                  fontSize: isSmall ? 12 : null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
