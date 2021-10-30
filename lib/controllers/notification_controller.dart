import 'dart:async';

import 'package:get/get.dart';
import 'package:poly_club/models/notification_model.dart';
import 'package:poly_club/services/API/user_services.dart';
import 'package:poly_club/utils/custom_bot_toast.dart';
import 'package:poly_club/values/const.dart';

class NotificationController extends GetxController {
  final RxList notifications = [].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetch();

    /// Refresh every 15s
    Timer.periodic(Duration(seconds: 15), (Timer t) {
      if (Get.currentRoute.contains('NotificationScreen')) {
        fetch();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetch() async {
    try {
      await UserService.getAllNotification().then((res) {
        if (res is List<Notif>) {
          notifications.clear();
          res.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
          notifications.addAll(res);
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      isLoading.value = false;
    }
  }
}
