import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:poly_club/models/user_model.dart';
import 'package:poly_club/services/API/user_services.dart';
import 'package:poly_club/utils/custom_bot_toast.dart';
import 'package:poly_club/values/const.dart';
import 'package:poly_club/values/enums.dart';

class PeopleController extends GetxController {
  TextEditingController searchTC = TextEditingController();

  RxString query = ''.obs;

  final Rx<PeopleListType> type = PeopleListType.search.obs;
  final PeopleListType _type;
  final User _user;

  PeopleController(this._type, this._user);

  @override
  void onInit() {
    super.onInit();

    setPeopleType(_type);

    if (type.value != PeopleListType.search) {
      fetchRelation(_type, _user.id!);

      searchTC.addListener(() {
        query.value = searchTC.text;
      });
    } else {
      fetchPeople(_type);
    }
  }

  List<User> get filteredUser => users
      .where((user) =>
          (user.name?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (user.username?.toLowerCase().contains(query.toLowerCase()) ?? false))
      .toList();

  void setPeopleType(PeopleListType type) {
    this.type.value = type;
  }

  final RxList<User> users = <User>[].obs;
  RxBool isLoading = true.obs;

  // Network Search
  Timer? timer;

  @override
  void onClose() {
    if (timer != null) timer!.cancel();

    super.onClose();
  }

  void fetchPeople(PeopleListType type) async {
    isLoading.value = true;

    try {
      await UserService.getUsers(searchTC.text).then((res) {
        if (res is List<User>) {
          users.clear();
          users.addAll(res);
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

  void fetchRelation(PeopleListType type, String userId) async {
    isLoading.value = true;

    try {
      await UserService.getRelation(type, userId).then((res) {
        if (res is List<User>) {
          users.clear();
          users.addAll(res);
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

  /// Only used for [PeopleListType.search]
  void searchPeople() {
    /// will not search from the hitting the API for non-search type. Instead, it will filter by the text in the search bar
    if (type.value != PeopleListType.search) return;

    if (timer != null) timer!.cancel();

    users.clear();
    if (!isLoading.value) isLoading.toggle();

    timer = Timer(const Duration(seconds: 1), () => fetchPeople(type.value));
  }

  void follow(User user) async {
    BotToast.showLoading();

    try {
      int userId = int.parse(user.id!);
      await UserService.addFollowing(userId).then((res) {
        if (res == true) {
          int index = users.indexWhere((element) => element.id == user.id);
          if (index == -1) return;

          User temp = users[index]
            ..isFollowing = true
            ..totalFollower =
                ((int.tryParse(users[index].totalFollower!) ?? 0) + 1)
                    .toString();

          users[index] = temp;

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
          int index = users.indexWhere((element) => element.id == user.id);
          if (index == -1) return;

          if (type.value == PeopleListType.following) {
            users.removeAt(index);
          } else {
            User temp = users[index]
              ..isFollowing = false
              ..totalFollower =
                  ((int.tryParse(users[index].totalFollower!) ?? 0) - 1)
                      .toString();

            users[index] = temp;
          }

          customBotToastText(
              'Kamu sudah tidak mengikuti ${user.username!} lagi!');
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
