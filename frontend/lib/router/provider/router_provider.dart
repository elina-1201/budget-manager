import 'package:budget_manager/core/services/auth/auth_storage/provider/auth_state_provider.dart';
import 'package:budget_manager/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final router = GoRouter(
    initialLocation: '/items',
    routes: routes,
    redirect: (context, state) => redirectLogic(context, state, ref),
  );

  return router;
}

String? redirectLogic(BuildContext context, GoRouterState state, Ref ref) {
  final authAsync = ref.watch(authStateProvider);
  final isAuthenticated = authAsync.asData?.value ?? false;

  const publicPaths = ['/login', '/register'];
  final isPublicPath = publicPaths.contains(state.matchedLocation);

  if (!isAuthenticated && !isPublicPath) return '/login';
  if (isAuthenticated && isPublicPath) return '/items';

  return null;
}
