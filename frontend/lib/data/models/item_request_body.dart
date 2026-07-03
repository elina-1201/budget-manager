class ItemRequestBody {
  final String name;
  final String? description;
  final double amount;
  final List<int>? sharedGroupIds;
  final int categoryId;
  final DateTime date;

  ItemRequestBody({
    required this.name,
    this.description,
    required this.amount,
    this.sharedGroupIds,
    required this.categoryId,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'amount': amount,
      'sharedGroupIds': sharedGroupIds,
      'categoryId': categoryId,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'ItemRequestBody(name: $name, description: $description, amount: $amount, sharedGroupIds: $sharedGroupIds, categoryId: $categoryId, date: $date)';
  }
}
