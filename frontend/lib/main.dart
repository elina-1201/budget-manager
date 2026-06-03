import 'package:budget_manager/di/di_setup.dart';
import 'package:budget_manager/route/routes.dart';
import 'package:flutter/material.dart';

void main() {
  diInitialization();

  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: routes, initialRoute: '/login');
  }
}
