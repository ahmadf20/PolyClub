import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:poly_club/controllers/auth_controller.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/text_style.dart';
import 'package:poly_club/widgets/buttons/my_text_button.dart';
import 'package:poly_club/widgets/my_text_field.dart';
import 'package:poly_club/widgets/page_title.dart';
import 'package:poly_club/widgets/unfocus_wrapper.dart';

class AuthScreen extends StatelessWidget {
  final AuthState authState;
  const AuthScreen({Key? key, this.authState = AuthState.login})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      init: AuthController(state: authState),
      builder: (s) {
        bool isLogin = s.authState == AuthState.login;

        return ScreenWrapper(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitle(
                  title: isLogin ? 'Selamat Datang 👋' : 'Daftar',
                  subtitle: isLogin
                      ? 'Masuk untuk memulai'
                      : 'Silakan isi data dibawah ini untuk mendaftar',
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [
                      if (!isLogin) ...[
                        MyTextField(
                          label: 'Nama Lengkap',
                          controller: s.nameTC,
                        ),
                        SizedBox(height: 10),
                        MyTextField(
                          label: 'Alamat Email',
                          controller: s.emailTC,
                        ),
                        SizedBox(height: 10),
                      ],
                      MyTextField(
                        label: 'Username',
                        controller: s.usernameTC,
                      ),
                      SizedBox(height: 10),
                      MyTextField(
                        label: 'Kata Sandi',
                        controller: s.passwordTC,
                        obscureText: true,
                        // suffixIcon: Icon(
                        //   Icons.remove_red_eye_outlined,
                        //   color: MyColors.darkGrey,
                        // ),
                      ),
                      SizedBox(height: 35),
                      MyTextButton(
                          text: isLogin ? 'Masuk' : 'Daftar',
                          onPressed: () {
                            if (s.state == AuthState.login) {
                              s.loginHandler();
                            } else {
                              s.registerHandler();
                            }
                          }),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLogin ? 'Belum punya akun?' : 'Sudah punya akun?',
                            style: MyTextStyle.body2.copyWith(
                              color: MyColors.darkGrey,
                            ),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              s.changeAuthState(isLogin
                                  ? AuthState.register
                                  : AuthState.login);
                            },
                            child: Text(
                              isLogin ? 'Daftar' : 'Masuk',
                              style: MyTextStyle.body2.copyWith(
                                color: MyColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
