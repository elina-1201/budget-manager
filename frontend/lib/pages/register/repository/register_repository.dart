import 'package:budget_manager/pages/register/dto/user_request_body.dart';
import 'package:dio/dio.dart' show Dio, Headers, Options;
import 'package:get_it/get_it.dart';

class RegisterRepository {
  final Dio _dio = Dio();
  Future<dynamic> register(UserRequestBody body) async {
    final baseUrl = GetIt.I.get<String>();
    final response = await _dio.post(
      '$baseUrl/auth/register',
      data: body.toMap(),
      options: Options(contentType: Headers.jsonContentType),
    );
    return response.data;
  }
}
