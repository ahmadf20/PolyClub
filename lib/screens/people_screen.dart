import 'package:flutter/material.dart';
import 'package:poly_club/widgets/cards/user_card.dart';
import 'package:poly_club/widgets/my_text_field.dart';
import 'package:poly_club/widgets/page_title.dart';
import '../../values/const.dart';
import '../../widgets/unfocus_wrapper.dart';

class PeopleScreen extends StatelessWidget {
  final String? title;

  const PeopleScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Padding(
        padding:
            EdgeInsets.all(Const.screenPadding).copyWith(top: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) PageTitle(title: title),
            MyTextField(
              hintText: 'Cari username ...',
              // suffixIcon: Icon(
              //   Icons.search,
              //   color: MyColors.darkGrey,
              // ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: Const.bottomPadding, top: 10),
                children: [
                  ListView.separated(
                    itemCount: 3,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return UserCard();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
