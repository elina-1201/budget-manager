class Item {
  final int? id;
  final String name;
  final String? description;
  final double amount;
  final String category;
  final int? date;

  Item({
    this.id,
    required this.name,
    this.description,
    required this.amount,
    required this.category,
    this.date,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      amount: map['amount'].toDouble(),
      category: map['category'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'amount': amount,
      'category': category,
      'date': date,
    };
  }
}
