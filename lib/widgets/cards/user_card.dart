import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/controllers/profile/profile_controller.dart';
import 'package:poly_club/models/user_model.dart';
import 'package:poly_club/utils/formatter.dart';
import '../../widgets/buttons/my_text_button.dart';
import '../../values/colors.dart';
import '../../values/const.dart';
import '../../values/text_style.dart';
import '../load_image.dart';
import '../modals/modal_bottom_sheet.dart';
import '../modals/user_modal.dart';

class UserCard extends StatelessWidget {
  final User user;
  final Function? onTap;

  UserCard(this.user, {Key? key, this.onTap}) : super(key: key);

  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMyModalBottomSheet(context, ModalBottomSheetUser(user: user));
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Const.defaultBRadius),
              child: loadImage(
                user.avatar,
                height: 50,
                width: 50,
                initials: Formatter.nameAbbr(user.name ?? ''),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name ?? '',
                    style: MyTextStyle.bodySemibold2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${user.username}',
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
            if (user.id != profileController.user.value.id) ...[
              SizedBox(width: 15),
              MyTextButton(
                text: user.isFollowing ? 'Diikuti' : 'Ikuti',
                isFullWidth: false,
                isSmall: true,
                isOutlined: user.isFollowing,
                onPressed: onTap,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
