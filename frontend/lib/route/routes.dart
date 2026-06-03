import 'package:budget_manager/pages/items_list/items_list_screen.dart';
import 'package:budget_manager/pages/login/login_screen.dart';
import 'package:budget_manager/pages/main/main_screen.dart';
import 'package:budget_manager/pages/register/register_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const MainScreen(),
  '/register': (context) => const RegisterScreen(),
  '/login': (context) => const LoginScreen(),
  '/items': (context) => const ItemsListScreen(),
};
