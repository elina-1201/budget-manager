import 'package:budget_manager/src/core/exceptions/error_mapper.dart';
import 'package:dio/dio.dart';

/// Catches DioExceptions and rethrows them as AppExceptions.
/// This runs AFTER AuthInterceptor, so 401s that couldn't be refreshed
/// will also be wrapped.
class ErrorMappingInterceptor extends Interceptor {
  final ErrorMapper _errorMapper;

  ErrorMappingInterceptor(this._errorMapper);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = _errorMapper.map(err);
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        error: appException,
        type: err.type,
        response: err.response,
      ),
    );
  }
}
