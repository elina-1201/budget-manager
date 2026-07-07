class CategoryDB {
  final int id;
  final String name;
  final int? color; // Store color as an integer (ARGB format)

  CategoryDB({required this.id, required this.name, this.color});

  factory CategoryDB.fromMap(Map<String, dynamic> map) {
    return CategoryDB(id: map['id'], name: map['name'], color: map['color']);
  }
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'color': color};
  }
}
