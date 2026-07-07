import 'package:budget_manager/src/core/database/database_connection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Database> databaseConnection(Ref ref) {
  return DatabaseConnection().initDatabase();
}
