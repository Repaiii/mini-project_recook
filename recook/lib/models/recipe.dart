class Recipe {
  final int? id;
  final String key;
  final String title;
  final String imageUrl;

  Recipe({
    this.id,
    required this.key,
    required this.title,
    required this.imageUrl,
  });

  Recipe.fromMap(Map<String, dynamic> map):
        id = map['id'],
        key = map['key'],
        title = map['title'],
        imageUrl = map['imageUrl'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'title': title,
      'imageUrl': imageUrl,
    };
  }

  Recipe copyWith({int? id}) {
    return Recipe(
      id: id ?? this.id,
      key: key,
      title: title,
      imageUrl: imageUrl,
    );
  }
}
