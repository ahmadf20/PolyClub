import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poly_club/controllers/profile/profile_controller.dart';
import 'package:poly_club/controllers/room/room_controller.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/screens/people_screen.dart';
import 'package:poly_club/screens/profile/profile_screen.dart';
import 'package:poly_club/screens/room/create_edit_room_screen.dart';
import 'package:poly_club/utils/formatter.dart';
import 'package:poly_club/values/enums.dart';
import 'package:poly_club/widgets/error_screen.dart';
import 'package:poly_club/widgets/load_image.dart';
import 'package:poly_club/widgets/loading_indicator.dart';
import 'room/room_list_screen.dart';
import '../values/colors.dart';
import '../values/const.dart';
import '../values/text_style.dart';
import '../widgets/buttons/my_icon_button.dart';
import '../widgets/buttons/my_text_button.dart';
import '../widgets/cards/room_card.dart';
import '../widgets/section_header.dart';
import '../widgets/unfocus_wrapper.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ProfileController profileController = Get.put(ProfileController());
  final RoomController roomController = Get.put(RoomController());

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      hasAppBar: false,
      floatingActionButton: MyTextButton(
        text: 'Buat Room',
        iconPath: 'assets/icons/icon-room-create.png',
        isFullWidth: false,
        onPressed: () => Get.to(() => CreateRoomEditScreen()),
      ),
      child: Padding(
        padding: EdgeInsets.all(Const.screenPadding).copyWith(bottom: 0),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/logo.png',
                          height: 25,
                        ),
                        Text(
                          'The Social Video App',
                          style: MyTextStyle.body2.copyWith(
                            color: MyColors.darkGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MyIconButton(
                    onPressed: () =>
                        Get.to(() => PeopleScreen(PeopleListType.search)),
                    iconPath: 'assets/icons/icon-search.png',
                    color: MyColors.lighterGrey,
                    iconColor: MyColors.primary,
                  ),
                  SizedBox(width: 10),
                  MyIconButton(
                    onPressed: () {},
                    iconPath: 'assets/icons/icon-bell.png',
                    color: MyColors.lighterGrey,
                    iconColor: MyColors.primary,
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      profileController.fetchUserData();
                      Get.to(() => ProfileScreen());
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Const.defaultBRadius),
                      child: loadImage(
                        profileController.user.value.avatar,
                        initials: Formatter.nameAbbr(
                            profileController.user.value.name ?? ''),
                        width: 45,
                        height: 45,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    roomController.fetchRooms();
                    return Future.value(null);
                  },
                  child: ListView(
                    padding:
                        EdgeInsets.only(bottom: Const.bottomPaddingContentFAB),
                    children: [
                      SectionHeader(
                        title: 'Obrolan Terjadwal',
                        padding: EdgeInsets.only(top: 10),
                        onPressed: () {
                          Get.to(() =>
                              ListRoomScreen(type: RoomListType.start_time));
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: MyColors.lighterGrey,
                          border: Border.all(
                            color: MyColors.lightGrey,
                            width: 0.5,
                          ),
                          borderRadius:
                              BorderRadius.circular(Const.mediumBRadius),
                        ),
                        child: roomController.isLoadingScheduledRooms.value
                            ? MyLoadingIndicator.circular()
                            : roomController.myRooms.isEmpty
                                ? Center(
                                    child: Text(
                                    'Tidak ada Obrolan Terjadwal saat ini',
                                    style: MyTextStyle.caption
                                        .copyWith(color: MyColors.midGrey),
                                  ))
                                : ListView.builder(
                                    itemCount: roomController
                                        .topRooms(RoomListType.start_time)
                                        .length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      Room item = roomController.topRooms(
                                          RoomListType.start_time)[index];

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 3.5),
                                        child: Text(
                                          '${DateFormat('EEE, d MMM - HH:mm WIB', 'id').format(item.startTime!)}: ${item.name}',
                                          style: MyTextStyle.caption,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      );
                                    },
                                  ),
                      ),
                      SectionHeader(
                        title: 'Room Saya',
                        onPressed: () {
                          Get.to(() => ListRoomScreen(
                                type: RoomListType.mine,
                              ));
                        },
                      ),
                      roomController.isLoadingMyRoom.value
                          ? MyLoadingIndicator.circular()
                          : roomController.myRooms.isEmpty
                              ? ErrorScreen(
                                  title: 'Oops! Kamu belum punya room',
                                  subtitle:
                                      'Kamu bisa buat room kamu sendiri dengan tap tombol dibawah ini',
                                  buttonText: 'Buat Room',
                                  hasIcon: false,
                                  isCard: true,
                                  icon: Icons.video_collection,
                                  iconButton: Icons.video_call_rounded,
                                  onPressed: () =>
                                      Get.to(() => CreateRoomEditScreen()),
                                )
                              : ListView.separated(
                                  itemCount: roomController
                                      .topRooms(RoomListType.mine)
                                      .length,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 15);
                                  },
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    Room item = roomController
                                        .topRooms(RoomListType.mine)[index];

                                    return RoomCard(room: item);
                                  },
                                ),
                      SectionHeader(
                        title: 'Rekomendasi',
                        onPressed: () {
                          Get.to(() => ListRoomScreen(
                                type: RoomListType.recommendation,
                              ));
                        },
                      ),
                      roomController.isLoadingRecommendation.value
                          ? MyLoadingIndicator.circular()
                          : ListView.separated(
                              itemCount: roomController
                                  .topRooms(RoomListType.recommendation)
                                  .length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 15);
                              },
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                Room item = roomController.topRooms(
                                    RoomListType.recommendation)[index];

                                return RoomCard(room: item);
                              },
                            ),
                      SectionHeader(
                        title: 'Semua Room',
                        onPressed: () {
                          Get.to(() => ListRoomScreen(
                                type: RoomListType.all,
                              ));
                        },
                      ),
                      roomController.isLoadingAllRoom.value
                          ? MyLoadingIndicator.circular()
                          : ListView.separated(
                              itemCount: roomController
                                  .topRooms(RoomListType.all)
                                  .length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 15);
                              },
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                Room item = roomController
                                    .topRooms(RoomListType.all)[index];

                                return RoomCard(room: item);
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
