import 'package:budget_manager/features/auth/login/provider/login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/widget/auth/auth.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _navigateToItemsOnSuccess(context);

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
              onPressed: () => ref
                  .read(loginProvider.notifier)
                  .login(email: _email.text, password: _password.text),
            ),
            TextButton(
              // onPressed: () => context.push('/register'),
              onPressed: () => context.push('/register'),
              child: const Text('Don\'t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToItemsOnSuccess(BuildContext context) {
    ref.listen<AsyncValue<void>>(loginProvider, (_, state) {
      state.whenOrNull(
        data: (_) => context.pushReplacement('/items'),

        error: (error, _) => ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString()))),
      );
    });
  }
}
