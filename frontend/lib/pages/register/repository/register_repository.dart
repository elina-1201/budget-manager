import 'package:budget_manager/pages/register/dto/user_request_body.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' show Dio, Headers, Options;

String apiBaseUrl() {
  //TODO: make web compatibility

  // Android emulator -> host machine
  // iOS simulator -> localhost works
  // real device -> use your LAN IP
  if (defaultTargetPlatform == TargetPlatform.android) {
    return 'http://10.0.2.2:8080';
  }
  return 'http://localhost:8080';
}

class RegisterRepository {
  final Dio _dio = Dio();
  Future<dynamic> register(UserRequestBody body) async {
    final response = await _dio.post(
      '${apiBaseUrl()}/auth/register',
      data: body.toMap(),
      options: Options(contentType: Headers.jsonContentType),
    );
    return response.data;
  }
}
