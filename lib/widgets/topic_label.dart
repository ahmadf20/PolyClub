import 'package:flutter/material.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/text_style.dart';

class TopicLabel extends StatelessWidget {
  final String text;
  final bool isSmall;

  const TopicLabel({
    Key? key,
    required this.text,
    this.isSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmall ? 5 : 7.5,
        horizontal: isSmall ? 10 : 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.primary),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: MyTextStyle.topicLabel.copyWith(
          color: MyColors.primary,
          fontSize: isSmall ? 12 : null,
        ),
      ),
    );
  }
}
