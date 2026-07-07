import 'package:budget_manager/src/data/models/expense.dart';
import 'package:budget_manager/src/data/models/expense_remote_request.dart';

abstract interface class ExpenseRepository {
  Future<List<Expense>> getExpenses();
  Future<void> saveExpense({required ExpenseRemoteReq body});
  Future<void> updateExpense({required ExpenseRemoteReq body});
  Future<Expense> getExpense({required int expenseId});
  Future<void> deleteExpense({required int expenseId});
}
