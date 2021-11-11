import 'package:get/get.dart';
import '../../models/user_model.dart';
import '../../screens/auth_screen.dart';
import '../../services/API/user_services.dart';
import '../../utils/custom_bot_toast.dart';
import '../../utils/shared_preferences.dart';
import '../../values/const.dart';

class ProfileController extends GetxController {
  final Rx<User> user = User().obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future fetchUserData() async {
    try {
      await UserService.getUser().then((res) {
        if (res is String &&
            res.toString().toLowerCase().contains('unauthorized')) {
          Get.offAll(() => AuthScreen());
          SharedPrefs.logOut();
        }

        if (res is User) {
          updateUser(res);
        } else {
          customBotToastText(res);
        }
      }).whenComplete(() => true);
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      if (isLoading.value) isLoading.toggle();
    }
  }

  void updateUser(User? newUser) {
    user.update((val) {
      if (val != null) {
        val.name = newUser?.name;
        val.email = newUser?.email;
        val.id = newUser?.id;
        val.avatar = newUser?.avatar;
        val.username = newUser?.username;
        val.bio = newUser?.bio;
        val.topic1 = newUser?.topic1;
        val.topic2 = newUser?.topic2;
        val.topic3 = newUser?.topic3;
        val.totalFollower = newUser?.totalFollower;
        val.totalFollowing = newUser?.totalFollowing;
        val.isFollowing = newUser?.isFollowing ?? false;
      }
    });
  }
}
