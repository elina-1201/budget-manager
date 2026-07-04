import 'package:flutter/material.dart';

typedef ValidatorFn = String? Function(String? value);

class ClearableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final ValidatorFn? validator;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;

  const ClearableTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: IconButton(
          icon: const Icon(Icons.close_rounded),
          iconSize: 18,
          onPressed: () => controller.clear(),
        ),
      ),
      validator: validator,
    );
  }
}
