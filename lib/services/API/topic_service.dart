import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:poly_club/models/topic_model.dart';
import 'package:poly_club/models/user_model.dart';
import 'package:poly_club/values/const.dart';
import '../../../utils/logger.dart';
import '../configs/dio_configs.dart';

class TopicService {
  static Future getAll() async {
    try {
      Response res = await dio.get(
        '/resource/topics',
        options: Options(
          headers: await getHeader(),
        ),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return (res.data['data'] as List)
            .map((val) => Topic.fromJson(val))
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

  static Future chooseTopics(Map<String, dynamic> data) async {
    try {
      Response res = await dio.put(
        '/user/topic/choose',
        data: {
          'topic1': data['topic1'],
          'topic2': data['topic2'],
          'topic3': data['topic3'],
        },
        options: Options(headers: await (getHeader())),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return User.fromJson(res.data['data']);
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
