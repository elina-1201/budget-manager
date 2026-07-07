import 'package:budget_manager/generated/l10n.dart';
import 'package:budget_manager/src/features/expenses/add/providers/selected_date_notifier.dart';
import 'package:budget_manager/src/shared/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatePicker extends ConsumerWidget {
  final TextEditingController controller;
  const DatePicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final s = S.of(context);

    if (controller.text.isEmpty && selectedDate != null) {
      _updateDateText(selectedDate);
    }

    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: s.date,
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () => _selectDate(context, ref),
      validator: Validator.required(context),
    );
  }

  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    DateTime? selectedDate = ref.read(selectedDateProvider);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      ref.read(selectedDateProvider.notifier).select(picked);
      _updateDateText(picked);
    }
  }

  void _updateDateText(DateTime? date) {
    controller.text = date != null
        ? '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}'
        : '';
  }
}
