import 'package:flutter/material.dart';
import 'package:poly_club/models/topic_model.dart';
import 'package:poly_club/models/user_model.dart';
import 'package:poly_club/utils/formatter.dart';
import 'package:poly_club/utils/url_launcher_config.dart';
import 'package:poly_club/widgets/buttons/my_text_button.dart';
import 'package:poly_club/widgets/load_image.dart';
import 'package:poly_club/widgets/modals/modal_bottom_sheet.dart';
import 'package:poly_club/widgets/page_title.dart';
import 'package:poly_club/widgets/section_header.dart';
import 'package:poly_club/widgets/topic_label.dart';
import '../../values/colors.dart';
import '../../values/const.dart';
import '../../values/text_style.dart';
import '../../widgets/unfocus_wrapper.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({Key? key}) : super(key: key);

  final List<User> devs = [
    User(
      name: 'Mohammad Dhikri',
      email: 'Mohammaddhikri@gmail.com',
      bio: 'Bandung, Jawa Barat',
      topic1: Topic(name: 'Project Manager'),
      topic2: Topic(name: 'Scrum Master'),
      username: 'Mohammaddhikri@gmail.com',
      avatar: 'https://api.himatif.org/data/assets/foto/2018/75.jpg',
      isFollowing: false,
    ),
    User(
      name: 'Ahmad Faaiz Al-auza\'i',
      email: 'ahmad18002@mail.unpad.ac.id',
      bio: 'Cimahi Utara, Jawa Barat',
      topic1: Topic(name: 'UI/UX'),
      topic2: Topic(name: 'Frontend Mobile Developer'),
      username: 'ahmad18002@mail.unpad.ac.id',
      avatar: 'https://api.himatif.org/data/assets/foto/2018/23.jpg',
      isFollowing: false,
    ),
    User(
      name: 'Asep Budiyana Muharram',
      email: 'asepbudiyana9a@gmail.com',
      bio: 'Garut, Jawa Barat',
      topic1: Topic(name: 'Devops'),
      topic2: Topic(name: 'Backend Developer'),
      username: 'asepbudiyana9a@gmail.com',
      avatar: 'https://api.himatif.org/data/assets/foto/2018/29.jpg',
      isFollowing: false,
    ),
  ];

  final List<User> supervisors = [
    User(
      name: 'Mira Suryani, S.Pd., M.Kom',
      email: 'mira.suryani@unpad.ac.id',
      bio: '',
      topic1: Topic(name: 'Pembimbing'),
      username: 'mira.suryani@unpad.ac.id',
      avatar:
          'https://informatika.unpad.ac.id/new/wp-content/uploads/2017/04/Bu-Mira.jpg',
      isFollowing: false,
    ),
    User(
      name: 'Aditya Pradana, S.T., M.Eng',
      email: 'aditya.pradana@unpad.ac.id',
      bio: '',
      topic1: Topic(name: 'Pembimbing'),
      username: 'aditya.pradana@unpad.ac.id',
      avatar:
          'https://informatika.unpad.ac.id/new/wp-content/uploads/2017/04/Pa-Adit.jpg',
      isFollowing: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Padding(
        padding:
            EdgeInsets.all(Const.screenPadding).copyWith(top: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle(title: 'Pengembang', subtitle: 'PolyLube Team'),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: Const.bottomPadding),
                children: [
                  SectionHeader(
                    title: 'Tim Inti',
                    showTextButton: false,
                    isFirst: true,
                  ),
                  for (final user in devs)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: _UserCard(user),
                    ),
                  SectionHeader(
                    title: 'Pembimbing',
                    showTextButton: false,
                  ),
                  for (final user in supervisors)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: _UserCard(user),
                    ),
                  SizedBox(height: 15),
                  Divider(),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loadImage(
                        'https://upload.wikimedia.org/wikipedia/id/thumb/8/80/Lambang_Universitas_Padjadjaran.svg/1200px-Lambang_Universitas_Padjadjaran.svg.png',
                        height: 45,
                        width: 45,
                      ),
                      SizedBox(width: 10),
                      loadImage(
                        'https://studn.id/assets/images/community/logo/HIMATIFHimpunanMahasiswaTeknikInformatikaUNPAD_464dd19b0d18da7097bdd2c570d20e41.png',
                        height: 45,
                        width: 45,
                      ),
                    ],
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

class _UserCard extends StatelessWidget {
  final User user;
  final Function? onTap;

  const _UserCard(this.user, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SizedBox(width: 15),
          MyTextButton(
            text: 'Detil',
            isFullWidth: false,
            isSmall: true,
            isOutlined: user.isFollowing,
            onPressed: () {
              showMyModalBottomSheet(
                  context, _ModalBottomSheetUser(user: user));
            },
          ),
        ],
      ),
    );
  }
}

class _ModalBottomSheetUser extends StatelessWidget {
  _ModalBottomSheetUser({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User? user;

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
                height: 80,
                width: 80,
                initials: Formatter.nameAbbr(user?.name ?? ''),
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
          if (user?.bio != null && user!.bio!.isNotEmpty) ...[
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
          ],
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
          SizedBox(height: 25),
          MyTextButton(
            text: 'Kirim Email',
            isOutlined: user!.isFollowing,
            onPressed: () {
              UrlLauncherConfig.open('mailto:${user?.email}');
            },
          ),
        ],
      ),
    );
  }
}
