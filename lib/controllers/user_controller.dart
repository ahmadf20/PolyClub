import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:poly_club/models/user_model.dart';
import 'package:poly_club/services/API/user_services.dart';
import 'package:poly_club/utils/custom_bot_toast.dart';
import 'package:poly_club/values/const.dart';

class UserController extends GetxController {
  final Rx<User> user = User().obs;
  RxBool isLoading = true.obs;

  final User _user;
  UserController(this._user);

  @override
  void onInit() {
    super.onInit();

    updateUser(_user);
    fetchUserData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchUserData() async {
    if (_user.id == null) return;

    try {
      await UserService.getUserById(_user.id!).then((res) {
        if (res is User) {
          updateUser(res);
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

  void follow(User user) async {
    BotToast.showLoading();

    try {
      int userId = int.parse(user.id!);
      await UserService.addFollowing(userId).then((res) {
        if (res == true) {
          updateUser(
            user
              ..isFollowing = true
              ..totalFollower =
                  ((int.tryParse(user.totalFollower!) ?? 0) + 1).toString(),
          );
          customBotToastText('Kamu telah mengikuti ${user.username!}!');
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

  void unFollow(User user) async {
    BotToast.showLoading();

    try {
      await UserService.removeFollowing(user.id!).then((res) {
        if (res == true) {
          updateUser(
            user
              ..isFollowing = false
              ..totalFollower =
                  ((int.tryParse(user.totalFollower!) ?? 1) - 1).toString(),
          );
          customBotToastText('Kamu berhenti mengikuti ${user.username!}!');
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
