import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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

  @override
  void onInit() {
    super.onInit();
    fetchRooms();

    /// Refresh efery 1 minutes
    Timer.periodic(Duration(minutes: 1), (Timer t) {
      //TODO: fetch only if user in home page
      // get current route or handle with state

      if (Get.currentRoute.contains('HomeScreen')) {
        fetchRooms();
      }
    });
  }

  void fetchRooms() {
    fetchAllRoom();
    fetchMyRoom();
    fetchRecommendationRoom();
    fetchScheduledRoom();
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

  void fetchAllRoom() async {
    try {
      await RoomService.getAll(RoomListType.all).then((res) {
        if (res is List<Room>) {
          allRooms.clear();
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

  void fetchMyRoom() async {
    try {
      await RoomService.getAll(RoomListType.mine).then((res) {
        if (res is List<Room>) {
          myRooms.clear();
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

  void fetchRecommendationRoom() async {
    try {
      await RoomService.getAll(RoomListType.recommendation).then((res) {
        if (res is List<Room>) {
          recommendedRooms.clear();
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

  void fetchScheduledRoom() async {
    try {
      await RoomService.getAll(RoomListType.start_time).then((res) {
        if (res is List<Room>) {
          scheduledRooms.clear();
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
}
