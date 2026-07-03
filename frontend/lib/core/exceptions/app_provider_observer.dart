import 'package:budget_manager/core/exceptions/error_mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class AppProviderObserver extends ProviderObserver {
  final ErrorMapper _errorMapper = const ErrorMapper();

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    final appException = _errorMapper.map(error, stackTrace);

    // Log in debug mode
    if (kDebugMode) {
      debugPrint(
        '🔴 [${context.provider.name ?? context.provider.runtimeType}] ${appException.runtimeType}: ${appException.message}',
      );
    }

    // TODO: Send to crashlytics / analytics in production
    // FirebaseCrashlytics.instance.recordError(appException, stackTrace);
  }
}
