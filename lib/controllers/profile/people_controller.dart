import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:poly_club/models/user_model.dart';
import 'package:poly_club/services/user_services.dart';
import 'package:poly_club/utils/custom_bot_toast.dart';
import 'package:poly_club/values/const.dart';
import 'package:poly_club/values/enums.dart';

class PeopleController extends GetxController {
  TextEditingController searchTC = TextEditingController();

  RxString query = ''.obs;

  final Rx<PeopleListType> type = PeopleListType.search.obs;
  final PeopleListType _type;

  PeopleController(this._type);

  @override
  void onInit() {
    super.onInit();

    setPeopleType(_type);
    fetchPeople(_type);

    if (type.value != PeopleListType.search) {
      searchTC.addListener(() {
        query.value = searchTC.text;
      });
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

  /// Only used for [PeopleListType.search]
  void searchPeople() {
    /// will not search from the hitting the API for non-search type. Instead, it will filter by the text in the search bar
    if (type.value != PeopleListType.search) return;

    if (timer != null) timer!.cancel();

    users.clear();
    if (!isLoading.value) isLoading.toggle();

    timer = Timer(const Duration(seconds: 1), () => fetchPeople(type.value));
  }
}
