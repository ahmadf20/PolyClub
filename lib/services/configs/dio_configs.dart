import 'package:dio/dio.dart';

import '../../utils/shared_preferences.dart';
import '../../values/const.dart';

BaseOptions options = BaseOptions(
  baseUrl: '${Const.url}',
  connectTimeout: 5000,
  receiveTimeout: 5000,
  // contentType: Headers.jsonContentType,
  // responseType: ResponseType.json,
);

Dio dio = Dio(options);

Future<Map<String, dynamic>> getHeader([bool hasToken = true]) async {
  // alternative
  // final response = await get('$url/users/me?_token=$token');

  Map<String, dynamic> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  if (hasToken) {
    header['Authorization'] = 'Bearer ${await SharedPrefs.getToken()}';
  }

  print(header);

  return header;
}
