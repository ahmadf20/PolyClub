import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poly_club/values/themes.dart';

import 'app_bar.dart';

/// [Widget Wrapper]
///
/// A wrapper of most common used widget in every screen to make widget tree cleaner and avoid from having boiler plate.
/// TODO: try to put scroll behaviour
/// TODO: try to implement to all screen
class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({
    Key? key,
    this.onTap,
    this.onWillPop,
    this.onBack,
    this.hasAppBar = true,
    required this.child,
    this.floatingActionButton,
    this.appBar,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  final Function()? onTap;
  final Future<bool> Function()? onWillPop;
  final Function()? onBack;
  final Widget child;
  final bool hasAppBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Get.focusScope?.unfocus(),
      child: WillPopScope(
        onWillPop: onWillPop,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: mySystemUIOverlaySyle,
          child: Scaffold(
            appBar: !hasAppBar ? null : appBar ?? MyAppBar(onBack: onBack),
            floatingActionButton: floatingActionButton ?? SizedBox.shrink(),
            floatingActionButtonLocation: floatingActionButtonLocation ??
                FloatingActionButtonLocation.endFloat,
            body: SafeArea(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
