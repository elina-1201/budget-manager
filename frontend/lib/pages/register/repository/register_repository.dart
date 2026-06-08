import 'package:budget_manager/pages/register/dto/register_request_body.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class RegisterRepository {
  final Dio _dio = GetIt.I.get<Dio>();

  //FIXME: take token after register and use it for rerouting to items
  Future<dynamic> register(RegisterRequestBody body) async {
    final baseUrl = GetIt.I.get<String>();
    final response = await _dio.post(
      '$baseUrl/auth/register',
      data: body.toMap(),
      options: Options(contentType: Headers.jsonContentType),
    );
    return response.data;
  }
}
