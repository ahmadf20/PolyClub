import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:poly_club/models/notification_model.dart';
import 'package:poly_club/utils/shared_preferences.dart';
import 'package:poly_club/values/enums.dart';
import '../../models/user_model.dart';
import '../../values/const.dart';
import '../configs/dio_configs.dart';
import '../../utils/logger.dart';

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

  static Future getUserById(String id) async {
    try {
      Response res = await dio.get(
        '/user_by_id/$id',
        options: Options(headers: await (getHeader())),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return User.fromJson(res.data['data'][0]);
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

  static Future updateUserData(Map<String, dynamic> data) async {
    try {
      Response res = await dio.put(
        '/user/profile/update',
        data: data,
        options: Options(headers: {
          'Authorization': 'Bearer ${await SharedPrefs.getToken()}',
        }),
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

  static Future updateProfilePic({
    String? filepath,
  }) async {
    try {
      Map<String, dynamic> data = {};

      if (filepath != null) {
        data['image'] = await MultipartFile.fromFile(filepath);
      }

      Response res = await Dio().put(
        '${Const.url}/user/profile/avatar',
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

  /// [Get Users]
  static Future getUsers(String keyword) async {
    try {
      Response res = await dio.get(
        '/user/search?name=$keyword',
        options: Options(headers: await (getHeader())),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return (res.data['data'] as List)
            .map((val) => User.fromJson(val))
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

  /// [Get User Relationships]
  ///
  /// Search users, get followers, get following
  ///
  /// type: [PeopleListType]
  /// keyword: [String] (Optional - for [PeopleListType.search])
  static Future getRelation(PeopleListType type, String userId) async {
    try {
      Response res = await dio.get(
        '/user/${type.toString().split('.').last}_by_id/$userId',
        options: Options(headers: await (getHeader())),
      );

      print('/user/${type.toString().split('.').last}_by_id/$userId');

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return (res.data['data'] as List)
            .map((val) => User.fromJson(val))
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

  static Future addFollowing(int userId) async {
    try {
      Response res = await dio.post(
        '/user/follower/add',
        data: {
          'follower_id': userId,
        },
        options: Options(headers: await (getHeader())),
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

  static Future removeFollowing(String userId) async {
    try {
      Response res = await dio.delete(
        '/unfollows/$userId',
        options: Options(headers: await (getHeader())),
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

  /// [Get Notifications]
  static Future getAllNotification() async {
    try {
      Response res = await dio.get(
        '/notification/mine',
        options: Options(headers: await (getHeader())),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        if (res.data['data'] is List) {
          return (res.data['data'] as List)
              .map((val) => Notif.fromJson(val))
              .toList();
        }
        return <Notif>[];
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
