import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'logger.dart';

void customBotToastText(dynamic text) {
  logger.d('customBotToastText: $text');
  BotToast.showText(
    text: text?.toString() ?? '-',
    textStyle: TextStyle(
      fontSize: 14,
    ),
    duration: Duration(seconds: 3),
    borderRadius: BorderRadius.all(Radius.circular(25)),
    clickClose: true,
    contentColor: Colors.grey[200]!,
    contentPadding: EdgeInsets.fromLTRB(20, 12.5, 20, 12.5),
  );
}
