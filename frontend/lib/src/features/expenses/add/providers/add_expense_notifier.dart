import 'package:budget_manager/src/data/models/expense_remote_request.dart';
import 'package:budget_manager/src/data/repositories/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_expense_notifier.g.dart';

@riverpod
class AddExpenseNotifier extends _$AddExpenseNotifier {
  @override
  FutureOr<void> build() => null;

  Future<void> addExpense({
    required String name,
    required String description,
    required double amount,
    required int categoryId,
    required DateTime date,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = await ref.read(expenseRepositoryProvider.future);
      await repo.saveExpense(
        body: ExpenseRemoteReq(
          name: name,
          description: description,
          amount: amount,
          categoryId: categoryId,
          date: date
              .toIso8601String()
              .split('T')
              .first, // Format date as 'yyyy-MM-dd'
        ),
      );
    });
  }
}
