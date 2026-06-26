import 'package:budget_manager/core/services/auth/auth_mode_enum.dart';
import 'package:budget_manager/core/services/auth/storage/provider/auth_state_provider.dart';
import 'package:budget_manager/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final authState = ref.watch(authStateProvider);

  final router = GoRouter(
    initialLocation: '/splash',
    routes: routes,
    redirect: (context, state) => redirectLogic(context, state, authState),
  );

  return router;
}

String? redirectLogic(
  BuildContext context,
  GoRouterState state,
  AsyncValue<AuthMode> authState,
) {
  final path = state.uri.toString();

  if (authState.isLoading) {
    return path == '/splash' ? null : '/splash';
  }

  final authMode = authState.asData?.value;
  final hasAccess =
      authMode == AuthMode.authenticated || authMode == AuthMode.guest;

  if (path == '/splash') {
    if (authMode != AuthMode.unauthenticated) {
      return '/items';
    } else {
      return '/login';
    }
  }

  const publicPaths = ['/login', '/register'];
  final isPublicPath = publicPaths.contains(state.matchedLocation);

  if (!hasAccess && !isPublicPath) return '/login';
  if (hasAccess && isPublicPath) return '/items';

  return null;
}
