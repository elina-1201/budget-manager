import 'package:budget_manager/core/services/dio/dio_provider.dart';
import 'package:budget_manager/pages/login/repository/login_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
LoginRepository loginRepository(Ref ref) {
  return LoginRepository(dio: ref.watch(dioProvider));
}
