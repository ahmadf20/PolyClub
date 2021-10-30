import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/controllers/notification_controller.dart';
import 'package:poly_club/controllers/profile/profile_controller.dart';
import 'package:poly_club/models/notification_model.dart';
import 'package:poly_club/screens/people_screen.dart';
import 'package:poly_club/utils/formatter.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/enums.dart';
import 'package:poly_club/values/text_style.dart';
import 'package:poly_club/widgets/error_screen.dart';
import 'package:poly_club/widgets/load_image.dart';
import 'package:poly_club/widgets/loading_indicator.dart';
import 'package:poly_club/widgets/markdown_text.dart';
import 'package:poly_club/widgets/modals/modal_bottom_sheet.dart';
import 'package:poly_club/widgets/modals/user_modal.dart';
import 'package:poly_club/widgets/page_title.dart';
import '../../values/const.dart';
import '../../widgets/unfocus_wrapper.dart';

import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatelessWidget {
  NotificationScreen({
    Key? key,
  }) : super(key: key);

  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX<NotificationController>(
        init: NotificationController(),
        builder: (s) {
          return ScreenWrapper(
            child: Padding(
              padding: EdgeInsets.all(Const.screenPadding)
                  .copyWith(top: 10, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageTitle(title: 'Notifikasi'),
                  SizedBox(height: 10),
                  Expanded(
                    child: s.isLoading.value
                        ? MyLoadingIndicator.circular()
                        : s.notifications.isEmpty
                            ? _ErrorWidgets()
                            : ListView(
                                padding: EdgeInsets.only(
                                    bottom: Const.bottomPadding, top: 10),
                                children: [
                                  ListView.separated(
                                    itemCount: s.notifications.length,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 20);
                                    },
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      Notif item = s.notifications[index];
                                      return _NotifCard(item);
                                    },
                                  ),
                                ],
                              ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ErrorScreen _ErrorWidgets() {
    return ErrorScreen(
      title: 'Oops! Nampaknya Kamu belum punya notifikasi apapun',
      subtitle:
          'Keliatannya kamu belum diikuti oleh siapapun, nih. Coba ikuti pengguna lain siapa tau kamu di-folback :p',
      hasButton: true,
      buttonText: 'Ikuti Pengguna Lain',
      icon: Icons.notifications_off_outlined,
      iconButton: Icons.search,
      onPressed: () {
        Get.off(() => PeopleScreen(PeopleListType.search));
      },
    );
  }
}

class _NotifCard extends StatelessWidget {
  final Notif notif;

  const _NotifCard(this.notif, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (notif.following == null) return Container();

    return GestureDetector(
      onTap: () {
        showMyModalBottomSheet(
            context, ModalBottomSheetUser(user: notif.following));
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Const.defaultBRadius),
              child: loadImage(
                notif.following!.avatar,
                height: 50,
                width: 50,
                initials: Formatter.nameAbbr(notif.following!.name ?? ''),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    '**${notif.following!.name ?? ''}** telah mengikuti kamu',
                    style: MyTextStyle.body2,
                  ),
                  SizedBox(height: 2.5),
                  //TODO: change locale
                  MyText(
                    timeago.format(notif.createdAt!, locale: 'id'),
                    style: MyTextStyle.caption.copyWith(
                      color: MyColors.darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
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
