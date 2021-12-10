import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/controllers/help_controller.dart';
import 'package:poly_club/widgets/loading_indicator.dart';
import 'package:poly_club/widgets/page_title.dart';
import '../../values/const.dart';
import '../../values/text_style.dart';
import '../../widgets/unfocus_wrapper.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HelpController>(
        init: HelpController(),
        builder: (s) {
          return ScreenWrapper(
            child: Padding(
              padding: EdgeInsets.all(Const.screenPadding)
                  .copyWith(top: 10, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageTitle(
                    title: 'Pusat Bantuan',
                    subtitle: 'Daftar pertanyaan yang mungkin kamu tanyakan',
                  ),
                  s.isLoading.value
                      ? Expanded(child: MyLoadingIndicator.circular())
                      : Expanded(
                          child: SingleChildScrollView(
                            child: ExpansionPanelList(
                              expansionCallback: (int index, bool isExpanded) {
                                s.toggleExpansion(index);
                              },
                              expandedHeaderPadding: EdgeInsets.only(
                                bottom: 20,
                              ),
                              children: [
                                ...s.helps.map((e) {
                                  return ExpansionPanel(
                                    canTapOnHeader: true,
                                    headerBuilder: (BuildContext context,
                                        bool isExpanded) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Const.screenPadding,
                                          vertical: Const.screenPadding * 2 / 3,
                                        ),
                                        child: Text(
                                          e.title ?? '',
                                          style: MyTextStyle.bodySemibold2,
                                        ),
                                      );
                                    },
                                    body: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 20),
                                      child: Text(
                                        e.content ?? '',
                                        style: MyTextStyle.caption,
                                      ),
                                    ),
                                    isExpanded: s.isExpanded(e.id!),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }
}
