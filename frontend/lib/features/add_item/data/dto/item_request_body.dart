class ItemRequestBody {
  final String name;
  final String description;
  final double amount;
  final List<int> sharedGroupIds;
  final int categoryId;

  ItemRequestBody({
    required this.name,
    required this.description,
    required this.amount,
    required this.sharedGroupIds,
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
}
