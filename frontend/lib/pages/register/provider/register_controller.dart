import 'package:budget_manager/pages/register/dto/register_request_body.dart';
import 'package:budget_manager/pages/register/provider/register_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<void> build() => null;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(registerRepositoryProvider)
          .register(
            RegisterRequestBody(name: name, email: email, password: password),
          );
    });
  }
}
