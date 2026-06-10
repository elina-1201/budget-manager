import 'dart:convert';

import 'package:budget_manager/pages/login/dto/login_response_body.dart';
import 'package:budget_manager/pages/register/dto/register_request_body.dart';
import 'package:dio/dio.dart';

class RegisterRepository {
  final Dio _dio;
  final String baseUrl;
  const RegisterRepository({required this._dio, required this.baseUrl});

  Future<AuthenticationResponse> register(RegisterRequestBody body) async {
    final credentials = base64Encode(
      utf8.encode('${body.email}:${body.password}'),
    );

    await _dio.post('$baseUrl/auth/register', data: body.toMap());

    final response = await Dio().post(
      '$baseUrl/auth/token',
      options: Options(headers: {'Authorization': 'Basic $credentials'}),
    );

    return AuthenticationResponse(
      accessToken: response.data['access_token'],
      refreshToken: response.data['refresh_token'],
    );
  }
}
