import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/values/const.dart';
import 'package:poly_club/values/enums.dart';
import '../../../utils/logger.dart';
import '../configs/dio_configs.dart';

class RoomService {
  static Future getAll(RoomListType roomListType) async {
    try {
      Response res = await dio.get(
        '/room/${roomListType.toString().split('.').last}',
        options: Options(
          headers: await getHeader(),
        ),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return (res.data['data'] as List)
            .map((val) => Room.fromJson(val))
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

  static Future createRoom(Map<String, dynamic> data) async {
    try {
      Response res = await dio.post(
        '/room/create',
        data: data,
        options: Options(
          headers: await getHeader(),
        ),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return Room.fromJson(res.data['data']);
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

  static Future update(Map<String, dynamic> data, String id) async {
    try {
      Response res = await dio.put(
        '/room/single/$id',
        data: data,
        options: Options(
          headers: await getHeader(),
        ),
      );

      logger.v(json.decode(res.toString()));

      if (res.data['status'] >= 200 && res.data['status'] < 300) {
        return Room.fromJson(res.data['data']);
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

  static Future deleteRoom(String id) async {
    try {
      Response res = await dio.delete(
        '/room/single/$id',
        options: Options(
          headers: await getHeader(),
        ),
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

  static Future setReminderScheduledRoom(String roomId) async {
    try {
      Response res = await dio.post(
        '/room/reminder/$roomId',
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

  static Future cancelReminderScheduledRoom(String roomId) async {
    try {
      Response res = await dio.delete(
        '/room/reminder/cancel/$roomId',
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
}
