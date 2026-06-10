import 'dart:convert';

import 'package:dio/dio.dart';

import '../dto/login_request_body.dart';
import '../dto/login_response_body.dart';

class LoginRepository {
  final Dio _dio;
  final String baseUrl;
  LoginRepository({required this._dio, required this.baseUrl});

  Future<AuthenticationResponse> login(LoginRequestBody body) async {
    final credentials = base64Encode(
      utf8.encode('${body.email}:${body.password}'),
    );
    final response = await _dio.post(
      '$baseUrl/auth/token',
      options: Options(headers: {'Authorization': 'Basic $credentials'}),
    );
    final token = response.data['access_token'];
    final refresh = response.data['refresh_token'];

    return AuthenticationResponse(accessToken: token, refreshToken: refresh);
  }
}
