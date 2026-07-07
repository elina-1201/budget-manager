import 'package:budget_manager/src/data/models/expense.dart';
import 'package:budget_manager/src/data/repositories/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_list_notifier.g.dart';

@Riverpod(keepAlive: true)
class ExpensesListNotifier extends _$ExpensesListNotifier {
  @override
  Future<List<Expense>> build() async {
    final repository = await ref.watch(expenseRepositoryProvider.future);
    return repository.getExpenses();
  }

  Future<void> deleteExpense(int expenseId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = await ref.read(expenseRepositoryProvider.future);
      await repository.deleteExpense(expenseId: expenseId);
      return repository.getExpenses();
    });
  }
}
