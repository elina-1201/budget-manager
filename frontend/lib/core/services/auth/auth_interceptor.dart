import 'package:budget_manager/core/services/auth/storage/auth_storage.dart';
import 'package:budget_manager/core/services/token_refresh/token_refresh.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final AuthStorage _authStorage;
  final TokenRefreshService _tokenRefreshService;
  final Dio _dio;

  AuthInterceptor(this._authStorage, this._tokenRefreshService, this._dio);

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
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    final refreshed = await _tokenRefreshService.refreshToken();
    if (!refreshed) {
      handler.next(err);
      return;
    }

    final newToken = await _authStorage.getAccessToken();
    final options = err.requestOptions;
    options.headers['Authorization'] = 'Bearer $newToken';
    handler.resolve(await _dio.fetch(options));
  }
}
