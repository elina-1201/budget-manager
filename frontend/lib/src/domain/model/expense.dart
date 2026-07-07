class Expense {
  final int id;
  final String name;
  final String? description;
  final double amount;
  final String category;
  final DateTime date;

  Expense({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });
}
