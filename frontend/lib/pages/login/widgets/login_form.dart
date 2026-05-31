import 'package:flutter/material.dart';

import '../../../components/auth/auth.dart';
import '../repository/login_repository.dart';
import '../dto/user_request_body.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EmailField(controller: _email),
            PasswordField(controller: _password),
            const SizedBox(height: 12),
            AuthButton(
              buttonText: 'Login',
              onPressed: () async {
                await LoginRepository().login(
                  UserRequestBody(email: _email.text, password: _password.text),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
