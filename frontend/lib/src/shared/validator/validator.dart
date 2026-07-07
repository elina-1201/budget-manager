import 'package:budget_manager/generated/l10n.dart';
import 'package:flutter/material.dart';

typedef ValidatorFn = String? Function(String? value);

abstract final class Validator {
  static ValidatorFn required(BuildContext context) =>
      (value) => _isBlank(value) ? S.of(context).required_field : null;

  static ValidatorFn email(BuildContext context) {
    return (value) {
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

      if (_isBlank(value) || !emailRegex.hasMatch(value!)) {
        return S.of(context).valid_email;
      }
      return null;
    };
  }

  static ValidatorFn positiveNumber(BuildContext context) => (value) {
    if (!_isBlank(value)) {
      final amountText = value!.replaceAll(',', '.');
      final number = num.tryParse(amountText);
      if (number == null) return S.of(context).valid_number;
      return number <= 0 ? S.of(context).positive_number : null;
    }
    return S.of(context).valid_number;
  };

  static ValidatorFn passwordLength(BuildContext context) =>
      (value) => _isBlank(value) || value!.length < 8
      ? S.of(context).password_length
      : null;

  static ValidatorFn passwordMatch(BuildContext context, String password) =>
      (value) => _isBlank(value) || value != password
      ? S.of(context).passwords_match
      : null;

  static ValidatorFn compose(List<ValidatorFn> validators) => (value) {
    for (final v in validators) {
      final error = v(value);
      if (error != null) return error;
    }
    return null;
  };

  static bool _isBlank(String? value) => value == null || value.trim().isEmpty;
}
