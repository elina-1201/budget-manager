import 'package:budget_manager/core/di/di_setup.dart';
import 'package:budget_manager/core/services/auth/auth_storage/provider/auth_state_provider.dart';
import 'package:budget_manager/pages/items_list/items_list_screen.dart';
import 'package:budget_manager/pages/login/login_screen.dart';
import 'package:budget_manager/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  setupDependencies();

  runApp(ProviderScope(child: const AppRoot()));
}

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authStateProvider);
    //TODO: Implement dynamic routing
    return MaterialApp(
      routes: routes,
      home: authAsync.when(
        // Show a loading spinner while checking token status
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        // Fallback to login on error
        error: (e, _) => Text('Error checking auth status: $e'),
        // Show Items list if logged in, otherwise show Login
        data: (isLoggedIn) =>
            isLoggedIn ? const ItemsListScreen() : const LoginScreen(),
      ),
    );
    // return MaterialApp(routes: routes, initialRoute: '/login');
  }
}
