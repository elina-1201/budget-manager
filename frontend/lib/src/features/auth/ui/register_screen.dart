import 'package:budget_manager/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).register)),
      body: RegisterForm(),
    );
  }
}
