class CategoryDB {
  final int? id;
  final String name;
  final int? color; // Store color as an integer (ARGB format)

  CategoryDB({this.id, required this.name, this.color});

  factory CategoryDB.fromMap(Map<String, dynamic> map) {
    return CategoryDB(id: map['id'], name: map['name'], color: map['color']);
  }

  /// Returns a map for insertion, excluding null id so SQLite auto-generates it.
  Map<String, dynamic> toMap() {
    return {if (id != null) 'id': id, 'name': name, 'color': color};
  }
}
