import 'package:budget_manager/src/core/exceptions/async_error_listener.dart';
import 'package:budget_manager/src/core/storage/auth_state_provider.dart';
import 'package:budget_manager/src/features/auth/providers/login_notifier.dart';
import 'package:budget_manager/src/shared/widgets/auth_fields/auth_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();

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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 14.0,
            children: [
              EmailField(controller: _email, showClearButton: true),
              PasswordField(controller: _password, showClearButton: true),

              TextButton(
                onPressed: () => context.push('/register'),
                child: const Text('Don\'t have an account? Register here'),
              ),

              AuthButton(
                buttonText: 'Login',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(loginProvider.notifier)
                        .login(email: _email.text, password: _password.text);
                  }
                },
              ),

              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 69.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await ref.read(authStateProvider.notifier).enterGuestMode();
                  },
                  child: const Text('Continue as Guest'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
