class ExpenseLocal {
  final int? id;
  final String name;
  final String? description;
  final double amount;
  final int categoryId;
  final int date;
  final String? categoryName;
  final int? categoryColor;

  ExpenseLocal({
    this.id,
    required this.name,
    this.description,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.categoryName,
    this.categoryColor,
  });

  factory ExpenseLocal.fromMap(Map<String, dynamic> map) {
    return ExpenseLocal(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      amount: map['amount'].toDouble(),
      categoryId: map['category_id'],
      date: map['date'],
      categoryName: map['category_name'],
      categoryColor: map['category_color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'amount': amount,
      'category_id': categoryId,
      'date': date,
    };
  }
}
