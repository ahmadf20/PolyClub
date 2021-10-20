import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poly_club/values/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final Function()? onBack;
  final List<Widget>? actions;

  const MyAppBar({
    Key? key,
    this.preferredSize = const Size.fromHeight(55),
    this.onBack,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        leadingWidth: 72,
        backgroundColor: MyColors.canvas,
        leading: IconButton(
          onPressed: () {
            onBack != null ? onBack!() : Get.back();
          },
          icon: Image.asset(
            'assets/icons/nav-back.png',
            width: 24,
            height: 24,
          ),
        ),
        actions: actions ?? [],
        elevation: 0,
      ),
    );
  }
}
