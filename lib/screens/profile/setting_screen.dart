import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/screens/profile/edit_profile_screen.dart';
import 'package:poly_club/screens/topic/topic_list_screen.dart';
import 'package:poly_club/utils/shared_preferences.dart';
import 'package:poly_club/widgets/page_title.dart';
import '../../values/colors.dart';
import '../../widgets/buttons/my_text_button.dart';
import '../../values/const.dart';
import '../../values/text_style.dart';
import '../../widgets/unfocus_wrapper.dart';
import '../auth_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Padding(
        padding:
            EdgeInsets.all(Const.screenPadding).copyWith(top: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle(title: 'Pengaturan'),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: Const.bottomPadding, top: 10),
                children: [
                  buildListTile(
                    'Ubah Profil',
                    onTap: () {
                      Get.to(() => EditProfileScreen());
                    },
                  ),
                  buildListTile(
                    'Topik Minat',
                    onTap: () {
                      Get.to(() => TopicListScreen());
                    },
                  ),
                  buildListTile(
                    'Notifikasi',
                    onTap: () {},
                  ),
                  buildListTile(
                    'Tentang Pengembang',
                    onTap: () {},
                  ),
                  buildListTile(
                    'Tentang Aplikasi',
                    onTap: () {
                      Get.to(() => _AboutAppPage());
                    },
                  ),
                  buildListTile(
                    'Bantuan',
                    onTap: () {
                      // Get.to(() => _AboutAppPage());
                    },
                  ),
                  SizedBox(height: 50),
                  MyTextButton(
                    text: 'Logout',
                    isOutlined: true,
                    textColor: MyColors.red,
                    onPressed: () async {
                      await SharedPrefs.logOut().then((res) {
                        if (res) Get.offAll(() => AuthScreen());
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(String title, {Function? onTap}) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.5),
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: MyTextStyle.body2.copyWith(
                      fontWeight: FontWeight.w500,
                      color: MyColors.darkGrey,
                    ),
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: MyColors.darkGrey,
                  ),
              ],
            ),
            SizedBox(height: 12.5),
            Divider(color: MyColors.lightGrey),
          ],
        ),
      ),
    );
  }
}

class _AboutAppPage extends StatelessWidget {
  const _AboutAppPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: MyColors.primary,
        colorScheme: ColorScheme.light(
          primary: MyColors.primary,
          onPrimary: MyColors.white,
        ),
      ),
      child: LicensePage(
        applicationIcon: Image.asset(
          'assets/images/launcher_icon.png',
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        applicationName: 'PolyClub',
        applicationLegalese: 'PolyLube 2021',
        applicationVersion: 'v1.0.0', //TODO: get version number  using package
      ),
    );
  }
}
