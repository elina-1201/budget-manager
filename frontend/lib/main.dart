import 'package:budget_manager/core/services/auth/auth_mode_enum.dart';
import 'package:budget_manager/core/services/auth/storage/provider/auth_state_provider.dart';
import 'package:budget_manager/core/services/local_db/provider/local_db_provider.dart';
import 'package:budget_manager/router/provider/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const AppRoot()));
}

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _initLocalDb(ref);
    return MaterialApp.router(routerConfig: ref.watch(goRouterProvider));
  }

  void _initLocalDb(WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authMode = authState.asData?.value;
    final notAuthenticated =
        authMode == AuthMode.unauthenticated || authMode == AuthMode.guest;
    if (notAuthenticated) {
      ref.read(databaseConnectionProvider);
    }
  }
}
