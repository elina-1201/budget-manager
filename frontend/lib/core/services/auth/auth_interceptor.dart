import 'package:budget_manager/core/services/auth/storage/auth_storage.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final AuthStorage _authStorage;
  final Dio _dio;

  AuthInterceptor(this._authStorage, this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await _authStorage.getRefreshToken();

      if (refreshToken == null) {
        await _authStorage.deleteTokens();
        handler.next(err);
        return;
      }

      try {
        // Use a separate Dio instance to avoid interceptor loop
        final refreshDio = Dio(BaseOptions(baseUrl: _dio.options.baseUrl));
        final response = await refreshDio.post(
          '/auth/refresh',
          data: {'refresh_token': refreshToken},
        );

        await _authStorage.saveTokens(
          accessToken: response.data['access_token'],
          refreshToken: response.data['refresh_token'],
        );

        // Retry original request
        final opts = err.requestOptions;
        opts.headers['Authorization'] =
            'Bearer ${response.data['access_token']}';
        handler.resolve(await _dio.fetch(opts));
      } catch (_) {
        await _authStorage.deleteTokens();
        handler.next(err);
      }
      return;
    }
    handler.next(err);
  }
}
