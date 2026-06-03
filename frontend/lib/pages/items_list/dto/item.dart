class Item {
  final int id;
  final String name;
  final String description;
  final double amount;
  final String category;

  Item({
    required this.id,
    required this.name,
    required this.description,
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
}
