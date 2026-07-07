import 'package:budget_manager/src/core/theme/app_colors.dart';
import 'package:budget_manager/src/shared/widgets/modal/button_type.dart';
import 'package:flutter/material.dart';

class ModalTextButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String _label;
  final ButtonType? _type;
  const ModalTextButton({
    super.key,
    this.onPress,
    required this._label,
    this._type,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Text(
        _label.toUpperCase(),
        style: switch (_type) {
          ButtonType.cancel => TextStyle(color: AppColors.bluish),
          ButtonType.delete => TextStyle(color: AppColors.error),
          null => TextStyle(color: AppColors.goldLight),
        },
      ),
    );
  }
}
