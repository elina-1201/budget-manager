import 'package:budget_manager/src/core/exceptions/async_error_listener.dart';
import 'package:budget_manager/src/core/exceptions/error_mapper.dart';
import 'package:budget_manager/src/core/storage/auth_state_provider.dart';
import 'package:budget_manager/src/features/expenses/list/providers/expense_list_notifier.dart';
import 'package:budget_manager/src/features/expenses/list/ui/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExpensesListScreen extends ConsumerStatefulWidget {
  const ExpensesListScreen({super.key});

  @override
  ConsumerState<ExpensesListScreen> createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends ConsumerState<ExpensesListScreen> {
  @override
  Widget build(BuildContext context) {
    final expensesAsync = ref.watch(expensesListProvider);
    ref.listenAsyncError(expensesListProvider, context: context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        leading: IconButton(
          icon: Icon(Icons.logout_sharp),
          onPressed: () {
            ref.read(authStateProvider.notifier).logout();
          },
        ),
      ),
      body: expensesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          final msg = const ErrorMapper().map(error).message;
          return Center(child: Text(msg));
        },
        data: (expenses) => expenses.isEmpty
            ? const Center(child: Text('No expenses yet, try adding some!'))
            : ExpensesList(expenses: expenses),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/expenses/add_expense');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
