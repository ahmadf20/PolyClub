import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:poly_club/services/API/topic_service.dart';
import 'package:poly_club/services/one_signal_service.dart';
import '../models/user_model.dart';
import '../screens/home_screen.dart';
import '../screens/topic/topic_list_screen.dart';
import '../services/API/user_services.dart';
import '../utils/custom_bot_toast.dart';
import '../utils/shared_preferences.dart';

enum AuthState { login, register }

class AuthController extends GetxController {
  final AuthState? state;

  final Rx<AuthState> _authState = AuthState.login.obs;

  AuthController({this.state});

  TextEditingController emailTC =
      TextEditingController(text: kDebugMode ? 'afaaiz2@gmail.com' : '');
  TextEditingController nameTC =
      TextEditingController(text: kDebugMode ? 'Ahmad Faaiz Al-auza\'i' : '');
  TextEditingController usernameTC =
      TextEditingController(text: kDebugMode ? 'ahmadf20' : '');
  TextEditingController passwordTC =
      TextEditingController(text: kDebugMode ? 'admin123' : '');

  @override
  void onInit() {
    super.onInit();
    if (state != null) {
      _authState.value = state!;
    }
  }

  @override
  void onClose() {
    super.onClose();
    clearTextFields();
    emailTC.dispose();
    nameTC.dispose();
    usernameTC.dispose();
    passwordTC.dispose();
  }

  void changeAuthState(AuthState state) {
    _authState.value = state;
    clearTextFields();
  }

  AuthState get authState => _authState.value;

  void clearTextFields() {
    emailTC.clear();
    nameTC.clear();
    usernameTC.clear();
    passwordTC.clear();
  }

  Future loginHandler() async {
    if (usernameTC.text.isEmpty || passwordTC.text.isEmpty) return;

    BotToast.showLoading();
    await UserService.login(
      usernameTC.text,
      passwordTC.text,
      callback: (value) {
        if (value != null) SharedPrefs.setToken(value['token']);
      },
    ).then((res) {
      if (res is User) {
        // set external user_id to onesignal service
        OneSignalService.setUserId(res.id!);

        // set tag by calling updateTopic
        TopicService.chooseTopics(<String, dynamic>{
          'topic1': res.topic1Id,
          'topic2': res.topic2Id,
          'topic3': res.topic3Id,
        });

        Get.offAll(() => HomeScreen());
      } else {
        customBotToastText(res);
      }
    }).whenComplete(BotToast.closeAllLoading);
  }

  Future registerHandler() async {
    if (usernameTC.text.isEmpty ||
        passwordTC.text.isEmpty ||
        nameTC.text.isEmpty ||
        emailTC.text.isEmpty) return;

    BotToast.showLoading();
    Map<String, dynamic> data = {
      'username': usernameTC.text,
      'email': emailTC.text,
      'password': passwordTC.text,
      'name': nameTC.text,
    };
    await UserService.register(
      data,
      callback: (value) {
        if (value != null) SharedPrefs.setToken(value['token']);
      },
    ).then((res) {
      if (res is User) {
        OneSignalService.setUserId(res.id!);
        Get.offAll(() => TopicListScreen(isFromRegister: true));
      } else {
        customBotToastText(res);
      }
    }).whenComplete(BotToast.closeAllLoading);
  }
}
