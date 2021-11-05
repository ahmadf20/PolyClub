import 'package:get/get.dart';
import 'package:poly_club/models/help_model.dart';
import 'package:poly_club/services/API/help_service.dart';
import 'package:poly_club/utils/custom_bot_toast.dart';
import 'package:poly_club/values/const.dart';

class HelpController extends GetxController {
  final RxList<Help> helps = <Help>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetch() async {
    try {
      await HelpService.getAll().then((res) {
        if (res is List<Help>) {
          helps.clear();
          helps.addAll(res);
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

  void toggleExpansion(int index) {
    Help help = helps[index];
    help.isExpanded = !help.isExpanded;
    helps[index] = help;
  }

  bool isExpanded(String id) {
    return helps.where((help) => help.id == id).first.isExpanded;
  }
}
