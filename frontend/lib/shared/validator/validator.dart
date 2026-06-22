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
      final number = num.tryParse(value!);
      if (number == null) return validNumMessage;
      return number <= 0 ? message : null;
    }
    return validNumMessage;
  };

  static ValidatorFn compose(List<ValidatorFn> validators) => (value) {
    for (final v in validators) {
      final error = v(value);
      if (error != null) return error;
    }
    return null;
  };

  static String? Function(T?) requiredSelection<T>({
    String message = 'Select an option',
  }) =>
      (value) => value == null ? message : null;

  static bool _isBlank(String? value) => value == null || value.trim().isEmpty;
}
