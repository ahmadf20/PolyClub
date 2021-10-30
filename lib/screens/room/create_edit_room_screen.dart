import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:poly_club/controllers/room/edit_room_controller.dart';
import 'package:poly_club/controllers/topic_controller.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/models/topic_model.dart';
import 'package:poly_club/screens/topic/topic_card.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/const.dart';
import 'package:poly_club/values/text_style.dart';
import 'package:poly_club/widgets/app_bar.dart';
import 'package:poly_club/widgets/buttons/my_text_button.dart';
import 'package:poly_club/widgets/loading_indicator.dart';
import 'package:poly_club/widgets/modals/modal_bottom_sheet.dart';
import 'package:poly_club/widgets/my_text_field.dart';
import 'package:poly_club/widgets/page_title.dart';
import 'package:poly_club/widgets/section_header.dart';
import 'package:poly_club/widgets/unfocus_wrapper.dart';

class CreateRoomEditScreen extends StatelessWidget {
  final Room? room;

  const CreateRoomEditScreen({Key? key, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<EditRoomController>(
      init: EditRoomController(room),
      builder: (s) {
        return ScreenWrapper(
          floatingActionButton: MyTextButton(
            text: s.isEditing.value ? 'Simpan' : 'Buat Room',
            onPressed: s.saveHandler,
            isFullWidth: true,
            width: Get.size.width - 50,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: MyAppBar(
            actions: [
              if (room != null)
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: IconButton(
                      icon: Image.asset(
                        'assets/icons/icon-delete.png',
                        color: MyColors.red,
                        height: 24,
                      ),
                      onPressed: () {
                        showMyModalBottomSheet(context, ConfirmationDialog());
                      },
                    ),
                  ),
                ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                25, 0, 25, Const.bottomPaddingContentFAB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitle(
                  title: s.isEditing.value ? 'Ubah Room' : 'Buat Room',
                ),
                Expanded(
                  child: ListView(
                    children: [
                      MyTextField(
                        label: 'Judul',
                        hintText: 'Judul Room Kamu',
                        controller: s.titleTC,
                      ),
                      SizedBox(height: 10),
                      MyTextField(
                        label: 'Topik',
                        hintText: 'Topik yang Kamu Inginkan',
                        controller: s.topicTC,
                        onTap: () {
                          showMyModalBottomSheet(
                            context,
                            TopicList(),
                            isScrollControlled: false,
                          );
                        },
                        enabled: false,
                      ),
                      SizedBox(height: 10),
                      MyTextField(
                        label: 'Deskripsi',
                        hintText: 'Deskripsi Room Kamu',
                        controller: s.descTC,
                        minLines: 3,
                      ),
                      SectionHeader(
                        title: 'Jadwal (Opsional)',
                        subtitle:
                            'Isi form dibawah untuk membuat room terjadwal',
                        showTextButton: false,
                        padding: EdgeInsets.only(top: 25, bottom: 10),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              label: 'Tanggal',
                              hintText: 'Tanggal',
                              controller: s.dateTC,
                              enabled: false,
                              onTap: () => s.selectDate(context),
                              suffixIcon: GestureDetector(
                                onTap: () => s.clearDate(),
                                child: Icon(Icons.cancel),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: MyTextField(
                              label: 'Waktu',
                              hintText: 'Waktu',
                              controller: s.timeTC,
                              enabled: false,
                              onTap: () => s.selectTime(context),
                              suffixIcon: GestureDetector(
                                onTap: () => s.clearTime(),
                                child: Icon(Icons.cancel),
                              ),
                            ),
                          ),
                        ],
                      ),
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
}

class ConfirmationDialog extends StatelessWidget {
  ConfirmationDialog({
    Key? key,
  }) : super(key: key);

  final EditRoomController s = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 35, 25, Const.bottomPaddingButton),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PageTitle(
            title: 'Hapus Room?',
          ),
          Text(
            'Apakah kamu yakin ingin menghapus room ini? Room yang sudah dihapus tidak dapat dikembalikan.',
            style: MyTextStyle.body2,
          ),
          SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: MyTextButton(
                  text: 'Ya, hapus',
                  isFullWidth: false,
                  onPressed: () {
                    Get.back();
                    s.deleteRoom();
                  },
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: MyTextButton(
                  text: 'Batalkan',
                  isFullWidth: false,
                  isOutlined: true,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TopicList extends StatelessWidget {
  const TopicList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditRoomController editRoomController = Get.find();

    return Padding(
      padding: const EdgeInsets.all(Const.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageTitle(
            title: 'Pilih Topik',
            subtitle: 'Silakan pilih topik yang sesuai',
          ),
          GetX<TopicController>(
              init: TopicController(),
              builder: (v) {
                return Expanded(
                  child: v.isLoading.value
                      ? MyLoadingIndicator.circular()
                      : ListView(
                          padding: EdgeInsets.only(
                              bottom: Const.bottomPadding, top: 10),
                          children: [
                            ListView.separated(
                              padding:
                                  EdgeInsets.only(bottom: Const.bottomPadding),
                              itemCount: v.topics.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 15);
                              },
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                Topic item = v.topics[index];

                                return Obx(
                                  () => TopicCard(
                                    title: item.name ?? '',
                                    isSelected:
                                        editRoomController.topic!.value.id ==
                                            item.id,
                                    onTap: () {
                                      editRoomController.selectTopic(item);
                                      Get.back();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                );
              }),
        ],
      ),
    );
  }
}
