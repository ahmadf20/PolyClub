import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:poly_club/controllers/room/room_controller.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/values/enums.dart';

class SearchRoomController extends GetxController {
  TextEditingController searchTC = TextEditingController();

  RxString query = ''.obs;

  final Rx<RoomListType> type = RoomListType.all.obs;
  final RoomListType _type;

  SearchRoomController(this._type);

  RoomController roomController = Get.find();

  List<Room> get filteredRooms => roomController
      .getRoomsByType(type.value)
      .where((room) =>
          (room.name?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (room.host?.name?.toLowerCase().contains(query.toLowerCase()) ??
              false) ||
          (room.host?.username?.toLowerCase().contains(query.toLowerCase()) ??
              false) ||
          (room.description?.toLowerCase().contains(query.toLowerCase()) ??
              false) ||
          (room.topic?.name?.toLowerCase().contains(query.toLowerCase()) ??
              false))
      .toList();

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    setRoomType(_type);
    searchTC.addListener(() {
      query.value = searchTC.text;
    });
  }

  void setRoomType(RoomListType type) {
    this.type.value = type;
  }
}
