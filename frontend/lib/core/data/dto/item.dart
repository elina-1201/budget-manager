class Item {
  final int? id;
  final String name;
  final String? description;
  final double amount;
  final String category;

  Item({
    this.id,
    required this.name,
    this.description,
    required this.amount,
    required this.category,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      amount: map['amount'].toDouble(),
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'amount': amount,
      'category': category,
    };
  }
}
