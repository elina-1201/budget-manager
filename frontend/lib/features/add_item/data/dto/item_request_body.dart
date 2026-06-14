class ItemRequestBody {
  final String name;
  final String? description;
  final double amount;
  final List<int>? sharedGroupIds;
  final int categoryId;

  ItemRequestBody({
    required this.name,
    this.description,
    required this.amount,
    this.sharedGroupIds,
    required this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'amount': amount,
      'sharedGroupIds': sharedGroupIds,
      'categoryId': categoryId,
    };
  }

  @override
  String toString() {
    return 'ItemRequestBody(name: $name, description: $description, amount: $amount, sharedGroupIds: $sharedGroupIds, categoryId: $categoryId)';
  }
}
