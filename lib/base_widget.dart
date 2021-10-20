import '../utils/logger.dart';
import '../widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';
import 'utils/shared_preferences.dart';

class BaseWidget extends StatefulWidget {
  BaseWidget({Key? key}) : super(key: key);

  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  String? token;

  Future getSavedToken() async {
    token = await SharedPrefs.getToken();
    logger.i(token);
    if (mounted) setState(() {});
  }

  void initialize() async {
    await getSavedToken();
    // await FCMService.initialize(context);

    if (token == null) {
      await Get.offAll(() => WelcomeScreen());
    } else {
      await Get.offAll(() => HomeScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyLoadingIndicator.circular(),
      ),
    );
  }
}
