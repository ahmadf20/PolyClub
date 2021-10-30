import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poly_club/controllers/room/room_controller.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/utils/formatter.dart';
import 'package:poly_club/widgets/modals/modal_bottom_sheet.dart';
import 'package:poly_club/widgets/modals/room_modal.dart';
import 'package:poly_club/widgets/modals/user_modal.dart';
import '../../values/colors.dart';
import '../../values/const.dart';
import '../../values/text_style.dart';

import '../buttons/my_icon_button.dart';
import '../load_image.dart';
import '../topic_label.dart';

class RoomCard extends StatelessWidget {
  final String? iconPath;
  final Room? room;
  final bool showDetail;

  RoomCard({
    Key? key,
    this.iconPath,
    this.showDetail = false,
    this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (room == null) return Container();

    bool isScheduled = (room?.isScheduled ?? false) &&
        room!.startTime!.isAfter(DateTime.now());

    return GestureDetector(
      onTap: showDetail
          ? null
          : () {
              showMyModalBottomSheet(
                context,
                ModalBottomSheetRoom(room: room),
              );
            },
      child: Container(
        padding: showDetail ? EdgeInsets.zero : EdgeInsets.all(15),
        decoration: showDetail
            ? null
            : BoxDecoration(
                color: MyColors.lighterGrey,
                border: Border.all(
                  color: MyColors.lightGrey,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(Const.mediumBRadius),
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      if (isScheduled) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: MyColors.darkGrey,
                              size: showDetail ? 15 : 10,
                            ),
                            SizedBox(width: 5),
                            Text(
                              DateFormat('EEE, d MMM yyy - HH:mm WIB', 'id')
                                  .format(room!.startTime!),
                              style: MyTextStyle.caption.copyWith(
                                fontSize: showDetail ? 12 : 10,
                                color: MyColors.darkGrey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                      ],
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // if (showDetail) ...[
                          MyIconButton(
                            iconPath:
                                'assets/icons/icon-park-outline_topic.png',
                            radius: Const.mediumBRadius,
                            color: MyColors.secondary,
                            iconColor: MyColors.primary,
                          ),
                          SizedBox(width: 17),
                          // ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  room!.name ?? '',
                                  style: showDetail
                                      ? MyTextStyle.bodySemibold1
                                      : MyTextStyle.bodySemibold2,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2.5),
                                Text(
                                  room!.description ?? '',
                                  style: MyTextStyle.caption,
                                  maxLines: showDetail ? null : 3,
                                  overflow: showDetail
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                ),
                                if (showDetail) ...[
                                  SizedBox(height: 15),
                                  TopicLabel(
                                    text: room!.topic?.name?.toString() ??
                                        'Topic',
                                    isSmall: true,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5),
                if (isScheduled && !showDetail) ...[
                  MyIconButton(
                    iconPath: 'assets/icons/icon-bell.png',
                    radius: Const.mediumBRadius,
                    color: room!.isReminded
                        ? MyColors.secondary
                        : MyColors.lighterGrey,
                    iconColor: MyColors.primary,
                    isSmall: true,
                    onPressed: () {
                      final RoomController roomController = Get.find();

                      if (room!.isReminded) {
                        roomController.unsetReminder(room!);
                      } else {
                        roomController.setReminder(room!);
                      }
                    },
                  ),
                ],
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 5),
            if (room?.host?.name != null)
              GestureDetector(
                onTap: () {
                  showMyModalBottomSheet(
                      context, ModalBottomSheetUser(user: room?.host));
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: loadImage(
                        room?.host?.avatar,
                        initials: Formatter.nameAbbr(room?.host?.name ?? ''),
                        height: 20,
                        width: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        room?.host?.name ?? '-',
                        style: MyTextStyle.caption.copyWith(
                          fontSize: showDetail ? 12 : 10,
                        ),
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
