import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/controllers/profile/profile_controller.dart';
import 'package:poly_club/controllers/room/room_controller.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/screens/room/call_screen.dart';
import 'package:poly_club/screens/room/create_edit_room_screen.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/const.dart';
import 'package:poly_club/widgets/buttons/my_text_button.dart';
import 'package:poly_club/widgets/cards/room_card.dart';

class ModalBottomSheetRoom extends StatelessWidget {
  ModalBottomSheetRoom({
    Key? key,
    required this.room,
  }) : super(key: key);

  final Room? room;

  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isScheduled = (room!.isScheduled ?? false) &&
        room!.startTime != null &&
        DateTime(
                room!.startTime!.year,
                room!.startTime!.month,
                room!.startTime!.day,
                room!.startTime!.hour,
                room!.startTime!.minute)
            .isAfter(DateTime.now());

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
                  text: isScheduled
                      ? room!.isReminded
                          ? 'Batalkan pengingat'
                          : 'Ingatkan'
                      : 'Gabung ke Room',
                  isFullWidth: false,
                  isOutlined: room!.isReminded,
                  onPressed: () {
                    final RoomController roomController = Get.find();

                    if (isScheduled) {
                      if (room!.isReminded) {
                        roomController.unsetReminder(room!);
                      } else {
                        roomController.setReminder(room!);
                      }
                      Get.back();
                    } else {
                      Get.off(() => CallScreen(room: room!));
                    }
                  },
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
