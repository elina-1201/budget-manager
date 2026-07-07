import 'dart:math';

import 'package:budget_manager/generated/l10n.dart';
import 'package:budget_manager/src/features/expenses/add/providers/selected_notifier.dart';
import 'package:budget_manager/src/shared/widgets/modal/modal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomColorPicker extends ConsumerWidget {
  const CustomColorPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomColor = Color.fromARGB(
      255,
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
    );

    final selectedColor = ref.watch(selectedColorProvider) ?? randomColor;

    return GestureDetector(
      onTap: () => _openColorPicker(context, ref, pickerColor: selectedColor),
      child: CircleAvatar(radius: 18, backgroundColor: selectedColor),
    );
  }

  void _openColorPicker(
    BuildContext context,
    WidgetRef ref, {
    required Color pickerColor,
  }) {
    final presetColors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.blueGrey,
    ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context).pickColor),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...presetColors.map((color) {
              final isSelected = ref.read(selectedColorProvider) == color;
              return GestureDetector(
                onTap: () {
                  ref.read(selectedColorProvider.notifier).select(color);
                  Navigator.of(ctx).pop();
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: color,
                  child: isSelected
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : null,
                ),
              );
            }),
            ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) {
                ref.read(selectedColorProvider.notifier).select(color);
              },
            ),
          ],
        ),
        actions: <Widget>[
          ModalTextButton(
            onPress: () {
              Navigator.of(ctx).pop();
            },
            label: S.of(context).cancel,
            type: ButtonType.cancel,
          ),
          ModalOutlinedButton(
            onPress: () {
              Navigator.of(ctx).pop();
            },
            label: S.of(context).add,
          ),
        ],
      ),
    );
  }
}
