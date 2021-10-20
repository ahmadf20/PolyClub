import 'package:flutter/material.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/text_style.dart';

class PageTitle extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const PageTitle({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: MyTextStyle.headline5.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        if (subtitle != null) ...[
          SizedBox(height: 5),
          Text(
            subtitle!,
            style: MyTextStyle.body2.copyWith(
              fontWeight: FontWeight.w400,
              color: MyColors.darkGrey,
            ),
          ),
        ],
        SizedBox(height: 20),
      ],
    );
  }
}
