import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/controllers/room/room_controller.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/values/enums.dart';
import 'package:poly_club/widgets/my_text_field.dart';
import 'package:poly_club/widgets/page_title.dart';
import '../../values/const.dart';
import '../../widgets/cards/room_card.dart';
import '../../widgets/unfocus_wrapper.dart';

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
    List<Room> rooms = [];

    switch (type) {
      case RoomListType.all:
        title = 'Semua Room';
        rooms = roomController.allRooms;
        break;
      case RoomListType.mine:
        title = 'Room Saya';
        rooms = roomController.myRooms;
        break;
      case RoomListType.recommendation:
        title = 'Rekomendasi';
        rooms = roomController.recommendedRooms;
        break;
      default:
    }

    return Obx(() {
      return ScreenWrapper(
        child: Padding(
          padding:
              EdgeInsets.all(Const.screenPadding).copyWith(top: 10, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(
                title: title,
                subtitle: 'Gabung ke room yang kamu inginkan',
              ),
              MyTextField(
                hintText: 'Cari judul room atau topik...',
                // suffixIcon: Icon(
                //   Icons.search,
                //   color: MyColors.darkGrey,
                // ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
                  padding:
                      EdgeInsets.only(bottom: Const.bottomPadding, top: 10),
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
