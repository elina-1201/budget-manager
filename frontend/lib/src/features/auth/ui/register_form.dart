import 'package:budget_manager/generated/l10n.dart';
import 'package:budget_manager/src/core/exceptions/async_error_listener.dart';
import 'package:budget_manager/src/features/auth/providers/register_notifier.dart';
import 'package:budget_manager/src/shared/validator/validator.dart';
import 'package:budget_manager/src/shared/widgets/auth_fields/auth_fields.dart';
import 'package:budget_manager/src/shared/widgets/clearable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _repeatPassword;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _repeatPassword = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _repeatPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listenAsyncError(registerProvider, context: context);
    final s = S.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 0.0),

        child: Form(
          key: _formKey,
          child: Column(
            spacing: 14.0,
            children: [
              ClearableTextField(
                controller: _name,
                labelText: s.name,
                validator: Validator.required(context),
              ),
              EmailField(controller: _email, showClearButton: true),
              PasswordField(controller: _password, showClearButton: true),
              PasswordField(
                controller: _repeatPassword,
                label: s.repeat_password,
                showClearButton: true,
                validator: (value) =>
                    Validator.passwordMatch(context, _password.text)(value),
              ),

              const SizedBox(height: 12),
              AuthButton(
                buttonText: s.register,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(registerProvider.notifier)
                        .register(
                          name: _name.text,
                          email: _email.text,
                          password: _password.text,
                        );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
