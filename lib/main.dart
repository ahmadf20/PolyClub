import 'dart:async';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poly_club/services/local_push_notif_service.dart';
import 'package:bot_toast/bot_toast.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'base_widget.dart';
import 'services/error_reporting.dart';
import 'values/themes.dart';

Future<void> main() async {
  await runZonedGuarded<Future<Null>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await LocalPushNotifService.initialize().then((_) {
        print('Local Push Notif has been initialized!');
      });

      await LocalPushNotifService.createNotificationChannel().then((_) {
        print('Notification channel has been created!');
      });

      await ErrorReporting.initialize();

      // await initializeDateFormatting("id_ID", null).then(
      //   (_) => runApp(MyApp()),
      // );
      runApp(MyApp());
    },
    (error, stackTrace) async {
      await ErrorReporting.reportError(error, stackTrace);
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(mySystemUIOverlaySyle);

    return GetMaterialApp(
      title: 'PolyClub',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      locale: Locale('id'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: BotToastInit(),
      supportedLocales: [
        const Locale('id'),
        const Locale('en'),
      ],
      navigatorObservers: [BotToastNavigatorObserver()],
      home: BaseWidget(),
    );
  }
}
