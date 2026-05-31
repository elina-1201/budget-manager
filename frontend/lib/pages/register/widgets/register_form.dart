import 'package:flutter/material.dart';
import '../../../components/auth/auth.dart';
import '../dto/user_request_body.dart';
import '../repository/register_repository.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
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
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            EmailField(controller: _email),
            PasswordField(controller: _password),
            const SizedBox(height: 12),
            AuthButton(
              buttonText: 'Register',
              onPressed: () async {
                await RegisterRepository().register(
                  UserRequestBody(
                    name: _name.text,
                    email: _email.text,
                    password: _password.text,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
