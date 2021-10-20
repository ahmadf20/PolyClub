import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:poly_club/utils/shared_preferences.dart';
import '../models/user_model.dart';
import '../values/const.dart';
import '../services/dio_configs.dart';
import '../utils/logger.dart';

class UserService {
  static Future login(
    String username,
    String password, {
    Function(Map?)? callback,
  }) async {
    try {
      Response res = await dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        if (callback != null) callback(res.data['data']);
        return User.fromJson(res.data['data']['user']);
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

  static Future register(
    Map<String, dynamic> data, {
    Function(Map?)? callback,
  }) async {
    try {
      Response res = await dio.post(
        '/auth/register',
        data: data,
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        if (callback != null) callback(res.data['data']);
        return User.fromJson(res.data['data']['user']);
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

  static Future getUser() async {
    try {
      Response res = await dio.get(
        '/user/profile/me',
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

  static Future updateUserData(
    Map<String, dynamic> data, {
    String? filepath,
  }) async {
    try {
      if (filepath != null) {
        data['avatar'] = await MultipartFile.fromFile(filepath);
      }

      Response res = await Dio().put(
        '${Const.url}/user/profile/update',
        data: FormData.fromMap(data),
        options: Options(headers: {
          'Authorization': 'Bearer ${await SharedPrefs.getToken()}',
        }),
        onSendProgress: (received, total) {
          if (total != -1) {
            logger.v((received / total * 100).toStringAsFixed(0) + "%");
          }
        },
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return true;
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
