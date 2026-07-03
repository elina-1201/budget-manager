import 'dart:io';

import 'package:budget_manager/core/exceptions/app_exception.dart';
import 'package:dio/dio.dart';

class ErrorMapper {
  const ErrorMapper();

  AppException map(Object error, [StackTrace? stackTrace]) {
    if (error is AppException) return error;

    if (error is DioException) return _mapDioException(error);

    if (error is SocketException) {
      return const NetworkException(
        'No internet connection. Please check your network.',
      );
    }

    if (error is FormatException) {
      return const ValidationException(
        'Invalid data received from the server.',
      );
    }

    return const UnknownAppException(
      'An unexpected error occurred. Please try again.',
    );
  }

  AppException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(
          'Connection timed out. Please try again.',
        );
      case DioExceptionType.connectionError:
        return const NetworkException(
          'No internet connection. Please check your network.',
        );
      case DioExceptionType.badResponse:
        return _mapBadResponse(e);
      case DioExceptionType.cancel:
        return const NetworkException('Request was cancelled.');
      default:
        return UnknownAppException(
          'An unexpected error occurred: ${e.message}',
        );
    }
  }

  AppException _mapBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final serverMessage = _extractServerMessage(e.response);

    switch (statusCode) {
      case 400:
        return ValidationException(
          serverMessage ?? 'Invalid request. Please check your input.',
        );
      case 401:
        return const UnauthorizedException(
          'Your session has expired. Please log in again.',
        );
      case 403:
        return const UnauthorizedException(
          'You don\'t have permission to perform this action.',
        );
      case 404:
        return const ServerException(
          'The requested resource was not found.',
          statusCode: 404,
        );
      case 409:
        return ValidationException(serverMessage ?? 'Already exists.');
      case 422:
        return ValidationException(
          serverMessage ?? 'Please check your input and try again.',
        );
      case 500:
      case 502:
      case 503:
        return ServerException(
          'Server error. Please try again later.',
          statusCode: statusCode,
        );
      default:
        return ServerException(
          serverMessage ?? 'Something went wrong (${statusCode ?? 'unknown'}).',
          statusCode: statusCode,
        );
    }
  }

  String? _extractServerMessage(Response? response) {
    try {
      final data = response?.data;
      if (data is Map) {
        return data['message'] ?? data['error'] as String?;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
