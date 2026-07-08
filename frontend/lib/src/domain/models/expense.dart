import 'dart:ui';

import 'package:budget_manager/src/domain/models/category.dart';

class Expense {
  final int? id;
  final String name;
  final String? description;
  final double amount;
  final Category category;
  final DateTime date;

  Expense({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      amount: map['amount'].toDouble(),
      category: Category(
        id: map['category_id'],
        name: map['category_name'] ?? 'Undefined',
        color: map['category_color'] != null
            ? Color(map['category_color'])
            : null,
      ),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'amount': amount,
      'category_id': category.id,
      'date': date.millisecondsSinceEpoch,
    };
  }
}
