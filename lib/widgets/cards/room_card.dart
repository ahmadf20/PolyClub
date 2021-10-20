import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poly_club/controllers/profile/profile_controller.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/screens/room/create_edit_room_screen.dart';
import 'package:poly_club/widgets/buttons/my_text_button.dart';
import '../../values/colors.dart';
import '../../values/const.dart';
import '../../values/text_style.dart';

import '../buttons/my_icon_button.dart';
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

    return GestureDetector(
      onTap: showDetail
          ? null
          : () {
              showModalBottomSheet(
                  context: context,
                  enableDrag: true,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Const.defaultBRadius)),
                  builder: (context) {
                    return ModalBottomSheetRoom(
                      room: room,
                    );
                  });
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
                      if ((room?.isScheduled ?? false)) ...[
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
                            iconPath: 'assets/icons/icon-room-create.png',
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
                                    text: room!.topicId?.toString() ?? '',
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
                if (room?.isScheduled ?? false) ...[
                  SizedBox(width: 17),
                  MyIconButton(
                    iconPath: 'assets/icons/icon-bell.png',
                    radius: Const.mediumBRadius,
                    color: MyColors.lighterGrey,
                    iconColor: MyColors.primary,
                    isSmall: true,
                    onPressed: () {
                      print('bell');
                    },
                  ),
                ],
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 5),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: MyColors.lightGrey,
                      borderRadius: BorderRadius.circular(100)),
                  padding: EdgeInsets.all(2.5),
                  child: Text(
                    'DS',
                    style: TextStyle(
                      fontSize: 8,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'dwianiSaputri',
                    style: MyTextStyle.caption.copyWith(
                      fontSize: showDetail ? 12 : 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ModalBottomSheetRoom extends StatelessWidget {
  ModalBottomSheetRoom({
    Key? key,
    required this.room,
  }) : super(key: key);

  final Room? room;

  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, Const.bottomPaddingButton),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 3.5,
            width: 50,
            decoration: BoxDecoration(
              color: MyColors.grey,
              borderRadius: BorderRadius.circular(Const.defaultBRadius),
            ),
          ),
          SizedBox(height: 25),
          RoomCard(
            room: room,
            showDetail: true,
          ),
          SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: MyTextButton(
                  text: 'Gabung ke Room',
                  isFullWidth: false,
                  onPressed: () {},
                ),
              ),
              if (profileController.user.value.id == room?.hostId) ...[
                SizedBox(width: 10),
                MyTextButton(
                  isFullWidth: false,
                  iconPath: 'assets/icons/nav-edit.png',
                  onPressed: () {
                    Get.to(
                      () => CreateRoomEditScreen(room: room),
                      preventDuplicates: false,
                    );
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
