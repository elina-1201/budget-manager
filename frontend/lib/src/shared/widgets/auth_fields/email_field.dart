import 'package:budget_manager/generated/l10n.dart';
import 'package:budget_manager/src/shared/validator/validator.dart';
import 'package:budget_manager/src/shared/widgets/clearable_text_field.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final bool showClearButton;

  const EmailField({
    super.key,
    required this.controller,
    this.label,
    this.showClearButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final emailLabel = label ?? s.email;
    final field = TextFormField(
      controller: controller,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: emailLabel),
      validator: Validator.email(context),
    );

    return showClearButton
        ? ClearableTextField(
            controller: controller,
            labelText: emailLabel,
            validator: Validator.email(context),
          )
        : field;
  }
}
