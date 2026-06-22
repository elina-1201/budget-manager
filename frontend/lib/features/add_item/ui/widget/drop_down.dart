import 'package:budget_manager/shared/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenericDropDown<T> extends ConsumerWidget {
  final AsyncValue<List<T>> list;
  final T? selected;
  final void Function(T?) onChanged;
  final String Function(T) itemLabel;

  const GenericDropDown({
    super.key,
    required this.list,
    this.selected,
    required this.onChanged,
    required this.itemLabel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField<T>(
      hint: const Text('Select an option'),
      isExpanded: true,
      initialValue: selected,
      onChanged: onChanged,
      items: list.when(
        data: (items) => items.map<DropdownMenuItem<T>>((T item) {
          return DropdownMenuItem<T>(value: item, child: Text(itemLabel(item)));
        }).toList(),
        loading: () => [DropdownMenuItem<T>(child: Text('Loading options...'))],
        error: (_, _) => [
          DropdownMenuItem<T>(child: Text('Error loading options')),
        ],
      ),
      validator: Validator.requiredSelection<T>(
        message: 'Please select an option',
      ),
    );
  }
}
