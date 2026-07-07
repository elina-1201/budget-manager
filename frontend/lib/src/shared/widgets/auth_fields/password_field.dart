import 'package:budget_manager/generated/l10n.dart';
import 'package:budget_manager/src/shared/validator/validator.dart';
import 'package:flutter/material.dart';

typedef ValidatorFn = String? Function(String? value);

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final bool showClearButton;
  final ValidatorFn? validator;

  const PasswordField({
    super.key,
    required this.controller,
    this.label,
    this.showClearButton = false,
    this.validator,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: widget.label ?? s.password,
        suffixIcon: _VisibilityIcon(
          obscureText: _obscureText,
          onPressed: _toggleVisibility,
        ),
      ),
      validator: widget.validator ?? Validator.passwordLength(context),
    );
  }
}

class _VisibilityIcon extends StatelessWidget {
  final bool obscureText;
  final VoidCallback onPressed;

  const _VisibilityIcon({required this.obscureText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
      ),
      iconSize: 20,
      onPressed: onPressed,
    );
  }
}
