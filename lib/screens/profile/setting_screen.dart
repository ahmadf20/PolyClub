import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/screens/profile/edit_profile_screen.dart';
import 'package:poly_club/screens/settings/about_us_screen.dart';
import 'package:poly_club/screens/settings/help_screen.dart';
import 'package:poly_club/screens/settings/web_view.dart';
import 'package:poly_club/screens/topic/topic_list_screen.dart';
import 'package:poly_club/screens/welcome_screen.dart';
import 'package:poly_club/services/one_signal_service.dart';
import 'package:poly_club/utils/shared_preferences.dart';
import 'package:poly_club/widgets/page_title.dart';
import 'package:poly_club/widgets/section_header.dart';
import '../../values/colors.dart';
import '../../widgets/buttons/my_text_button.dart';
import '../../values/const.dart';
import '../../values/text_style.dart';
import '../../widgets/unfocus_wrapper.dart';

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
                  SectionHeader(
                    title: 'Akun',
                    showTextButton: false,
                    isFirst: true,
                  ),
                  _ListTile(
                      title: 'Ubah Profil',
                      icon: Icons.mode_edit_outlined,
                      onTap: () {
                        Get.to(() => EditProfileScreen());
                      }),
                  _ListTile(
                      title: 'Topik Minat',
                      icon: Icons.topic_outlined,
                      onTap: () {
                        Get.to(() => TopicListScreen());
                      }),
                  _ListTile(
                      title: 'Notifikasi',
                      icon: Icons.edit_notifications_outlined,
                      onTap: () {
                        AppSettings.openNotificationSettings();
                      }),
                  SectionHeader(
                    title: 'Bantuan',
                    showTextButton: false,
                  ),
                  _ListTile(
                      title: 'Bantuan',
                      icon: Icons.help_outline_rounded,
                      onTap: () {
                        Get.to(() => HelpScreen());
                      }),
                  SectionHeader(
                    title: 'Tentang',
                    showTextButton: false,
                  ),
                  _ListTile(
                      title: 'Tentang Pengembang',
                      icon: Icons.design_services_outlined,
                      onTap: () {
                        Get.to(() => AboutUsScreen());
                      }),
                  _ListTile(
                      title: 'Tentang Aplikasi',
                      icon: Icons.perm_device_information_outlined,
                      onTap: () {
                        Get.to(() => _AboutAppPage());
                      }),
                  _ListTile(
                      title: 'Kebijakan Privasi',
                      icon: Icons.privacy_tip_outlined,
                      onTap: () {
                        Get.to(() => WebViewScreen(
                            data: Const.privacyPolicyUrl,
                            title: 'Kebijakan Privasi'));
                      }),
                  _ListTile(
                      title: 'Syarat dan Ketentuan',
                      icon: Icons.list_alt_rounded,
                      onTap: () {
                        Get.to(() => WebViewScreen(
                            data: Const.termsOfUseUrl,
                            title: 'Syarat dan Ketentuan'));
                      }),
                  SizedBox(height: 50),
                  MyTextButton(
                    text: 'Logout',
                    isOutlined: true,
                    textColor: MyColors.red,
                    onPressed: () async {
                      await SharedPrefs.logOut().then((res) {
                        OneSignalService.unsetUserId();
                        if (res) Get.offAll(() => WelcomeScreen());
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
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
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
