import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:budget_manager/core/services/auth_storage.dart';
import '../dto/login_request_body.dart';

class LoginRepository {
  final Dio _dio = GetIt.I.get<Dio>();
  Future<void> login(LoginRequestBody body) async {
    final credentials = base64Encode(
      utf8.encode('${body.email}:${body.password}'),
    );
    final baseUrl = GetIt.I.get<String>();
    final response = await _dio.post(
      '$baseUrl/auth/token',
      options: Options(headers: {'Authorization': 'Basic $credentials'}),
    );
    final token = response.data['access_token'];
    final refresh = response.data['refresh_token'];
    await GetIt.I.get<AuthStorage>().saveTokens(
      accessToken: token,
      refreshToken: refresh,
    );
    debugPrint(response.data.toString());
  }
}
