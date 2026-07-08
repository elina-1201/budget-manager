import 'dart:ui';

import 'package:budget_manager/src/data/models/expense_remote_request.dart';
import 'package:budget_manager/src/data/models/expense_remote_response.dart';
import 'package:budget_manager/src/data/repositories/expense_repository.dart';
import 'package:budget_manager/src/domain/models/category.dart';
import 'package:budget_manager/src/domain/models/expense.dart';
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
    id: remote.id,
    name: remote.name,
    description: remote.description,
    amount: remote.amount,
    category: Category(
      id: remote.categoryId,
      name: remote.categoryName,
      color: Color(remote.categoryColor),
    ),
    date: DateTime.parse(remote.date), // "2026-07-04" → DateTime
  );
}
