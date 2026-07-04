import 'package:budget_manager/data/models/category.dart';
import 'package:budget_manager/data/models/expense.dart';
import 'package:budget_manager/data/models/expense_local.dart';
import 'package:budget_manager/data/models/expense_remote_request.dart';
import 'package:budget_manager/data/repositories/expense_repository.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseRepositoryLocal implements ExpenseRepository {
  final Database db;
  ExpenseRepositoryLocal({required this.db});

  static const String tableName = 'expense';

  @override
  Future<List<Expense>> getExpenses() async {
    final rows = await db.query(tableName, orderBy: 'date DESC');
    if (rows.isEmpty) return [];
    return rows.map((row) => toDomain(ExpenseLocal.fromMap(row))).toList();
  }

  @override
  Future<void> saveExpense({required ExpenseRemoteReq body}) async {
    final rows = await db.query(
      'category',
      where: 'id = ?',
      whereArgs: [body.categoryId],
    );

    final Category category = rows.map((row) => Category.fromMap(row)).first;
    final int dateInMillis = DateTime.parse(body.date).millisecondsSinceEpoch;

    ExpenseLocal expense = ExpenseLocal(
      name: body.name,
      description: body.description,
      amount: body.amount,
      category: category.name,
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
    final rows = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [expenseId],
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
    category: local.category,
    date: DateTime.fromMillisecondsSinceEpoch(local.date), // ms → DateTime
  );
}
