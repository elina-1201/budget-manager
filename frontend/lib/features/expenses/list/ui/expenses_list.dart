import 'package:budget_manager/data/models/expense.dart';
import 'package:budget_manager/features/expenses/list/ui/alert_on_delete.dart';
import 'package:budget_manager/features/expenses/list/ui/expense_tile.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return Dismissible(
          key: ValueKey(expense.id),
          background: const DeleteBackground(),
          direction: DismissDirection.endToStart,
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertOnDelete(expense: expense);
              },
            );
          },
          child: ExpenseTile(expense: expense),
        );
      },
    );
  }
}
