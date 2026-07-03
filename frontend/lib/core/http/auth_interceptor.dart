import 'package:budget_manager/core/storage/auth_storage.dart';
import 'package:budget_manager/core/token/token_refresh_service.dart';
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

    try {
      final newToken = await _authStorage.getAccessToken();
      final options = err.requestOptions;
      options.headers['Authorization'] = 'Bearer $newToken';
      handler.resolve(await _dio.fetch(options));
    } catch (retryError) {
      // If the retried request also fails, pass the original 401 error
      // through the chain so ErrorMappingInterceptor can handle it.
      handler.next(err);
    }
  }
}
