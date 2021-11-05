import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:poly_club/models/help_model.dart';
import 'package:poly_club/services/configs/dio_configs.dart';
import 'package:poly_club/utils/logger.dart';
import 'package:poly_club/values/const.dart';

class HelpService {
  static Future getAll() async {
    try {
      Response res = await dio.get(
        '/help',
        options: Options(
          headers: await getHeader(),
        ),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return (res.data['data'] as List)
            .map((val) => Help.fromJson(val))
            .toList();
      }
      return res.data['message'];
    } on DioError catch (e) {
      logger.e(e);
      if (e.response != null) {
        return e.response?.data['message'];
      } else {
        return ErrorMessage.connection;
      }
    } catch (e) {
      logger.e(e);
      return ErrorMessage.general;
    }
  }
}
