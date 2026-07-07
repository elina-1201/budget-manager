import 'package:budget_manager/generated/l10n.dart';
import 'package:budget_manager/src/core/exceptions/error_mapper.dart';
import 'package:budget_manager/src/data/models/expense.dart';
import 'package:budget_manager/src/features/expenses/list/providers/expense_list_notifier.dart';
import 'package:budget_manager/src/shared/widgets/modal/modal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertOnDelete extends ConsumerWidget {
  final Expense expense;
  const AlertOnDelete({super.key, required this.expense});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    return AlertDialog(
      title: Text(s.confirm_deletion),
      content: Text(s.confirm_delete_expense),
      actions: [
        ModalTextButton(
          onPress: () => Navigator.of(context).pop(false),
          label: s.cancel,
          type: ButtonType.cancel,
        ),
        ModalTextButton(
          onPress: () async {
            await _deleteExpense(expense, context, ref);
          },
          label: s.delete,
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
          SnackBar(
            content: Text(S.of(context).deleted_successfully(expense.name)),
          ),
        );
      }
      Navigator.of(context).pop(!currentState.hasError);
    }
  }
}
