import 'package:budget_manager/core/exceptions/async_error_listener.dart';
import 'package:budget_manager/features/auth/providers/register_notifier.dart';
import 'package:budget_manager/shared/widgets/auth_fields/auth_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
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
    ref.listenAsyncError(registerProvider, context: context);

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
              onPressed: () => ref
                  .read(registerProvider.notifier)
                  .register(
                    name: _name.text,
                    email: _email.text,
                    password: _password.text,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
