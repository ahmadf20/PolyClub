import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/controllers/room/room_list_controller.dart';
import 'package:poly_club/controllers/room/room_controller.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/enums.dart';
import 'package:poly_club/widgets/error_screen.dart';
import 'package:poly_club/widgets/my_text_field.dart';
import 'package:poly_club/widgets/page_title.dart';
import '../../values/const.dart';
import '../../widgets/cards/room_card.dart';
import '../../widgets/unfocus_wrapper.dart';
import 'create_edit_room_screen.dart';

class ListRoomScreen extends StatelessWidget {
  final RoomListType type;

  ListRoomScreen({
    Key? key,
    this.type = RoomListType.all,
  }) : super(key: key);

  final RoomController roomController = Get.find();

  @override
  Widget build(BuildContext context) {
    String title = "";

    switch (type) {
      case RoomListType.all:
        title = 'Semua Room';
        break;
      case RoomListType.mine:
        title = 'Room Saya';
        break;
      case RoomListType.recommendation:
        title = 'Rekomendasi';
        break;
      case RoomListType.start_time:
        title = 'Obrolan Terjadwal';
        break;
      default:
    }

    return GetX<SearchRoomController>(
        init: SearchRoomController(type),
        builder: (s) {
          List<Room> rooms = s.filteredRooms;

          return ScreenWrapper(
            child: Padding(
              padding: EdgeInsets.all(Const.screenPadding)
                  .copyWith(top: 10, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageTitle(
                    title: title,
                    subtitle: 'Gabung ke room yang kamu inginkan',
                  ),
                  MyTextField(
                    hintText: 'Cari room ...',
                    controller: s.searchTC,
                    suffixIcon: Image.asset(
                      'assets/icons/icon-search.png',
                      width: 20,
                      height: 20,
                      color: MyColors.darkGrey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: rooms.isEmpty
                        ? ErrorScreen(
                            title: 'Oops! Room tidak ditemukan',
                            subtitle:
                                'Pastikan penulisannya benar. Atau Kamu bisa buat room kamu sendiri dengan tap tombol berikut',
                            buttonText: 'Buat Room',
                            icon: Icons.search_off_rounded,
                            iconButton: Icons.video_call_rounded,
                            onPressed: () =>
                                Get.to(() => CreateRoomEditScreen()),
                          )
                        : ListView(
                            padding: EdgeInsets.only(
                                bottom: Const.bottomPadding, top: 10),
                            children: [
                              ListView.separated(
                                itemCount: rooms.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 15);
                                },
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Room item = rooms[index];

                                  return RoomCard(room: item);
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
}
