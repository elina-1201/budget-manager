class ExpenseRemoteRes {
  final String name;
  final String? description;
  final double amount;
  final String category;
  final String date;

  ExpenseRemoteRes({
    required this.name,
    this.description,
    required this.amount,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'amount': amount,
      'category': category,
      'date': date,
    };
  }

  factory ExpenseRemoteRes.fromMap(Map<String, dynamic> map) {
    return ExpenseRemoteRes(
      name: map['name'],
      description: map['description'],
      amount: map['amount'].toDouble(),
      category: map['category'],
      date: map['date'],
    );
  }
}
