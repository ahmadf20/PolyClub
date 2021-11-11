import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/controllers/profile/people_controller.dart';
import 'package:poly_club/controllers/profile/profile_controller.dart';
import 'package:poly_club/models/user_model.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/enums.dart';
import 'package:poly_club/widgets/cards/user_card.dart';
import 'package:poly_club/widgets/error_screen.dart';
import 'package:poly_club/widgets/loading_indicator.dart';
import 'package:poly_club/widgets/my_text_field.dart';
import 'package:poly_club/widgets/page_title.dart';
import '../../values/const.dart';
import '../../widgets/unfocus_wrapper.dart';

class PeopleScreen extends StatelessWidget {
  final String? title;
  final PeopleListType type;
  final User? user;

  PeopleScreen(this.type, {Key? key, this.title, this.user}) : super(key: key);

  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    String title = "";

    switch (type) {
      case PeopleListType.search:
        title = 'Pengguna';
        break;
      case PeopleListType.follower:
        title = 'Pengikut';
        break;
      case PeopleListType.following:
        title = 'Mengikuti';
        break;
      default:
    }

    return GetX<PeopleController>(
        init: PeopleController(type, user ?? profileController.user.value),
        builder: (s) {
          return ScreenWrapper(
            child: Padding(
              padding: EdgeInsets.all(Const.screenPadding)
                  .copyWith(top: 10, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageTitle(title: title),
                  MyTextField(
                    hintText: 'Cari username atau nama..',
                    controller: s.searchTC,
                    onChanged: (val) => s.searchPeople(),
                    suffixIcon: Image.asset(
                      'assets/icons/icon-search.png',
                      width: 20,
                      height: 20,
                      color: MyColors.darkGrey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: s.isLoading.value
                        ? MyLoadingIndicator.circular()
                        : s.users.isEmpty
                            ? _ErrorWidgets(s)
                            : ListView(
                                padding: EdgeInsets.only(
                                    bottom: Const.bottomPadding, top: 10),
                                children: [
                                  ListView.separated(
                                    itemCount: s.filteredUser.length,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 20);
                                    },
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      User item = s.filteredUser[index];

                                      return UserCard(
                                        item,
                                        onTap: () {
                                          if (item.isFollowing) {
                                            s.unFollow(item);
                                          } else {
                                            s.follow(item);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ErrorScreen _ErrorWidgets(PeopleController s) {
    if (type == PeopleListType.search ||
        (type == PeopleListType.search && s.users.isEmpty)) {
      return ErrorScreen(
        title: 'Oops! User yang Kamu cari tidak ditemukan',
        subtitle:
            'Kamu yakin sudah menuliskannya dengan benar? Kamu juga bisa mencari dengan username ataupun nama mereka loh!',
        hasButton: false,
        buttonText: 'Hapus pencarian',
        icon: Icons.search_off_rounded,
        iconButton: Icons.clear,
        onPressed: () {
          s.searchTC.clear();
        },
      );
    } else {
      return ErrorScreen(
        title: 'Oops! Kamu belum memiliki teman',
        subtitle:
            'Kamu bisa menambahkan teman dengan mengikuti orang lain terlebih dahulu',
        buttonText: 'Cari teman',
        icon: Icons.people_rounded,
        iconButton: Icons.person_search_rounded,
        onPressed: () {
          s.setPeopleType(PeopleListType.search);
          s.fetchPeople(PeopleListType.search);
          Get.off(
            () => PeopleScreen(PeopleListType.search),
            preventDuplicates: false,
          );
        },
      );
    }
  }
}
