import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poly_club/controllers/room/room_controller.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/models/topic_model.dart';
import 'package:poly_club/services/room_service.dart';
import 'package:poly_club/utils/custom_bot_toast.dart';
import 'package:poly_club/values/const.dart';

class EditRoomController extends GetxController {
  final Rx<Room> detailRoom = Room().obs;

  final RxBool isEditing = false.obs;

  TextEditingController? descTC = TextEditingController();
  TextEditingController? titleTC = TextEditingController();
  TextEditingController? dateTC = TextEditingController();
  TextEditingController? timeTC = TextEditingController();
  TextEditingController? topicTC = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Rx<Topic>? topic = Topic().obs;

  final Room? _room;

  EditRoomController([this._room]);

  @override
  void onInit() {
    if (_room != null) {
      isEditing.value = true;
      initData();
    }
    super.onInit();
  }

  void updateRoom(Room? room) {
    detailRoom.update((val) {
      if (val != null) {
        val.name = room!.name;
        val.id = room.id;
        val.description = room.description;
        val.createdAt = room.createdAt;
        val.updatedAt = room.updatedAt;
        val.hostId = room.hostId;
        val.topicId = room.topicId;
        val.startTime = room.startTime;
        val.isScheduled = room.isScheduled;
      }
    });
  }

  void initData() {
    updateRoom(_room);

    titleTC = TextEditingController(text: detailRoom.value.name);
    descTC = TextEditingController(text: detailRoom.value.description);
    topicTC = TextEditingController(text: 'Topic');

    topic!.update((val) {
      if (val != null) {
        val.id = detailRoom.value.topicId;
      }
    });

    if (detailRoom.value.isScheduled ?? false) {
      selectedDate = detailRoom.value.startTime;
      selectedTime = TimeOfDay.fromDateTime(selectedDate!);

      dateTC = TextEditingController(
          text: DateFormat('d MMM yyy', 'id').format(selectedDate!));
      timeTC = TextEditingController(
          text: DateFormat('HH:mm').format(selectedDate!));
    }
  }

  RxBool get fieldNotComplete =>
      (descTC!.text.isEmpty || titleTC!.text.isEmpty || topicTC!.text.isEmpty)
          .obs;

  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      locale: Locale('id', 'ID'),
    );

    if (picked != null) {
      selectedDate = picked;
      dateTC!.text = DateFormat('d MMM yyy', 'id').format(picked);
      print(picked);
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 0),
    );

    if (picked != null) {
      selectedTime = picked;
      timeTC!.text = picked.format(context);
      print(picked.format(context));
    }
  }

  void clearDate() {
    selectedDate = null;
    dateTC!.text = '';
  }

  void clearTime() {
    selectedTime = null;
    timeTC!.text = '';
  }

  void selectTopic(Topic topic) {
    this.topic!.value = topic;
    topicTC!.text = topic.name ?? '';
  }

  Future saveHandler() async {
    if (fieldNotComplete.value) {
      customBotToastText('Pastikan seluruh form wajib terisi dengan benar');
      return;
    }

    if ((timeTC!.text.isEmpty && dateTC!.text.isNotEmpty) ||
        (dateTC!.text.isEmpty && timeTC!.text.isNotEmpty)) {
      customBotToastText('Periksa kembali form jadwal');
      return;
    }

    BotToast.showLoading();

    Map<String, dynamic> data = {
      "name": titleTC!.text,
      "description": descTC!.text,
      //"2021-10-20 08:30:00.000 +0700",
      "start_time": selectedDate
              ?.add(Duration(
                hours: selectedTime!.hour,
                minutes: selectedTime!.minute,
              ))
              .toIso8601String() ??
          '',
      "topic_id": topic!.value.id,
    };

    print(data);

    try {
      if (isEditing.value) {
        await RoomService.update(data, detailRoom.value.id!).then((res) {
          if (res is Room) {
            RoomController roomController = Get.find();
            roomController.fetchRooms();

            Get.back();
            Get.back();
            customBotToastText('Room berhasil diupdate');
          } else {
            customBotToastText(res);
          }
        });
      } else {
        await RoomService.createRoom(data).then((res) {
          if (res is Room) {
            RoomController roomController = Get.find();
            roomController.fetchRooms();

            Get.back();
            customBotToastText('Room berhasil dibuat');
          } else {
            customBotToastText(res);
          }
        });
      }
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      BotToast.closeAllLoading();
    }
  }

  void deleteRoom() async {
    BotToast.showLoading();

    try {
      await RoomService.deleteRoom(detailRoom.value.id!).then((res) {
        if (res == true) {
          customBotToastText('Room berhasil dihapus');

          RoomController roomController = Get.find();
          roomController.fetchRooms();

          Get.back();
          Get.back();
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
