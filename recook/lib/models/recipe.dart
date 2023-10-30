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

  // Konstruktor untuk membaca data dari database.
  Recipe.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        key = map['key'],
        title = map['title'],
        imageUrl = map['imageUrl'];

  // Mengonversi objek Recipe menjadi Map untuk disimpan di database.
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Kolom id otomatis dikelola oleh database.
      'key': key,
      'title': title,
      'imageUrl': imageUrl,
    };
  }

  // Buat salinan objek Recipe dengan ID yang berbeda.
  Recipe copyWith({int? id}) {
    return Recipe(
      id: id ?? this.id,
      key: key,
      title: title,
      imageUrl: imageUrl,
    );
  }
}
