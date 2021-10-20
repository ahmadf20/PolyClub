import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/controllers/topic_controller.dart';
import 'package:poly_club/models/topic_model.dart';
import 'package:poly_club/screens/home_screen.dart';
import 'package:poly_club/screens/topic/topic_card.dart';
import 'package:poly_club/widgets/app_bar.dart';
import 'package:poly_club/widgets/loading_indicator.dart';
import 'package:poly_club/widgets/page_title.dart';
import '../../values/colors.dart';
import '../../values/const.dart';
import '../../values/text_style.dart';
import '../../widgets/buttons/my_text_button.dart';
import '../../widgets/unfocus_wrapper.dart';

class TopicListScreen extends StatelessWidget {
  final bool isFromRegister;

  const TopicListScreen({
    Key? key,
    this.isFromRegister = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<TopicController>(
      init: TopicController(),
      builder: (s) {
        return ScreenWrapper(
          appBar: MyAppBar(
            actions: [
              if (isFromRegister)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      child: Text(
                        'Lewati',
                        style: MyTextStyle.body2.copyWith(
                          color: MyColors.darkGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => HomeScreen());
                      },
                    ),
                  ),
                ),
            ],
          ),
          floatingActionButton: MyTextButton(
            text: 'Pilih Topik (${s.selectedTopicIds.length}/3)',
            isFullWidth: true,
            width: Get.size.width - 50,
            onPressed: () {
              s.chooseTopic(isFromRegister);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          child: Padding(
            padding: EdgeInsets.all(Const.screenPadding)
                .copyWith(top: 10, bottom: Const.bottomPaddingContentFAB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitle(
                  title: 'Pilih Topik',
                  subtitle:
                      'Silakan pilih hingga 3 topik. Kami akan memberikan rekomendasi berdasarkan apa yang kamu pilih.',
                ),
                Expanded(
                  child: s.isLoading.value
                      ? MyLoadingIndicator.circular()
                      : ListView(
                          padding: EdgeInsets.only(
                              bottom: Const.bottomPadding, top: 10),
                          children: [
                            ListView.separated(
                              itemCount: s.topics.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 15);
                              },
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                Topic item = s.topics[index];

                                return TopicCard(
                                  title: item.name ?? '',
                                  isSelected: s.selectedTopicIds
                                      .contains(int.parse(item.id!)),
                                  onTap: () =>
                                      s.selectTopic(int.parse(item.id!)),
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
      },
    );
  }
}
