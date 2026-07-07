import 'package:budget_manager/src/features/auth/ui/login_screen.dart';
import 'package:budget_manager/src/features/auth/ui/register_screen.dart';
import 'package:budget_manager/src/features/expenses/add/ui/add_expense_screen.dart';
import 'package:budget_manager/src/features/expenses/details/ui/expense_details_screen.dart';
import 'package:budget_manager/src/features/expenses/list/ui/expenses_list_screen.dart';
import 'package:budget_manager/src/router/app_shell.dart';
import 'package:budget_manager/src/shared/splash_screen/splash_screen.dart';
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
            path: '/expenses',
            builder: (_, _) => const ExpensesListScreen(),
            routes: [
              GoRoute(
                path: 'add_expense',
                builder: (_, _) => const AddExpenseScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/expense_details/:expenseId',
            builder: (_, state) {
              final int id = _parseIntParam(state, 'expenseId');
              return ExpenseDetailsScreen(expenseId: id);
            },
          ),
        ],
      ),
      StatefulShellBranch(
        //TODO: Implement stats screen
        routes: [GoRoute(path: '/stats', builder: (_, _) => const Scaffold())],
      ),
    ],
  ),
];

int _parseIntParam(GoRouterState state, String key) {
  final raw = state.pathParameters[key];
  final parsed = raw != null ? int.tryParse(raw) : null;
  if (parsed == null) throw FormatException('Invalid parameter: $key');
  return parsed;
}
