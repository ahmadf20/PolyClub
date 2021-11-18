import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:poly_club/models/topic_model.dart';

import '../controllers/profile/profile_controller.dart';
import '../models/user_model.dart';
import '../screens/home_screen.dart';
import '../services/API/topic_service.dart';
import '../utils/custom_bot_toast.dart';
import '../values/const.dart';

class TopicController extends GetxController {
  final RxList<Topic> topics = <Topic>[].obs;
  RxBool isLoading = true.obs;

  final RxList<int> selectedTopicIds = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    assignSelectedTopic();
  }

  void assignSelectedTopic() {
    if (Get.isRegistered<ProfileController>()) {
      ProfileController profileController = Get.find();

      if (profileController.user.value.topic1?.id != null) {
        selectedTopicIds
            .add(int.parse(profileController.user.value.topic1!.id!));
      }
      if (profileController.user.value.topic2?.id != null) {
        selectedTopicIds
            .add(int.parse(profileController.user.value.topic2!.id!));
      }
      if (profileController.user.value.topic3?.id != null) {
        selectedTopicIds
            .add(int.parse(profileController.user.value.topic3!.id!));
      }
    }
  }

  void selectTopic(int id) {
    if (selectedTopicIds.contains(id)) {
      selectedTopicIds.remove(id);
    } else {
      if (selectedTopicIds.length < 3) {
        selectedTopicIds.add(id);
      } else {
        customBotToastText('Kamu hanya dapat memilih maksimum 3 topik');
      }
    }
  }

  void fetchData() async {
    try {
      await TopicService.getAll().then((res) {
        if (res is List<Topic>) {
          topics.addAll(res);
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

  void chooseTopic(bool isFromRegister) async {
    if (selectedTopicIds.isEmpty) {
      customBotToastText('Pilih minimal 1 topik');
      return;
    }

    Map<String, dynamic> data = {
      'topic1': null,
      'topic2': null,
      'topic3': null,
    };

    if (selectedTopicIds.isNotEmpty) data['topic1'] = selectedTopicIds[0];
    if (selectedTopicIds.length >= 2) data['topic2'] = selectedTopicIds[1];
    if (selectedTopicIds.length == 3) data['topic3'] = selectedTopicIds[2];

    try {
      BotToast.showLoading();

      await TopicService.chooseTopics(data).then((res) {
        if (res is User) {
          if (isFromRegister) {
            Get.to(() => HomeScreen());
          } else {
            ProfileController profileController = Get.find();
            profileController.fetchUserData();

            Get.back();
          }
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
