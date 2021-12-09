import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/controllers/profile/reset_password_controller.dart';
import 'package:poly_club/values/const.dart';
import 'package:poly_club/widgets/buttons/my_text_button.dart';
import 'package:poly_club/widgets/my_text_field.dart';
import 'package:poly_club/widgets/page_title.dart';
import 'package:poly_club/widgets/unfocus_wrapper.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  final s = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return GetX<ResetPasswordController>(
        init: ResetPasswordController(),
        builder: (s) {
          int step = s.currentStep.value;

          return ScreenWrapper(
            onBack: step == 0 ? null : () => s.currentStep.value = 0,
            floatingActionButton: MyTextButton(
              text: step == 0 ? 'Kirim kode OTP' : 'Reset Kata Sandi',
              onPressed: () {
                step == 0 ? s.sendEmail() : s.resetPassword();
              },
              isFullWidth: true,
              width: Get.size.width - 50,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  25, 0, 25, Const.bottomPaddingContentFAB),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageTitle(
                    title: 'Reset Kata Sandi',
                    subtitle: step == 0
                        ? 'Silakan masukan email kamu yang terdaftar. Kami akan mengirimkan kode OTP ke email kamu.'
                        : 'Kami telah mengirimkan kode OTP ke email ${s.emailTC.text}. Silakan cek kotak masuk atau folder spam',
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(height: 15),
                        if (step == 0) ...[
                          MyTextField(
                            label: 'Email',
                            controller: s.emailTC,
                          ),
                          SizedBox(height: 10),
                        ],
                        if (step == 1) ...[
                          MyTextField(
                            label: 'Kode OTP',
                            controller: s.tokenTC,
                            textInputType: TextInputType.number,
                          ),
                          SizedBox(height: 10),
                          MyTextField(
                            label: 'Kata Sandi',
                            controller: s.passwordTC,
                            obscureText: !s.passwordVisible.value,
                            suffixIcon: GestureDetector(
                              onTap: () => s.passwordVisible.value =
                                  !s.passwordVisible.value,
                              child: Icon(
                                s.passwordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: s.passwordVisible.value
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          MyTextField(
                            label: 'Konfirmasi Kata Sandi',
                            controller: s.passwordConfirmTC,
                            obscureText: !s.passwordConfirmVisible.value,
                            suffixIcon: GestureDetector(
                              onTap: () => s.passwordConfirmVisible.value =
                                  !s.passwordConfirmVisible.value,
                              child: Icon(
                                s.passwordConfirmVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: s.passwordConfirmVisible.value
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
