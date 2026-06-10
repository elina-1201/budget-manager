import 'package:budget_manager/core/services/dio/dio_provider.dart';
import 'package:budget_manager/pages/register/repository/register_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_provider.g.dart';

@riverpod
RegisterRepository registerRepository(Ref ref) {
  return RegisterRepository(dio: ref.watch(dioProvider));
}
