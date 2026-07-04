import 'package:budget_manager/core/database/database_provider.dart';
import 'package:budget_manager/core/http/dio_provider.dart';
import 'package:budget_manager/core/storage/auth_state.dart';
import 'package:budget_manager/core/storage/auth_state_provider.dart';
import 'package:budget_manager/data/repositories/category_repository.dart';
import 'package:budget_manager/data/repositories/category_repository_local.dart';
import 'package:budget_manager/data/repositories/category_repository_remote.dart';
import 'package:budget_manager/data/repositories/expense_repository.dart';
import 'package:budget_manager/data/repositories/expense_repository_local.dart';
import 'package:budget_manager/data/repositories/expense_repository_remote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

@riverpod
Future<CategoryRepository> categoryRepository(Ref ref) async {
  final mode = ref.watch(authStateProvider).asData?.value;
  if (mode == AuthMode.authenticated) {
    return CategoryRepositoryRemote(dio: ref.watch(dioProvider));
  }
  final db = await ref.watch(databaseConnectionProvider.future);
  return CategoryRepositoryLocal(db: db);
}

@riverpod
Future<ExpenseRepository> expenseRepository(Ref ref) async {
  final mode = ref.watch(authStateProvider).asData?.value;
  if (mode == AuthMode.authenticated) {
    return ExpenseRepositoryRemote(dio: ref.watch(dioProvider));
  }
  final db = await ref.read(databaseConnectionProvider.future);
  return ExpenseRepositoryLocal(db: db);
}
