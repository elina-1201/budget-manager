import 'package:budget_manager/core/exceptions/app_provider_observer.dart';
import 'package:budget_manager/core/theme/app_theme.dart';
import 'package:budget_manager/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(observers: [AppProviderObserver()], child: const AppRoot()),
  );
}

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en', 'US'), // Sunday first
        Locale('en', 'GB'), // Monday first
      ],
      routerConfig: ref.watch(goRouterProvider),
      theme: AppTheme.dark,
    );
  }
}
