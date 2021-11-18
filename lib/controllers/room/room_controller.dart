import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:poly_club/controllers/profile/profile_controller.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/services/API/room_service.dart';
import 'package:poly_club/values/enums.dart';

import '../../utils/custom_bot_toast.dart';
import '../../values/const.dart';

class RoomController extends GetxController {
  final RxList<Room> allRooms = <Room>[].obs;
  final RxList<Room> myRooms = <Room>[].obs;
  final RxList<Room> recommendedRooms = <Room>[].obs;
  final RxList<Room> scheduledRooms = <Room>[].obs;

  RxBool isLoadingRecommendation = true.obs;
  RxBool isLoadingAllRoom = true.obs;
  RxBool isLoadingMyRoom = true.obs;
  RxBool isLoadingScheduledRooms = true.obs;

  ProfileController profileController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchRooms();

    /// Refresh every 1 minutes
    Timer.periodic(Duration(minutes: 1), (Timer t) {
      //fetch only if user in home page
      if (Get.currentRoute.contains('HomeScreen')) {
        fetchRooms();
      }
    });
  }

  Future fetchRooms() async {
    await fetchAllRoom();
    await fetchMyRoom();
    await fetchRecommendationRoom();
    await fetchScheduledRoom();
    return Future.value(true);
  }

  List<Room> getRoomsByType(RoomListType roomListType) {
    switch (roomListType) {
      case RoomListType.all:
        return allRooms;
      case RoomListType.mine:
        return myRooms;
      case RoomListType.recommendation:
        return recommendedRooms;
      case RoomListType.start_time:
        return scheduledRooms;
      default:
        return allRooms;
    }
  }

  List<Room> topRooms(RoomListType type, [int length = 3]) {
    List<Room> rooms = getRoomsByType(type);

    if (rooms.length <= length) return rooms;
    return rooms.sublist(0, length);
  }

  List<Room> get getReminderRoom => scheduledRooms
      .where((room) =>
          (room.isReminded) || room.hostId == profileController.user.value.id)
      .toList();

  Future fetchAllRoom() async {
    try {
      await RoomService.getAll(RoomListType.all).then((res) {
        if (res is List<Room>) {
          allRooms.clear();
          res.sort((a, b) =>
              a.isScheduled.toString().compareTo(b.isScheduled.toString()));
          allRooms.addAll(res);
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      isLoadingAllRoom.value = false;
    }
  }

  Future fetchMyRoom() async {
    try {
      await RoomService.getAll(RoomListType.mine).then((res) {
        if (res is List<Room>) {
          myRooms.clear();
          res.sort((a, b) =>
              a.isScheduled.toString().compareTo(b.isScheduled.toString()));
          myRooms.addAll(res);
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      isLoadingMyRoom.value = false;
    }
  }

  Future fetchRecommendationRoom() async {
    try {
      await RoomService.getAll(RoomListType.recommendation).then((res) {
        if (res is List<Room>) {
          recommendedRooms.clear();
          res.sort((a, b) =>
              a.isScheduled.toString().compareTo(b.isScheduled.toString()));
          recommendedRooms.addAll(res);
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      isLoadingRecommendation.value = false;
    }
  }

  Future fetchScheduledRoom() async {
    try {
      await RoomService.getAll(RoomListType.start_time).then((res) {
        if (res is List<Room>) {
          scheduledRooms.clear();
          res.sort((a, b) => a.startTime!.compareTo(b.startTime!));
          res.removeWhere((element) {
            if (element.startTime == null) return true;

            DateTime time = DateTime(
                element.startTime!.year,
                element.startTime!.month,
                element.startTime!.day,
                element.startTime!.hour,
                element.startTime!.minute);

            return time.isBefore(DateTime.now());
          });
          scheduledRooms.addAll(res);
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      isLoadingScheduledRooms.value = false;
    }
  }

  void setReminder(Room room) async {
    BotToast.showLoading();

    try {
      await RoomService.setReminderScheduledRoom(room.id!).then((res) {
        print(res);
        if (res == true) {
          // update scheduled room
          int index =
              scheduledRooms.indexWhere((element) => element.id == room.id);
          if (index != -1) {
            Room temp = scheduledRooms[index]..isReminded = true;
            scheduledRooms[index] = temp;
          }

          // update all room
          index = allRooms.indexWhere((element) => element.id == room.id);
          if (index != -1) {
            Room temp = allRooms[index]..isReminded = true;
            allRooms[index] = temp;
          }

          // update my room
          index = myRooms.indexWhere((element) => element.id == room.id);
          if (index != -1) {
            Room temp = myRooms[index]..isReminded = true;
            myRooms[index] = temp;
          }

          // update recommended room
          index =
              recommendedRooms.indexWhere((element) => element.id == room.id);
          if (index != -1) {
            Room temp = recommendedRooms[index]..isReminded = true;
            recommendedRooms[index] = temp;
          }

          customBotToastText('Pengingat berhasil diset!');
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      BotToast.closeAllLoading();
    }
  }

  void unsetReminder(Room room) async {
    BotToast.showLoading();

    try {
      await RoomService.cancelReminderScheduledRoom(room.id!).then((res) {
        if (res == true) {
          int index =
              scheduledRooms.indexWhere((element) => element.id == room.id);
          if (index != -1) {
            Room temp = scheduledRooms[index]..isReminded = false;
            scheduledRooms[index] = temp;
          }

          // update all room
          index = allRooms.indexWhere((element) => element.id == room.id);
          if (index != -1) {
            Room temp = allRooms[index]..isReminded = false;
            allRooms[index] = temp;
          }

          // update my room
          index = myRooms.indexWhere((element) => element.id == room.id);
          if (index != -1) {
            Room temp = myRooms[index]..isReminded = false;
            myRooms[index] = temp;
          }

          // update recommended room
          index =
              recommendedRooms.indexWhere((element) => element.id == room.id);
          if (index != -1) {
            Room temp = recommendedRooms[index]..isReminded = false;
            recommendedRooms[index] = temp;
          }

          customBotToastText('Pengingat berhasil dibatalkan!');
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      BotToast.closeAllLoading();
    }
  }
}
