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
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Details')),
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
              Text('Name: ${expense.name}'),
              Text('Description: ${expense.description}'),
              Text('Amount: ${expense.amount.toStringAsFixed(2)} KM'),
              Text('Category: ${expense.category}'),
            ],
          ),
        ),
      ),
    );
  }
}
