import 'package:budget_manager/pages/login/dto/login_request_body.dart';
import 'package:budget_manager/pages/login/provider/login_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() => null;

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(loginRepositoryProvider)
          .login(LoginRequestBody(email: email, password: password));
    });
  }
}
