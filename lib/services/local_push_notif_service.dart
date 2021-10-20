import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Initalize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

// const MethodChannel platform =
//     MethodChannel('dexterx.dev/flutter_local_notifications_example');

//TODO: implement for IOS

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

class LocalPushNotifService {
  static Future initialize() async {
    // final NotificationAppLaunchDetails notificationAppLaunchDetails =
    //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    await configureLocalTimeZone();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_stat_ic_notification');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');

        Map jsonData = json.decode(payload);

        if (jsonData['data']['body']
            .toString()
            .toLowerCase()
            .contains('permintaan')) {
          // await Navigator.pushAndRemoveUntil(
          //     context,
          //     (MaterialPageRoute(builder: (context) {
          //       return MainMenu(
          //         index: 2,
          //       );
          //     })),
          //     (e) => false);
        }
      }

      selectNotificationSubject.add(payload ?? '');
    });
  }

  static Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    // tz.timeZoneDatabase.locations.forEach((v, loc) => print(v));
    // final String timeZoneName = await platform.invokeMethod('getTimeZoneName');

    //TODO: Set this to be available globally (get current time zone)
    // Temporary use 'Asia/Jakarta'
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
  }

  static Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }

  static Future<void> createNotificationChannel() async {
    /// Create a [AndroidNotificationChannel] for heads up notifications
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      //! dont change this unless you change the value in the `AndroidManifest`.xml as well
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      enableLights: true,
      showBadge: true,
      enableVibration: true,
      playSound: true,
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> showNotification(
    String title,
    String body, {
    String? channelId,
    String? channelName,
    String? channelDesc,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelId ?? 'Message Notification',
      channelName ?? 'Message Notification',
      importance: Importance.max,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
      ticker: 'ticker',
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  static Future showPeriodicNotif(
    String title,
    String body, {
    String? channelId,
    String? channelName,
    String? channelDesc,
    required tz.TZDateTime scheduledTime,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelId ?? 'Message Notification',
      channelName ?? 'Message Notification',
      importance: Importance.max,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
      ticker: 'ticker',
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      scheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
