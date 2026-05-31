import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;

  const EmailField({super.key, required this.controller, this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: label ?? 'Email'),
    );
  }
}
