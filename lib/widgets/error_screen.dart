import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/const.dart';
import 'package:poly_club/values/text_style.dart';

import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String? title, buttonText, subtitle;
  final IconData? icon, iconButton;
  final Widget? child;
  final bool hasButtonIcon;
  final bool hasButton;
  final bool isCard;
  final bool hasIcon;

  final Function()? onPressed;

  const ErrorScreen({
    this.title,
    this.icon,
    this.child,
    this.onPressed,
    this.buttonText,
    this.iconButton,
    this.subtitle,
    this.hasButtonIcon = true,
    this.hasButton = true,
    this.isCard = false,
    this.hasIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: !isCard
          ? null
          : BoxDecoration(
              color: MyColors.lighterGrey,
              border: Border.all(
                color: MyColors.lightGrey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(Const.mediumBRadius),
            ),
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (hasIcon) ...[
              Icon(
                icon ?? Icons.error_outline,
                size: 65,
                color: Colors.grey,
              ),
              SizedBox(height: 15),
            ],
            title == null
                ? Container()
                : Text(
                    title!,
                    style: MyTextStyle.bodySemibold1
                        .copyWith(color: MyColors.darkGrey),
                    textAlign: TextAlign.center,
                  ),
            subtitle == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      subtitle!,
                      style:
                          MyTextStyle.caption.copyWith(color: MyColors.midGrey),
                      textAlign: TextAlign.center,
                    ),
                  ),
            SizedBox(height: 15),
            if (hasButton)
              OutlineButton(
                highlightedBorderColor: MyColors.midGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                borderSide: BorderSide(color: MyColors.midGrey),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    hasButtonIcon
                        ? Icon(
                            iconButton ?? Icons.arrow_back,
                            color: MyColors.midGrey,
                          )
                        : Container(),
                    SizedBox(width: 5),
                    Text(
                      buttonText ?? 'Kembali',
                      style: MyTextStyle.body2.copyWith(
                        color: MyColors.midGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
                onPressed: onPressed ?? () => Navigator.maybePop(context),
              )
          ],
        ),
      ),
    );
  }
}
