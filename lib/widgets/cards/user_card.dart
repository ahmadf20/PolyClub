import 'package:flutter/material.dart';
import '../../widgets/buttons/my_text_button.dart';
import '../../values/colors.dart';
import '../../values/const.dart';
import '../../values/text_style.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Const.defaultBRadius),
            child: Image.asset(
              'assets/images/default-profile-picture.png',
              width: 50,
              height: 50,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: MyTextStyle.bodySemibold1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '@JohnDoe',
                  style: MyTextStyle.caption.copyWith(
                    color: MyColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 15),
          MyTextButton(
            text: 'Mengikuti',
            isFullWidth: false,
            isSmall: true,
            isOutlined: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
