import 'dart:convert';

import 'package:logger/logger.dart';

var logger = Logger(
  filter: null,
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
  output: null,
);

void loggerJson(res) {
  logger.v(jsonDecode(res.toString()));
}
