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
  AsyncValue<bool> authState,
) {
  if (authState.isLoading) {
    return state.uri.toString() == '/splash' ? null : '/splash';
  }

  final isAuthenticated = authState.asData?.value ?? false;

  if (state.uri.toString() == '/splash') {
    return isAuthenticated ? '/items' : '/login';
  }

  const publicPaths = ['/login', '/register'];

  final isPublicPath = publicPaths.contains(state.matchedLocation);

  if (!isAuthenticated && !isPublicPath) return '/login';
  if (isAuthenticated && isPublicPath) return '/items';

  return null;
}
