import 'package:budget_manager/pages/login/dto/user_request_body.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

String apiBaseUrl() {
  //TODO: make web compatible

  // Android emulator -> host machine
  // iOS simulator -> localhost works
  // real device -> use your LAN IP
  if (defaultTargetPlatform == TargetPlatform.android) {
    return 'http://10.0.2.2:8080';
  }
  return 'http://localhost:8080';
}

//NOTE: /login doesn't exist on the backend yet!
class LoginRepository {
  final Dio _dio = Dio();
  Future<dynamic> login(UserRequestBody body) async {
    final response = await _dio.post(
      '${apiBaseUrl()}/auth/login',
      data: body.toMap(),
      options: Options(contentType: Headers.jsonContentType),
    );
    return response.data;
  }
}
