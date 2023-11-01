class Recipe {
  final int? id;
  final String key;
  final String title;
  final String imageUrl;
  final String? cookingTime; // Perbarui tipe
  final String? difficulty;   // Perbarui tipe
  final String? description;  // Perbarui tipe
  final List<String> ingredients; // Perbarui tipe
  final List<String> steps;      // Perbarui tipe

  Recipe({
    this.id,
    required this.key,
    required this.title,
    required this.imageUrl,
    this.cookingTime,   // Perbarui tipe
    this.difficulty,    // Perbarui tipe
    this.description,   // Perbarui tipe
    required this.ingredients, // Perbarui tipe
    required this.steps,      // Perbarui tipe
  });

  // Konstruktor untuk membaca data dari database.
  Recipe.fromMap(Map<String, dynamic> map):
        id = map['id'],
        key = map['key'],
        title = map['title'],
        imageUrl = map['imageUrl'],
        cookingTime = map['cookingTime'],
        difficulty = map['difficulty'],
        description = map['description'],
        ingredients = List<String>.from(map['ingredients']),
        steps = List<String>.from(map['steps']);

  // Mengonversi objek Recipe menjadi Map untuk disimpan di database.
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Kolom id otomatis dikelola oleh database.
      'key': key,
      'title': title,
      'imageUrl': imageUrl,
      'cookingTime': cookingTime,
      'difficulty': difficulty,
      'description': description,
      'ingredients': ingredients,
      'steps': steps,
    };
  }

  // Buat salinan objek Recipe dengan ID yang berbeda.
  Recipe copyWith({int? id}) {
    return Recipe(
      id: id ?? this.id,
      key: key,
      title: title,
      imageUrl: imageUrl,
      cookingTime: cookingTime,
      difficulty: difficulty,
      description: description,
      ingredients: List.from(ingredients),
      steps: List.from(steps),
    );
  }
}
