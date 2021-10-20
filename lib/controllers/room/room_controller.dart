import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/services/room_service.dart';
import 'package:poly_club/values/enums.dart';

import '../../utils/custom_bot_toast.dart';
import '../../values/const.dart';

class RoomController extends GetxController {
  final RxList<Room> allRooms = <Room>[].obs;
  final RxList<Room> myRooms = <Room>[].obs;
  final RxList<Room> recommendedRooms = <Room>[].obs;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRooms();
  }

  void fetchRooms() {
    fetchAllRoom();
    fetchMyRoom();
    fetchRecommendationRoom();
  }

  List<Room> topRooms(RoomListType roomListType, [int length = 3]) {
    List<Room> rooms = [];
    switch (roomListType) {
      case RoomListType.all:
        rooms = allRooms;
        break;
      case RoomListType.mine:
        rooms = myRooms;
        break;
      case RoomListType.recommendation:
        rooms = recommendedRooms;
        break;
      default:
        rooms = allRooms;
    }

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
      if (isLoading.value) isLoading.toggle();
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
      if (isLoading.value) isLoading.toggle();
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
      if (isLoading.value) isLoading.toggle();
    }
  }
}
