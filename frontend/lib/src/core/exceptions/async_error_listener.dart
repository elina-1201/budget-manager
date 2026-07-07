import 'package:budget_manager/src/core/exceptions/error_mapper.dart';
import 'package:budget_manager/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Extension on [WidgetRef] that provides a standardized way to listen
/// for errors from any [AsyncValue] provider and display them as SnackBars.
extension AsyncErrorListener on WidgetRef {
  void listenAsyncError<T>(
    ProviderListenable<AsyncValue<T>> provider, {
    required BuildContext context,
    ErrorMapper? errorMapper,
    String? prefix,
  }) {
    final mapper = errorMapper ?? const ErrorMapper();

    listen<AsyncValue<T>>(provider, (_, next) {
      next.whenOrNull(
        error: (error, _) {
          final appException = mapper.map(error);
          final message = prefix != null
              ? '$prefix: ${appException.message}'
              : appException.message;

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: AppColors.errorTrans,
              ),
            );
          }
        },
      );
    });
  }
}
