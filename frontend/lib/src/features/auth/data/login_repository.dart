import 'dart:convert';

import 'package:budget_manager/src/data/models/auth_response_body.dart';
import 'package:dio/dio.dart';

import 'login_request_body.dart';

class LoginRepository {
  final Dio _dio;
  LoginRepository({required this._dio});

  Future<AuthenticationResponse> login(LoginRequestBody body) async {
    final credentials = base64Encode(
      utf8.encode('${body.email}:${body.password}'),
    );
    final response = await _dio.post(
      '/auth/token',
      options: Options(headers: {'Authorization': 'Basic $credentials'}),
    );
    final token = response.data['access_token'];
    final refresh = response.data['refresh_token'];

    return AuthenticationResponse(accessToken: token, refreshToken: refresh);
  }
}
