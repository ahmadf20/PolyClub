import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/controllers/profile/profile_controller.dart';
import 'package:poly_club/screens/people_screen.dart';
import 'package:poly_club/utils/formatter.dart';
import 'package:poly_club/values/enums.dart';
import 'package:poly_club/widgets/load_image.dart';
import 'package:poly_club/widgets/page_title.dart';
import 'package:share/share.dart';
import 'setting_screen.dart';
import '../../values/colors.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/topic_label.dart';
import '../../values/const.dart';
import '../../values/text_style.dart';
import '../../widgets/unfocus_wrapper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ProfileController>(
      init: ProfileController(),
      builder: (s) {
        return ScreenWrapper(
          appBar: MyAppBar(
            actions: [
              IconButton(
                icon: Icon(
                  Icons.share_outlined,
                  color: MyColors.darkerGrey,
                ),
                onPressed: () {
                  Share.share(
                    'Ayo bergabung dengan cara download aplikasi PolyClub sekarang! https://drive.google.com/drive/folders/1OZ7ThvnBYbFaQLDSQ-AREPpXpbnf2Ki-?usp=sharing',
                    //TODO: change this url
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    color: MyColors.darkerGrey,
                  ),
                  onPressed: () {
                    Get.to(() => SettingScreen());
                  },
                ),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(Const.screenPadding)
                .copyWith(top: 10, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitle(
                  title: 'Profil',
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(bottom: Const.bottomPadding),
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: loadImage(
                            s.user.value.avatar,
                            initials:
                                Formatter.nameAbbr(s.user.value.name ?? ''),
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        s.user.value.name ?? '',
                        style: MyTextStyle.bodySemibold1,
                      ),
                      Text(
                        s.user.value.username ?? '',
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
                                  () => PeopleScreen(PeopleListType.following));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  s.user.value.totalFollowing ?? '0',
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
                                  () => PeopleScreen(PeopleListType.follower));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  s.user.value.totalFollower ?? '0',
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
                        s.user.value.bio ?? '-',
                        style: MyTextStyle.body2.copyWith(
                          color: MyColors.darkGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15),
                      Wrap(
                        spacing: 10,
                        children: [
                          if (s.user.value.topic1 != null)
                            TopicLabel(text: s.user.value.topic1?.name ?? ''),
                          if (s.user.value.topic2 != null)
                            TopicLabel(text: s.user.value.topic2?.name ?? ''),
                          if (s.user.value.topic3 != null)
                            TopicLabel(text: s.user.value.topic3?.name ?? ''),
                        ],
                      ),
                      SizedBox(height: 25),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
