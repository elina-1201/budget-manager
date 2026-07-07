import 'package:budget_manager/src/core/storage/auth_state_provider.dart';
import 'package:budget_manager/src/features/auth/data/register_request_body.dart';
import 'package:budget_manager/src/features/auth/providers/register_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_notifier.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  FutureOr<void> build() => null;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final tokens = await ref
          .read(registerRepositoryProvider)
          .register(
            RegisterRequestBody(name: name, email: email, password: password),
          );

      final accessToken = tokens.accessToken;
      final refreshToken = tokens.refreshToken;

      await ref
          .read(authStateProvider.notifier)
          .storeTokensOnAuth(accessToken, refreshToken);
    });
  }
}
