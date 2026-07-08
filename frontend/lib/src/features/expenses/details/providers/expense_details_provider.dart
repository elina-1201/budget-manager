import 'package:budget_manager/src/data/repositories/repository_providers.dart';
import 'package:budget_manager/src/domain/models/expense.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_details_provider.g.dart';

@riverpod
Future<Expense> expenseDetails(Ref ref, int expenseId) async {
  final repository = await ref.watch(expenseRepositoryProvider.future);
  return repository.getExpense(expenseId: expenseId);
}
