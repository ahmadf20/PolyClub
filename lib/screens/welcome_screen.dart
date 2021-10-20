import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/controllers/auth_controller.dart';
import 'package:poly_club/screens/auth_screen.dart';
import 'package:poly_club/values/text_style.dart';
import 'package:poly_club/widgets/buttons/my_text_button.dart';
import 'package:poly_club/widgets/unfocus_wrapper.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        hasAppBar: false,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/icons/logo.png',
                  height: 25,
                ),
              ),
              SizedBox(height: 20),
              Spacer(flex: 3),
              Image.asset(
                'assets/images/welcome-image-1.png',
              ),
              Spacer(flex: 1),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Selamat datang di Aplikasi\nPolyClub',
                  style: MyTextStyle.headline5.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 25),
              Center(
                child: Text(
                  'PolyClub adalah sosial media berbasis video chat yang memungkinkan orang-orang di seluruh dunia berkumpul untuk berbicara, mendengarkan, dan belajar satu sama lain secara real-time.',
                  style: MyTextStyle.body2.copyWith(
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 45),
              Column(
                children: [
                  MyTextButton(
                      text: 'Masuk',
                      onPressed: () {
                        Get.to(() => AuthScreen(
                              authState: AuthState.login,
                            ));
                      }),
                  SizedBox(height: 15),
                  MyTextButton(
                    text: 'Daftar',
                    isOutlined: true,
                    onPressed: () {
                      Get.to(() => AuthScreen(
                            authState: AuthState.register,
                          ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
