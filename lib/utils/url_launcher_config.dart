import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'custom_bot_toast.dart';

class UrlLauncherConfig {
  static Future open(String url) async {
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch('$url');
      } else {
        customBotToastText('Link tidak valid!');
        throw 'Could not launch $url';
      }
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch $url');
        customBotToastText('Link tidak valid!');
      }
    }
  }
}
