import 'dart:convert';

import 'package:budget_manager/features/auth/login/data/dto/auth_response_body.dart';
import 'package:budget_manager/features/auth/register/data/dto/register_request_body.dart';
import 'package:dio/dio.dart';

class RegisterRepository {
  final Dio _dio;
  const RegisterRepository({required this._dio});

  Future<AuthenticationResponse> register(RegisterRequestBody body) async {
    final credentials = base64Encode(
      utf8.encode('${body.email}:${body.password}'),
    );

    await _dio.post('/auth/register', data: body.toMap());

    final response = await _dio.post(
      '/auth/token',
      options: Options(headers: {'Authorization': 'Basic $credentials'}),
    );

    return AuthenticationResponse(
      accessToken: response.data['access_token'],
      refreshToken: response.data['refresh_token'],
    );
  }
}
