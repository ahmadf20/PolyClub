import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poly_club/controllers/profile/profile_controller.dart';
import 'package:poly_club/models/user_model.dart';
import 'package:poly_club/services/API/user_services.dart';
import 'package:poly_club/utils/custom_bot_toast.dart';
import 'package:poly_club/utils/logger.dart';
import 'package:poly_club/values/const.dart';

class EditProfileController extends GetxController {
  final Rx<User> user = User().obs;

  TextEditingController? emailTC;
  TextEditingController? nameTC;
  TextEditingController? bioTC;
  TextEditingController? usernameTC;
  TextEditingController? passTC;
  TextEditingController? repassTC;

  final ImagePicker _picker = ImagePicker();
  PickedFile? _pickedFile;
  Rx<String> pickedFilePath = ''.obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void updateUser(User? newUser) {
    user.update((val) {
      if (val != null) {
        val.name = newUser!.name;
        val.email = newUser.email;
        val.id = newUser.id;
        val.avatar = newUser.avatar;
        val.username = newUser.username;
        val.bio = newUser.bio;
      }
    });
  }

  void initData() {
    User newUser = Get.find<ProfileController>().user.value;
    updateUser(newUser);

    emailTC = TextEditingController(text: user.value.email);
    nameTC = TextEditingController(text: user.value.name);
    usernameTC = TextEditingController(text: user.value.username);
    bioTC = TextEditingController(text: user.value.bio);

    passTC = TextEditingController();
    repassTC = TextEditingController();
  }

  RxBool get fieldNotComplete => (usernameTC!.text.isEmpty ||
          emailTC!.text.isEmpty ||
          // passTC!.text.isEmpty ||
          // repassTC!.text.isEmpty ||
          nameTC!.text.isEmpty)
      .obs;

  Future saveHandler() async {
    if (fieldNotComplete.value) {
      customBotToastText('All fields are required!');
      return;
    }

    // if (repassTC!.text != passTC!.text) {
    //   return;
    // }

    BotToast.showLoading();

    if (pickedFilePath.value.isNotEmpty) {
      File file = File(pickedFilePath.value);
      logger.v(file.path);
    }

    Map<String, dynamic> data = {
      'username': usernameTC!.text,
      'email': emailTC!.text,
      'name': nameTC!.text,
      'bio': bioTC!.text,
    };
    if (passTC!.text.isNotEmpty) {
      data['password'] = passTC!.text;
    }

    try {
      if (pickedFilePath.value.isNotEmpty) {
        await UserService.updateProfilePic(filepath: pickedFilePath.value)
            .then((res) {
          if (res is User) {
            customBotToastText('Foto Profil berhasil diupdate!');
          } else {
            customBotToastText(res);
          }
        });
      }

      await UserService.updateUserData(data).then((res) {
        if (res is User) {
          Get.find<ProfileController>().fetchUserData();
          Get.back();
          customBotToastText('Profil berhasil diupdate!');
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

  Future pickImage() async {
    _pickedFile = await _picker
        .pickImage(
      source: ImageSource.gallery,
      maxWidth: 256,
      maxHeight: 256,
    )
        .then((val) {
      if (val != null) {
        pickedFilePath.value = val.path;
        logger.i('Path: ${val}');
      }
      logger.v(_pickedFile?.path);
    }).catchError((e) {
      customBotToastText('Akses photo tidak diizinkan');
      logger.e(e);
    });
  }
}
