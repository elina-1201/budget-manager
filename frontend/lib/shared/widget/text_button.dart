import 'package:budget_manager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ModalTextButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String _label;
  // final ButtonType? _type;
  const ModalTextButton({super.key, this.onPress, required this._label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Text(
        _label,
        style: switch (_label.toUpperCase()) {
          "CANCEL" => TextStyle(color: AppColors.bluish),
          "DELETE" => TextStyle(color: AppColors.error),
          _ => TextStyle(color: AppColors.goldLight),
        },
      ),
    );
  }
}
