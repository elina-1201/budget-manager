import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  static const String databaseName = 'budget_manager.db';
  static const int databaseVersion = 1;

  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createCategoryTable(db);
    await _createExpenseTable(db);
  }

  Future<void> _createCategoryTable(Database db) async {
    const String categoryTable = 'category';

    await db.execute('''
      CREATE TABLE $categoryTable (
        id $idType,
        name $textType UNIQUE,
        color INTEGER NOT NULL
      )
    ''');
  }

  Future<void> _createExpenseTable(Database db) async {
    const String expenseTable = 'expense';
    const String realType = 'REAL NOT NULL';

    await db.execute('''
      CREATE TABLE $expenseTable (
        id $idType,
        name $textType,
        amount $realType,
        description TEXT,
        date INTEGER NOT NULL,
        category_id INTEGER,
        FOREIGN KEY(category_id) REFERENCES category(id)
      )
    ''');
  }

  Future<void> closeDatabase(Database db) async {
    await db.close();
  }
}
