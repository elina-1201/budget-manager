import 'package:budget_manager/core/exceptions/async_error_listener.dart';
import 'package:budget_manager/core/storage/auth_state_provider.dart';
import 'package:budget_manager/features/auth/providers/login_notifier.dart';
import 'package:budget_manager/shared/widgets/auth_fields/auth_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    ref.listenAsyncError(loginProvider, context: context);

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
              // onPressed: () async => debugPrint(ref.read(apiBaseUrlProvider)),
              onPressed: () => ref
                  .read(loginProvider.notifier)
                  .login(email: _email.text, password: _password.text),
            ),
            TextButton(
              onPressed: () => context.push('/register'),
              child: const Text('Don\'t have an account? Register here'),
            ),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authStateProvider.notifier).enterGuestMode();
              },
              child: const Text('Continue as Guest'),
            ),
          ],
        ),
      ),
    );
  }
}
