class ItemLocalModel {
  final String name;
  final String? description;
  final double amount;
  final String categoryName;

  ItemLocalModel({
    required this.name,
    this.description,
    required this.amount,
    required this.categoryName,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'amount': amount,
      'category': categoryName,
    };
  }
}
