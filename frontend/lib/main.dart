import 'package:budget_manager/generated/l10n.dart';
import 'package:budget_manager/src/core/exceptions/app_provider_observer.dart';
import 'package:budget_manager/src/core/theme/app_theme.dart';
import 'package:budget_manager/src/router/router_provider.dart';
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
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('bs', 'BA`'),
      routerConfig: ref.watch(goRouterProvider),
      theme: AppTheme.dark,
    );
  }
}
