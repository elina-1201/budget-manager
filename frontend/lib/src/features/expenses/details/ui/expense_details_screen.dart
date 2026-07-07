import 'package:budget_manager/generated/l10n.dart';
import 'package:budget_manager/src/core/exceptions/error_mapper.dart';
import 'package:budget_manager/src/features/expenses/details/providers/expense_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseDetailsScreen extends ConsumerWidget {
  final int expenseId;
  const ExpenseDetailsScreen({super.key, required this.expenseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseAsync = ref.watch(expenseDetailsProvider(expenseId));
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.expense_details)),
      body: expenseAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          final msg = const ErrorMapper().map(error).message;
          return Center(child: Text(msg));
        },
        data: (expense) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(s.expense_name_label(expense.name)),
              Text(s.expense_description_label(expense.description ?? '')),
              //TODO: Use currency from expense object instead of hardcoding "KM"
              Text(
                s.expense_amount_label(expense.amount.toStringAsFixed(2), "KM"),
              ),
              Text(s.expense_category_label(expense.category)),
            ],
          ),
        ),
      ),
    );
  }
}
