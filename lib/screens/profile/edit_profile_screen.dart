import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:poly_club/controllers/profile/edit_profile_controller.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/const.dart';
import 'package:poly_club/values/text_style.dart';
import 'package:poly_club/widgets/buttons/my_text_button.dart';
import 'package:poly_club/widgets/load_image.dart';
import 'package:poly_club/widgets/my_text_field.dart';
import 'package:poly_club/widgets/page_title.dart';
import 'package:poly_club/widgets/unfocus_wrapper.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<EditProfileController>(
      init: EditProfileController(),
      builder: (s) {
        return ScreenWrapper(
          floatingActionButton: MyTextButton(
            text: 'Simpan',
            onPressed: s.saveHandler,
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
                  title: 'Ubah Profil',
                ),
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 15),
                      Container(
                        width: 90,
                        height: 90,
                        alignment: Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: buildProfileImg(s),
                        ),
                      ),
                      SizedBox(height: 13),
                      GestureDetector(
                        onTap: s.pickImage,
                        child: Text(
                          'Ganti Gambar',
                          style: MyTextStyle.caption.copyWith(
                            color: MyColors.darkGrey,
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      MyTextField(
                        label: 'Nama',
                        controller: s.nameTC,
                      ),
                      SizedBox(height: 10),
                      MyTextField(
                        label: 'Username',
                        controller: s.usernameTC,
                      ),
                      SizedBox(height: 10),
                      MyTextField(
                        label: 'Alamat Email',
                        controller: s.emailTC,
                      ),
                      SizedBox(height: 10),
                      MyTextField(
                        label: 'Biodata',
                        controller: s.bioTC,
                        minLines: 3,
                      ),
                      SizedBox(height: 10),
                      MyTextField(
                        label: 'Kata Sandi',
                        controller: s.passTC,
                        obscureText: true,
                        // suffixIcon: Icon(
                        //   Icons.remove_red_eye_outlined,
                        //   color: MyColors.darkGrey,
                        // ),
                      ),
                      // MyTextField(
                      //   label: 'Konfirmasi Kata Sandi',
                      //   controller: s.repassTC,
                      //   obscureText: true,
                      //   // suffixIcon: Icon(
                      //   //   Icons.remove_red_eye_outlined,
                      //   //   color: MyColors.darkGrey,
                      //   // ),
                      // ),

                      SizedBox(height: 25),
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

  Widget buildProfileImg(EditProfileController s) {
    if (s.pickedFilePath.value.isNotEmpty) {
      return Image.file(
        File(s.pickedFilePath.value),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    } else if (s.user.value.avatar != null &&
        s.user.value.avatar!.isNotEmpty &&
        !s.user.value.avatar!.contains('null')) {
      return loadImage(
        s.user.value.avatar,
        height: 100,
        width: 100,
      );
    } else {
      return Image.asset(
        'assets/images/default-profile-picture.png',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    }
  }
}
