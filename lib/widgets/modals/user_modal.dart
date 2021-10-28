import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/controllers/profile/profile_controller.dart';
import 'package:poly_club/models/user_model.dart';
import 'package:poly_club/screens/people_screen.dart';
import 'package:poly_club/values/enums.dart';
import '../buttons/my_text_button.dart';
import '../../values/colors.dart';
import '../../values/const.dart';
import '../../values/text_style.dart';
import '../load_image.dart';
import '../topic_label.dart';

class ModalBottomSheetUser extends StatelessWidget {
  ModalBottomSheetUser({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User? user;

  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (user == null) return Container();

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, Const.bottomPaddingButton),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 3.5,
              width: 50,
              decoration: BoxDecoration(
                color: MyColors.grey,
                borderRadius: BorderRadius.circular(Const.defaultBRadius),
              ),
            ),
          ),
          SizedBox(height: 25),
          Align(
            alignment: Alignment.topLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: loadImage(
                user?.avatar,
                errorImagePath: 'assets/images/default-profile-picture.png',
                height: 80,
                width: 80,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            user?.name ?? '',
            style: MyTextStyle.bodySemibold1,
          ),
          Text(
            user?.username ?? '',
            style: MyTextStyle.caption.copyWith(
              fontWeight: FontWeight.w500,
              color: MyColors.darkGrey,
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => PeopleScreen(PeopleListType.following, user: user),
                    preventDuplicates: false,
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user?.totalFollowing ?? '0',
                      style: MyTextStyle.bodySemibold1,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Mengikuti',
                      style: MyTextStyle.body2.copyWith(
                        color: MyColors.darkGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => PeopleScreen(PeopleListType.follower, user: user),
                    preventDuplicates: false,
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user?.totalFollower ?? '0',
                      style: MyTextStyle.bodySemibold1,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Pengikut',
                      style: MyTextStyle.body2.copyWith(
                        color: MyColors.darkGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Bio',
            style: MyTextStyle.bodySemibold1,
          ),
          SizedBox(height: 5),
          Text(
            user?.bio ?? '-',
            style: MyTextStyle.body2.copyWith(
              color: MyColors.darkGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15),
          Wrap(
            spacing: 10,
            children: [
              if (user?.topic1 != null)
                TopicLabel(text: user?.topic1?.name ?? ''),
              if (user?.topic2 != null)
                TopicLabel(text: user?.topic2?.name ?? ''),
              if (user?.topic3 != null)
                TopicLabel(text: user?.topic3?.name ?? ''),
            ],
          ),
          if (user?.id != profileController.user.value.id) ...[
            SizedBox(height: 25),
            MyTextButton(
              text: user!.isFollowing! ? 'Diikuti' : 'Ikuti',
              isOutlined: user!.isFollowing ?? false,
              onPressed: () {},
              // TODO: get this done
            ),
          ],
        ],
      ),
    );
  }
}
