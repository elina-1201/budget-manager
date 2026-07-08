class ExpenseRemoteRes {
  final int id;
  final String name;
  final String? description;
  final double amount;
  // final String category;
  final String date;
  final int categoryId;
  final String categoryName;
  final int categoryColor;

  ExpenseRemoteRes({
    required this.id,
    required this.name,
    this.description,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.categoryName,
    required this.categoryColor,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'amount': amount,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryColor': categoryColor,
      'date': date,
    };
  }

  factory ExpenseRemoteRes.fromMap(Map<String, dynamic> map) {
    return ExpenseRemoteRes(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      amount: map['amount'].toDouble(),
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
      categoryColor: map['categoryColor'],
      date: map['date'],
    );
  }
}
