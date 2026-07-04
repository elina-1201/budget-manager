import 'package:budget_manager/core/exceptions/error_mapper.dart';
import 'package:budget_manager/data/models/expense.dart';
import 'package:budget_manager/features/expenses/list/providers/expense_list_notifier.dart';
import 'package:budget_manager/shared/widgets/modal/button_type.dart';
import 'package:budget_manager/shared/widgets/modal/modal_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertOnDelete extends ConsumerWidget {
  final Expense expense;
  const AlertOnDelete({super.key, required this.expense});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("Confirm Deletion"),
      content: const Text("Are you sure you want to delete this expense?"),
      actions: [
        ModalTextButton(
          onPress: () => Navigator.of(context).pop(false),
          label: "CANCEL",
          type: ButtonType.cancel,
        ),
        ModalTextButton(
          onPress: () async {
            await _deleteExpense(expense, context, ref);
          },
          label: "DELETE",
          type: ButtonType.delete,
        ),
      ],
    );
  }

  Future<void> _deleteExpense(
    Expense expense,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final notifier = ref.read(expensesListProvider.notifier);
    await notifier.deleteExpense(expense.id!);

    if (context.mounted) {
      final currentState = ref.read(expensesListProvider);
      if (currentState.hasError) {
        final msg = const ErrorMapper().map(currentState.error!).message;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"${expense.name}" deleted successfully')),
        );
      }
      Navigator.of(context).pop(!currentState.hasError);
    }
  }
}
