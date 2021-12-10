import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/services/API/user_services.dart';
import 'package:poly_club/utils/custom_bot_toast.dart';
import 'package:poly_club/values/const.dart';

class ResetPasswordController extends GetxController {
  final RxInt currentStep = 0.obs;

  TextEditingController emailTC = TextEditingController();

  TextEditingController tokenTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  TextEditingController passwordConfirmTC = TextEditingController();

  final RxBool passwordVisible = false.obs;
  final RxBool passwordConfirmVisible = false.obs;

  Rx<String> pickedFilePath = ''.obs;

  RxBool get fieldNotComplete => (tokenTC.text.isEmpty ||
          passwordTC.text.isEmpty ||
          passwordConfirmTC.text.isEmpty)
      .obs;

  Future sendEmail() async {
    if (emailTC.text.isEmpty || !emailTC.text.isEmail) {
      customBotToastText('Pastikan email terisi dengan benar!');
      return;
    }

    BotToast.showLoading();

    try {
      await UserService.sendOTPResetPassword(emailTC.text).then((res) {
        if (res == true) {
          customBotToastText('Kode OTP telah terkirim!');
          currentStep.value = 1;
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

  Future resetPassword() async {
    if (fieldNotComplete.value) {
      customBotToastText('All fields are required!');
      return;
    }

    if (passwordTC.text != passwordConfirmTC.text) {
      customBotToastText('Password tidak sama!');
      return;
    }

    BotToast.showLoading();

    try {
      await UserService.resetPassword(
              emailTC.text, tokenTC.text, passwordConfirmTC.text)
          .then((res) {
        if (res == true) {
          Get.back();
          customBotToastText('Kata sandi berhasil diubah!');
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
