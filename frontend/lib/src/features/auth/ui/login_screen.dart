import 'package:budget_manager/generated/l10n.dart';
import 'package:budget_manager/src/features/auth/ui/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).login)),
      body: LoginForm(),
    );
  }
}
