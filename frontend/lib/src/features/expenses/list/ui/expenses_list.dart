import 'package:budget_manager/src/domain/models/expense.dart';
import 'package:budget_manager/src/features/expenses/list/ui/alert_on_delete.dart';
import 'package:budget_manager/src/features/expenses/list/ui/expense_tile.dart';
import 'package:budget_manager/src/features/expenses/list/ui/month_header.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    final groups = _groupByMonth(expenses);

    return CustomScrollView(
      slivers: [
        for (final group in groups) ...[
          MultiSliver(
            pushPinnedChildren: true,
            children: [
              SliverPinnedHeader(
                child: MonthHeader(
                  year: group.first.date.year,
                  month: group.first.date.month,
                  total: group.fold(0.0, (sum, e) => sum + e.amount),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final expense = group[index];
                  return Dismissible(
                    key: ValueKey(expense.id),
                    background: const DeleteBackground(),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (_) => AlertOnDelete(expense: expense),
                      );
                    },
                    child: ExpenseTile(expense: expense),
                  );
                }, childCount: group.length),
              ),
            ],
          ),
        ],
      ],
    );
  }

  List<List<Expense>> _groupByMonth(List<Expense> expenses) {
    final groups = <int, List<Expense>>{};
    for (final expense in expenses) {
      final key = expense.date.year * 100 + expense.date.month; // e.g. 202607
      (groups[key] ??= []).add(expense);
    }
    final keys = groups.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // newest first
    return [for (final key in keys) groups[key]!];
  }
}
