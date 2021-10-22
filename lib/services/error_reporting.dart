import 'dart:async';
import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/logger.dart';
import '../values/const.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ErrorReporting {
  static Future initialize() async {
    // This captures errors reported by the Flutter framework.
    FlutterError.onError = (FlutterErrorDetails details) async {
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        if (details.stack != null) {
          // Send to Zone handle
          Zone.current.handleUncaughtError(details.exception, details.stack!);
        }
      }
    };
  }

  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    print('Caught error: $error');
    if (kDebugMode) {
      print(stackTrace);
      print('In dev mode. Not sending report.');
    } else {
      print('Sending report...');

      try {
        // In production mode, report to the application zone to report to Sentry.
        sendErrorToDiscord(error, stackTrace);
      } catch (e) {
        print('Sending report to sentry.io failed: $e');
        print('Original error: $error');
      }
    }
  }
}

Future<Map<String, dynamic>> getExtraData() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  Map<String, dynamic> data = {};

  if (Platform.isIOS) {
    final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    data = <String, dynamic>{
      'App version': '${packageInfo.version}+${packageInfo.buildNumber}',
      'name': iosDeviceInfo.name,
      'model': iosDeviceInfo.model,
      'systemName': iosDeviceInfo.systemName,
      'systemVersion': iosDeviceInfo.systemVersion,
      'localizedModel': iosDeviceInfo.localizedModel,
      'utsname': iosDeviceInfo.utsname.sysname,
      'identifierForVendor': iosDeviceInfo.identifierForVendor,
      'isPhysicalDevice': iosDeviceInfo.isPhysicalDevice,
    };
  } else if (Platform.isAndroid) {
    final AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;

    data = <String, dynamic>{
      'App version': '${packageInfo.version}+${packageInfo.buildNumber}',
      'type': androidDeviceInfo.type,
      'model': androidDeviceInfo.model,
      'device': androidDeviceInfo.device,
      'id': androidDeviceInfo.id,
      'androidId': androidDeviceInfo.androidId,
      'brand': androidDeviceInfo.brand,
      'display': androidDeviceInfo.display,
      'hardware': androidDeviceInfo.hardware,
      'manufacturer': androidDeviceInfo.manufacturer,
      'product': androidDeviceInfo.product,
      'version': androidDeviceInfo.version.release,
      'supported32BitAbis': androidDeviceInfo.supported32BitAbis,
      'supported64BitAbis': androidDeviceInfo.supported64BitAbis,
      'supportedAbis': androidDeviceInfo.supportedAbis,
      'isPhysicalDevice': androidDeviceInfo.isPhysicalDevice,
    };
  }
  return data;
}

void sendErrorToDiscord(exception, stackTrace) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  try {
    Map errorData = await getExtraData();
    errorData['exception'] = exception;
    errorData['stackTrace'] = stackTrace.toString().substring(0, 500);
    var data = {
      'username': '${packageInfo.appName.toString().toUpperCase()}',
      'avatar_url':
          'https://scontent.fbdo9-1.fna.fbcdn.net/v/t1.6435-9/90337569_114181460223474_1877090627510861824_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rDtQCwaYk80AX_RADVP&_nc_ht=scontent.fbdo9-1.fna&oh=4d7b9735389b475d67afdcf6ced27c00&oe=6156A1F8',
      'content':
          '\`\`\`js\n${errorData.toString().replaceAll(', ', ',\n')}\`\`\`',
    };
    var formData = await FormData.fromMap(data);

    await Dio().post(Const.discordReport,
        data: formData, options: Options(contentType: 'multipart/form-data'));
  } on DioError catch (e) {
    logger.e(e.response);
  } catch (e) {
    logger.e(e);
  }
}
