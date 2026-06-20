import 'package:budget_manager/core/services/local_db/database_connection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'local_db_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Database> databaseConnection(Ref ref) {
  return DatabaseConnection().initDatabase();
}
