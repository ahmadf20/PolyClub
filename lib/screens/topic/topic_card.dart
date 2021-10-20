import 'package:flutter/material.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/const.dart';
import 'package:poly_club/values/text_style.dart';
import 'package:poly_club/widgets/buttons/my_icon_button.dart';

class TopicCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function onTap;

  const TopicCard({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? MyColors.primary : MyColors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(Const.mediumBRadius),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyIconButton(
                  iconPath: 'assets/icons/icon-park-outline_topic.png',
                  radius: Const.smallBRadius,
                  color: MyColors.secondary,
                  iconColor: MyColors.primary,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: MyTextStyle.body1.copyWith(
                          fontWeight: FontWeight.w500,
                          color: isSelected ? null : MyColors.darkGrey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  decoration: BoxDecoration(
                    color: isSelected ? MyColors.primary : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? MyColors.primary : MyColors.grey,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.check_outlined,
                    size: 15,
                    color: isSelected ? MyColors.white : MyColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
