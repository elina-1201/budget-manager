import 'package:budget_manager/pages/add_item/add_item_screen.dart';
import 'package:budget_manager/pages/items_list/items_list_screen.dart';
import 'package:budget_manager/pages/login/login_screen.dart';
import 'package:budget_manager/pages/register/register_screen.dart';
import 'package:budget_manager/shared_widgets/auth/app_shel/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> routes = [
  GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
  GoRoute(path: '/register', builder: (_, _) => const RegisterScreen()),

  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        AppShell(navigationShell: navigationShell),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(path: '/items', builder: (_, _) => const ItemsListScreen()),
          GoRoute(path: '/add_item', builder: (_, _) => const AddItemScreen()),
        ],
      ),
      StatefulShellBranch(
        routes: [GoRoute(path: '/stats', builder: (_, _) => const Scaffold())],
      ),
    ],
  ),
];
