import 'package:flutter/material.dart';

class ModalOutlinedButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String _label;
  const ModalOutlinedButton({super.key, this.onPress, required this._label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPress,
      child: Text(_label.toUpperCase()),
    );
  }
}
