import 'package:budget_manager/pages/login/login_screen.dart';
import 'package:budget_manager/pages/main/main_screen.dart';
import 'package:budget_manager/pages/register/register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const MainScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
      },
      // for testing
      initialRoute: '/login',
    );
  }
}
