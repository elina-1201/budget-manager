typedef ValidatorFn = String? Function(String? value);

abstract final class Validator {
  static ValidatorFn required({String message = 'This field is required'}) =>
      (value) => _isBlank(value) ? message : null;

  static ValidatorFn email({String message = 'Enter a valid email address'}) {
    return (value) {
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

      if (_isBlank(value) || !emailRegex.hasMatch(value!)) {
        return message;
      }
      return null;
    };
  }

  static ValidatorFn positiveNumber({
    String message = 'Must be greater than 0',
  }) => (value) {
    String validNumMessage = 'Enter a valid number';
    if (!_isBlank(value)) {
      final amountText = value!.replaceAll(',', '.');
      final number = num.tryParse(amountText);
      if (number == null) return validNumMessage;
      return number <= 0 ? message : null;
    }
    return validNumMessage;
  };

  static ValidatorFn passwordLength({
    String message = 'Password must be at least 8 characters',
  }) =>
      (value) => _isBlank(value) || value!.length < 8 ? message : null;

  static ValidatorFn passwordMatch(
    String password, {
    String message = 'Passwords do not match',
  }) =>
      (value) => _isBlank(value) || value != password ? message : null;

  static ValidatorFn compose(List<ValidatorFn> validators) => (value) {
    for (final v in validators) {
      final error = v(value);
      if (error != null) return error;
    }
    return null;
  };

  static bool _isBlank(String? value) => value == null || value.trim().isEmpty;
}
