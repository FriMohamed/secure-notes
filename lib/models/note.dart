class Note {
  int? id;
  final String title;
  final String description;
  final DateTime createdAt;
  int? orderIndex;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.orderIndex,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt'] as String),
      orderIndex: map['order_index'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'order_index': orderIndex,
    };
  }

  Map<String, dynamic> toInsertMap() {
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
