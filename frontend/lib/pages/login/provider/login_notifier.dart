import 'package:budget_manager/core/services/auth/auth_storage/provider/auth_state_provider.dart';
import 'package:budget_manager/pages/login/dto/login_request_body.dart';
import 'package:budget_manager/pages/login/provider/login_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_notifier.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  FutureOr<void> build() => null;

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref
          .read(loginRepositoryProvider)
          .login(LoginRequestBody(email: email, password: password));

      await ref
          .read(authStateProvider.notifier)
          .storeTokensOnAuth(response.accessToken, response.refreshToken);
    });
  }
}
