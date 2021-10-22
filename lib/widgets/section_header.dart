import 'package:flutter/material.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/text_style.dart';

class SectionHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? textButton;
  final Function? onPressed;
  final EdgeInsets? padding;
  final bool showTextButton;

  const SectionHeader({
    Key? key,
    this.title,
    this.textButton,
    this.onPressed,
    this.padding,
    this.showTextButton = true,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: padding?.top ?? 25,
        bottom: padding?.bottom ?? 10,
        left: padding?.left ?? 0,
        right: padding?.right ?? 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title ?? '',
                style: MyTextStyle.bodySemibold1,
              ),
              Spacer(),
              if (showTextButton)
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                  ),
                  child: Row(
                    children: [
                      Text(
                        textButton ?? 'Lihat Semua',
                        style: MyTextStyle.caption.copyWith(
                          color: MyColors.midGrey,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_right_alt_rounded,
                        color: MyColors.primary,
                      ),
                    ],
                  ),
                  onPressed: onPressed as void Function()?,
                ),
            ],
          ),
          if (subtitle != null) ...[
            SizedBox(height: 3.5),
            Text(
              subtitle ?? '',
              style: MyTextStyle.body2.copyWith(
                fontWeight: FontWeight.w500,
                color: MyColors.midGrey,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
