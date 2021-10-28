import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/screens/profile/edit_profile_screen.dart';
import 'package:poly_club/screens/settings/about_us_screen.dart';
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
                    Icons.mode_edit_outlined,
                    onTap: () {
                      Get.to(() => EditProfileScreen());
                    },
                  ),
                  buildListTile(
                    'Topik Minat',
                    Icons.topic_outlined,
                    onTap: () {
                      Get.to(() => TopicListScreen());
                    },
                  ),
                  buildListTile(
                    'Notifikasi',
                    Icons.edit_notifications_outlined,
                    onTap: () {},
                  ),
                  buildListTile(
                    'Tentang Pengembang',
                    Icons.design_services_outlined,
                    onTap: () {
                      Get.to(() => AboutUsScreen());
                    },
                  ),
                  buildListTile(
                    'Tentang Aplikasi',
                    Icons.perm_device_information_outlined,
                    onTap: () {
                      Get.to(() => _AboutAppPage());
                    },
                  ),
                  buildListTile(
                    'Bantuan',
                    Icons.help_outline_rounded,
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

  Widget buildListTile(String title, IconData icon, {Function? onTap}) {
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
                Icon(
                  icon,
                  color: MyColors.darkGrey,
                ),
                SizedBox(width: 10),
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
