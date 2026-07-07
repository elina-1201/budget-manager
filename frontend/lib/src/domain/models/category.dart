import 'dart:ui';

class Category {
  final int id;
  final String name;
  final Color? color;

  Category({required this.id, required this.name, this.color});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      color: map['color'] != null ? Color(map['color']) : null,
    );
  }
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'color': color?.toARGB32()};
  }
}
