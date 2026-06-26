import 'package:budget_manager/core/data/dto/item.dart';
import 'package:budget_manager/features/add_item/ui/add_item_screen.dart';
import 'package:budget_manager/features/auth/login/ui/login_screen.dart';
import 'package:budget_manager/features/auth/register/ui/register_screen.dart';
import 'package:budget_manager/features/item_details/item_details_screen.dart';
import 'package:budget_manager/features/items_list/ui/items_list_screen.dart';
import 'package:budget_manager/shared/app_shell/app_shell.dart';
import 'package:budget_manager/shared/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> routes = [
  GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
  GoRoute(path: '/register', builder: (_, _) => const RegisterScreen()),
  GoRoute(path: '/splash', builder: (_, _) => const SplashScreen()),

  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        AppShell(navigationShell: navigationShell),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/items',
            builder: (_, _) => const ItemsListScreen(),
            routes: [
              GoRoute(
                path: 'add_item',
                builder: (_, _) => const AddItemScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/item_details',
            builder: (_, state) {
              Item item = state.extra as Item;
              return ItemDetailsScreen(item: item);
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [GoRoute(path: '/stats', builder: (_, _) => const Scaffold())],
      ),
    ],
  ),
];
