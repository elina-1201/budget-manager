import 'dart:ui';

import 'package:budget_manager/src/data/models/expense_local.dart';
import 'package:budget_manager/src/data/models/expense_remote_request.dart';
import 'package:budget_manager/src/data/repositories/expense_repository.dart';
import 'package:budget_manager/src/domain/models/category.dart';
import 'package:budget_manager/src/domain/models/expense.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseRepositoryLocal implements ExpenseRepository {
  final Database db;
  ExpenseRepositoryLocal({required this.db});

  static const String tableName = 'expense';
  static const String selectionFields = '''
          expense.*, 
          category.name as category_name, 
          category.color as category_color, 
          category.id as cat_id
          ''';

  @override
  Future<List<Expense>> getExpenses() async {
    final rows = await db.rawQuery('''
            SELECT $selectionFields
            FROM $tableName
            LEFT JOIN category ON $tableName.category_id = category.id
            ORDER BY date DESC
            ''');
    if (rows.isEmpty) return [];
    return rows.map((row) => toDomain(ExpenseLocal.fromMap(row))).toList();
  }

  @override
  Future<void> saveExpense({required ExpenseRemoteReq body}) async {
    final int dateInMillis = DateTime.parse(body.date).millisecondsSinceEpoch;

    ExpenseLocal expense = ExpenseLocal(
      name: body.name,
      description: body.description,
      amount: body.amount,
      categoryId: body.categoryId,
      date: dateInMillis,
    );

    await db.insert(tableName, expense.toMap());
  }

  @override
  Future<void> updateExpense({required ExpenseRemoteReq body}) async {
    // TODO: implement updateExpense
    throw UnimplementedError();
  }

  @override
  Future<void> deleteExpense({required int expenseId}) async {
    await db.delete(tableName, where: 'id = ?', whereArgs: [expenseId]);
  }

  @override
  Future<Expense> getExpense({required int expenseId}) async {
    final rows = await db.rawQuery(
      '''
    SELECT $selectionFields
    FROM $tableName
    LEFT JOIN category ON $tableName.category_id = category.id
    WHERE $tableName.id = ?
    ''',
      [expenseId],
    );

    if (rows.isEmpty) {
      throw Exception('Expense not found');
    }
    return toDomain(ExpenseLocal.fromMap(rows.first));
  }

  Expense toDomain(ExpenseLocal local) => Expense(
    id: local.id!,
    name: local.name,
    description: local.description,
    amount: local.amount,
    category: Category(
      id: local.categoryId,
      name: local.categoryName ?? 'Undefined',
      color: local.categoryColor != null ? Color(local.categoryColor!) : null,
    ),
    date: DateTime.fromMillisecondsSinceEpoch(local.date), // ms → DateTime
  );
}
