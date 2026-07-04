import 'package:budget_manager/data/models/expense.dart';
import 'package:budget_manager/data/models/expense_remote_request.dart';
import 'package:budget_manager/data/models/expense_remote_response.dart';
import 'package:budget_manager/data/repositories/expense_repository.dart';
import 'package:dio/dio.dart';

class ExpenseRepositoryRemote implements ExpenseRepository {
  final Dio _dio;
  ExpenseRepositoryRemote({required this._dio});

  @override
  Future<List<Expense>> getExpenses() async {
    final response = await _dio.get('/expense');

    return (response.data as List)
        .map((e) => toDomain(ExpenseRemoteRes.fromMap(e)))
        .toList();
  }

  @override
  Future<void> saveExpense({required ExpenseRemoteReq body}) async {
    await _dio.post('/expense', data: body.toMap());
  }

  @override
  Future<void> updateExpense({required ExpenseRemoteReq body}) async {
    // TODO: implement updateExpense
    throw UnimplementedError();
  }

  @override
  Future<void> deleteExpense({required int expenseId}) async {
    await _dio.delete('/expense/$expenseId');
  }

  @override
  Future<Expense> getExpense({required int expenseId}) {
    // TODO: implement getExpense
    throw UnimplementedError();
  }

  Expense toDomain(ExpenseRemoteRes remote) => Expense(
    name: remote.name,
    description: remote.description,
    amount: remote.amount,
    category: remote.category,
    date: DateTime.parse(remote.date), // "2026-07-04" → DateTime
  );
}
