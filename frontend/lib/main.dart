import 'package:budget_manager/core/di/di_setup.dart';
import 'package:budget_manager/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  setupDependencies();

  runApp(ProviderScope(child: const AppRoot()));
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: routes, initialRoute: '/login');
  }
}
